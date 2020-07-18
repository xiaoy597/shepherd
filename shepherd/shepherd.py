# -*- coding: utf-8 -*-

import os
import shutil
import json
import logging
import logging.config
import subprocess
import time
import sys
import signal

import mysql.connector

from io import BytesIO
import pycurl
import urllib.request
import urllib.parse

from datetime import datetime
from datetime import timedelta

import tornado.web
from mysql.connector import OperationalError
from tornado.ioloop import IOLoop

from apscheduler.schedulers.tornado import TornadoScheduler
from apscheduler.jobstores.base import JobLookupError
from threading import RLock

from crawl_job import CrawlJob
from clematis_wrapper.clematis.mysql_utils import MySQLUtils

from logging_conf import LOGGING_CONF

def onSignal(sigNumber, frame):
    print(f"Exiting on signal {sigNumber}...")
    sys.exit(0)


class SpiderConfigRequestHandler(tornado.web.RequestHandler):
    def data_received(self, chunk):
        pass

    def __init__(self, *args, **kwargs):
        super(SpiderConfigRequestHandler, self).__init__(*args, **kwargs)

        self.logger = logging.getLogger(self.__class__.__name__)
        self.logger.info("Instance created.")
        self.shepherd = shepherd

    def post(self, *args, **kwargs):
        user_id = self.get_argument('user_id')
        job_id = self.get_argument('job_id')

        self.logger.debug("Getting job configuration for user %s and job %s", user_id, job_id)

        conn = mysql.connector.connect(host=os.getenv('SHEPHERD_DB_HOST'),
                                       port=int(os.getenv('SHEPHERD_DB_PORT', '3306')),
                                       user=os.getenv('SHEPHERD_DB_USER'),
                                       passwd=os.getenv('SHEPHERD_DB_PASS'),
                                       charset='utf8')

        job = CrawlJob().load(int(user_id), int(job_id), conn)

        self.logger.debug(job.fields)

        json_data = json.dumps(job.fields, indent=4)
        self.write(json_data)

        conn.close()


class UpdateStatusRequestHandler(tornado.web.RequestHandler):
    def data_received(self, chunk):
        pass

    def __init__(self, *args, **kwargs):
        super(UpdateStatusRequestHandler, self).__init__(*args, **kwargs)

        self.logger = logging.getLogger(self.__class__.__name__)
        self.logger.info("Instance created.")

        self.shepherd = shepherd

    def post(self, *args, **kwargs):
        stats_info = {
            'user_id': self.get_argument('user_id'),
            'job_id': self.get_argument('job_id'),
            'start_time': self.get_argument('start_time'),
            'run_status': self.get_argument('run_status'),
            'download_num': self.get_argument('download_num'),
            'pending_num': self.get_argument('pending_num'),
            'error_num': self.get_argument('error_num'),
        }

        self.logger.debug(stats_info)

        self.save_stats_info(stats_info)

    def save_stats_info(self, stats_info):
        conn = None
        try:
            conn = mysql.connector.connect(host=os.getenv('SHEPHERD_DB_HOST'),
                                           port=int(os.getenv('SHEPHERD_DB_PORT', '3306')),
                                           user=os.getenv('SHEPHERD_DB_USER'),
                                           passwd=os.getenv('SHEPHERD_DB_PASS'),
                                           charset='utf8')
            conn.autocommit = True

            sql = '''insert into {db}.{table_name} (
                          user_id, job_id, start_time, run_status, download_page_num,
                          pending_page_num, error_page_num)
                      values (%s, %s, %s, %s, %s, %s, %s)
                      on duplicate key update
                        run_status = %s,
                        download_page_num = %s,
                        pending_page_num = %s,
                        error_page_num = %s
                      '''.format(db=os.getenv('SHEPHERD_DB_NAME'), table_name='crawl_status')

            cursor = conn.cursor()

            sql_param = (
                stats_info['user_id'],
                stats_info['job_id'],
                stats_info['start_time'],
                stats_info['run_status'],
                stats_info['download_num'],
                stats_info['pending_num'],
                stats_info['error_num'],
                stats_info['run_status'],
                stats_info['download_num'],
                stats_info['pending_num'],
                stats_info['error_num'],
            )

            cursor.execute(sql, sql_param)

            cursor.close()
        except Exception:
            self.logger.exception("Failed to save stats info.")
        finally:
            conn.close()


class JobControlRequestHandler(tornado.web.RequestHandler):
    def data_received(self, chunk):
        pass

    def __init__(self, *args, **kwargs):

        super(JobControlRequestHandler, self).__init__(*args, **kwargs)

        self.logger = logging.getLogger(self.__class__.__name__)

        self.commands = {
            'start': self.start_job,
            'stop': self.stop_job,
            'update': self.update_job,
            'create': self.create_job,
        }

        self.shepherd = shepherd

    def post(self, *args, **kwargs):

        self.commands[self.get_argument('command')]()

    def update_job(self):
        user_id = int(self.get_argument('user_id'))
        job_id = int(self.get_argument('job_id'))

        try:
            self.shepherd.update_job(user_id, job_id)
        except Exception as e:
            self.logger.exception("Error")
        else:
            self.write("DONE")

    def stop_job(self):
        user_id = int(self.get_argument('user_id'))
        job_id = int(self.get_argument('job_id'))

        try:
            self.shepherd.job_controller.stop_job(user_id, job_id)
        except Exception as e:
            self.logger.exception("Error:")
        else:
            self.write("DONE")

    def start_job(self):
        user_id = int(self.get_argument('user_id'))
        job_id = int(self.get_argument('job_id'))

        try:
            self.shepherd.job_controller.start_job(user_id, job_id)
        except Exception as e:
            self.logger.exception("Error:")
        else:
            self.write("DONE")

    def create_job(self):
        user_id = int(self.get_argument('user_id'))
        job_id = int(self.get_argument('job_id'))


class JobController(object):
    def __init__(self):
        super(JobController, self).__init__()
        self.logger = logging.getLogger(self.__class__.__name__)

        self.conn = mysql.connector.connect(host=os.getenv('SHEPHERD_DB_HOST'),
                                            port=int(os.getenv('SHEPHERD_DB_PORT', '3306')),
                                            user=os.getenv('SHEPHERD_DB_USER'),
                                            passwd=os.getenv('SHEPHERD_DB_PASS'),
                                            charset='utf8')
        self.conn.autocommit = True

        self.lock = RLock()

    def call_scrapyd(self, host_ip, api, post_data=None, get_param=None):

        fields = None
        if post_data is not None:
            fields = urllib.parse.urlencode(post_data)

        buf = BytesIO()

        curl = pycurl.Curl()

        url = 'http://%s:6800/%s' % (host_ip, api)
        if get_param is not None and len(get_param) > 0:
            sep = '?'
            for param in get_param.keys():
                url = url + sep + param + '=' + get_param[param]
                sep = '&'

        curl.setopt(pycurl.URL, url)
        curl.setopt(pycurl.WRITEDATA, buf)
        if post_data is not None and len(post_data) > 0:
            curl.setopt(pycurl.POSTFIELDS, fields)

        curl.perform()

        result = json.loads(buf.getvalue().decode('utf-8'))

        curl.close()

        if result['status'] != 'ok':
            raise Exception("Call scrapyd api %s failed." % api)

        return result

    def job_redploy(self, job_path, job_name, host_ip):

        result = self.call_scrapyd(host_ip, 'listprojects.json')
        self.logger.debug("Current deployed projects are: %s", result['projects'])

        # Don't delete project for webdriver may still running and prevent the files from deleted.
        # if job_name in result['projects']:
        #     self.logger.debug("Removing the existing project %s on host %s", job_name, host_ip)
        #     self.call_scrapyd(host_ip, 'delproject.json', post_data={'project': job_name})

        os.chdir(job_path)
        self.logger.debug("Deploying project %s to %s", job_name, host_ip)

        self.logger.debug("Current searching path: %s", os.getenv('PATH'))

        # Must use the same python env in which scrapyd-deploy is installed to run scrapyd-deploy.
        ret = subprocess.call([
            'python',
            os.getenv('SPIDER_SCRAPYD_PATH') + os.path.sep + 'scrapyd-deploy',
            '-p',
            job_name])
        if ret != 0:
            raise Exception("Failed to deploy project %s to %s", job_name, host_ip)

    def job_create(self, user_id, job_id, host_ip):

        job_template_path = os.getenv('SHEPHERD_SPIDER_TEMPLATE')
        if job_template_path is None or len(job_template_path) == 0:
            raise Exception("SHEPHERD_SPIDER_TEMPLATE is not defined.")

        if not os.path.isdir(job_template_path):
            raise Exception("Spider template must be a directory.")

        job_prepare_path = os.getenv('SHEPHERD_JOB_PREPARE_PATH')
        if job_prepare_path is None or len(job_prepare_path) == 0:
            raise Exception("SHEPHERD_JOB_PREPARE_PATH is not defined.")

        if not os.path.isdir(job_prepare_path):
            if not os.path.exists(job_prepare_path):
                os.mkdir(job_prepare_path)
            else:
                raise Exception("Spider template must be a directory.")

        job_name = 'job_%s_%s' % (user_id, job_id)
        job_path = job_prepare_path + os.path.sep + job_name
        if os.path.exists(job_path):
            self.logger.warning("%s is existing, delete it.", job_path)
            shutil.rmtree(job_path)

        os.mkdir(job_path)

        shutil.copytree(job_template_path, job_path + os.path.sep + 'clematis')

        os.chdir(job_path)

        self.create_scrapy_cfg(job_path, host_ip, job_name)

        self.adjust_scrapy_settings(job_path, user_id, job_id)

        return job_path, job_name

    def adjust_scrapy_settings(self, job_path, user_id, job_id):
        settings = job_path + os.path.sep + 'clematis' + os.path.sep + 'settings.py'

        f = open(settings, "a")
        f.write('USER_ID = %s\n' % user_id)
        f.write('JOB_ID = %s\n' % job_id)
        f.close()

    def create_scrapy_cfg(self, job_path, host_ip, job_name):

        cfg_file = job_path + os.path.sep + 'scrapy.cfg'
        if os.path.exists(cfg_file):
            os.remove(cfg_file)

        f = open(cfg_file, "w")

        f.write('[settings]\n')
        f.write('default = clematis.settings\n')
        f.write('[deploy]\n')
        f.write('url = http://%s:6800/\n' % host_ip)
        f.write('project = %s\n' % job_name)

        f.close()

    def start_job(self, user_id, job_id):

        with self.lock:
            if (user_id, job_id) not in shepherd.job_schedules:
                self.logger.warning("Specified user %s and job %s is not found.", user_id, job_id)
                return

            working_dir = os.getcwd()
            host_ip = shepherd.job_schedules[(user_id, job_id)]['job_info']['host_ip']

            try:
                self.logger.info("Checking job status for user %s and job %s.", user_id, job_id)
                job_name = 'job_%s_%s' % (user_id, job_id)

                result = self.call_scrapyd(host_ip, 'listprojects.json')
                self.logger.debug("Current deployed projects are: %s", result['projects'])

                if job_name in result['projects']:
                    job_ids = []
                    result = self.call_scrapyd(host_ip, 'listjobs.json', get_param={'project': job_name})
                    for job in result['running'] + result['pending']:
                        job_ids.append(job['id'])

                    if len(job_ids) > 0:
                        self.logger.info('Starting job %s on %s is abandoned ' +
                                         'for previously scheduled job is not finished.', job_name, host_ip)
                        return

                self.logger.info("Refreshing job for user %s and job %s.", user_id, job_id)
                job_path, job_name = self.job_create(user_id, job_id, host_ip)

                self.job_redploy(job_path, job_name, host_ip)

                self.logger.info("Start job %s on host %s ...", job_name, host_ip)
                result = self.call_scrapyd(host_ip, 'schedule.json',
                                           post_data={'project': job_name, 'spider': 'spider2'})
                if result['status'] != 'ok':
                    raise Exception('Failed to start job %s on host %s', job_name, host_ip)

            except Exception:
                raise
            finally:
                os.chdir(working_dir)

    def stop_job(self, user_id, job_id):

        with self.lock:
            if (user_id, job_id) not in shepherd.job_schedules:
                return

            working_dir = os.getcwd()
            job_ids = []

            host_ip = shepherd.job_schedules[(user_id, job_id)]['job_info']['host_ip']

            try:
                self.logger.info("Checking job status for user %s and job %s.", user_id, job_id)
                job_name = 'job_%s_%s' % (user_id, job_id)
                results = self.call_scrapyd(host_ip, 'listjobs.json', get_param={'project': job_name})
                for job in results['running'] + results['pending']:
                    job_ids.append(job['id'])

                self.logger.info("The jobs to be terminated are %s", job_ids)
                for job_id in job_ids:
                    self.call_scrapyd(host_ip, 'cancel.json',
                                      post_data={'project': job_name, 'job': job_id})

                self.update_job_status(user_id, job_id)

            except Exception:
                raise
            finally:
                os.chdir(working_dir)

    def update_job_status(self, user_id, job_id):

        cursor = self.conn.cursor()

        sql = 'select max(start_time) start_time from {db}.crawl_status \
                  where user_id = %s and job_id = %s'.format(db=os.getenv('SHEPHERD_DB_NAME'))
        cursor.execute(sql, (user_id, job_id))

        start_time = MySQLUtils.get_rs_as_dict(cursor)[0]['start_time']

        sql = 'update {db}.crawl_status set run_status = 3 where user_id = %s and job_id = %s \
                and run_status in (0, 1) \
                and start_time = %s'.format(db=os.getenv('SHEPHERD_DB_NAME'))

        cursor.execute(sql, (user_id, job_id, start_time))

        cursor.close()


class Shepherd(object):
    def __init__(self):
        super(Shepherd, self).__init__()
        self.logger = logging.getLogger(self.__class__.__name__)
        self.scheduler = TornadoScheduler()

        self.application = tornado.web.Application([
            (r"/spider-config", SpiderConfigRequestHandler),
            (r"/update-status", UpdateStatusRequestHandler),
            (r"/job-control", JobControlRequestHandler),
        ])

        self.conn = mysql.connector.connect(host=os.getenv('SHEPHERD_DB_HOST'),
                                            port=int(os.getenv('SHEPHERD_DB_PORT', '3306')),
                                            user=os.getenv('SHEPHERD_DB_USER'),
                                            passwd=os.getenv('SHEPHERD_DB_PASS'),
                                            charset='utf8')
        self.conn.autocommit = True

        self.job_controller = JobController()

        self.job_schedules = {}

    def run(self):

        self.load_jobs()

        self.logger.debug(self.job_schedules)

        self.scheduler.start()

        self.scheduler.add_job(self.schedule_jobs, 'date', run_date=datetime.now() + timedelta(seconds=5))

        self.application.listen(os.getenv('SHEPHERD_PORT'))

        IOLoop.instance().start()

    def load_jobs(self):
        cursor = self.conn.cursor()

        sql = 'select j.*, s.job_schedule_type, h.host_ip \
                  from {db}.crawl_job j, {db}.job_schedule s, {db}.crawl_host h \
                  where j.job_schedule_id = s.job_schedule_id \
                  and j.host_id = h.host_id \
                  and j.is_valid = 1'.format(db=os.getenv('SHEPHERD_DB_NAME'))

        cursor.execute(sql)

        for row in MySQLUtils.get_rs_as_dict(cursor):
            self.job_schedules[(row['user_id'], row['job_id'])] = {'job_info': row, 'schedule_param': {}}

        cursor.close()

        sql = 'select * from {db}.job_schedule_param where job_schedule_id = %s'.format(
            db=os.getenv('SHEPHERD_DB_NAME'))

        for job in self.job_schedules.keys():
            cursor = self.conn.cursor()
            cursor.execute(sql, (self.job_schedules[job]['job_info']['job_schedule_id'],))
            for row in MySQLUtils.get_rs_as_dict(cursor):
                self.job_schedules[job]['schedule_param'][row['param_name']] = row['param_value']
            cursor.close()

    def update_job(self, user_id, job_id):
        self.logger.debug('Received job update request for user(%s), job(%s)', user_id, job_id)

        while True:
            try:
                cursor = self.conn.cursor()
                break
            except OperationalError as e:
                self.logger.error(f'Error raised when opening cursor: {e.msg}')
                self.conn = mysql.connector.connect(host=os.getenv('SHEPHERD_DB_HOST'),
                                                    port=int(os.getenv('SHEPHERD_DB_PORT', '3306')),
                                                    user=os.getenv('SHEPHERD_DB_USER'),
                                                    passwd=os.getenv('SHEPHERD_DB_PASS'),
                                                    charset='utf8')
                self.conn.autocommit = True
                time.sleep(1)

        sql = 'select j.*, s.job_schedule_type, h.host_ip \
                  from {db}.crawl_job j, {db}.job_schedule s, {db}.crawl_host h \
                  where j.job_schedule_id = s.job_schedule_id \
                  and j.host_id = h.host_id \
                  and j.user_id = %s and j.job_id = %s'.format(db=os.getenv('SHEPHERD_DB_NAME'))

        cursor.execute(sql, (user_id, job_id))

        result = MySQLUtils.get_rs_as_dict(cursor)
        if result is None or len(result) == 0:
            self.logger.error('Can not find information for specified job of (%s,%s)', user_id, job_id)
            return

        new_job = result[0]

        cursor.close()

        schedule_param = {}
        if new_job['is_valid'] == 1:
            sql = 'select * from {db}.job_schedule_param where job_schedule_id = %s'.format(
                db=os.getenv('SHEPHERD_DB_NAME'))
            cursor = self.conn.cursor()
            cursor.execute(sql, (new_job['job_schedule_id'],))
            for row in MySQLUtils.get_rs_as_dict(cursor):
                schedule_param[row['param_name']] = row['param_value']
            cursor.close()

        with self.job_controller.lock:
            if (user_id, job_id) not in self.job_schedules:
                if new_job['is_valid'] == 1:
                    self.job_schedules[(user_id, job_id)] = {'job_info': new_job, 'schedule_param': schedule_param}
                    self.schedule_jobs(user_id, job_id)
            else:
                old_job = self.job_schedules.pop((user_id, job_id))

                try:
                    self.scheduler.remove_job('job_%d_%d' % (user_id, job_id))
                except JobLookupError:
                    self.logger.debug('Job %s is not found.', 'job_%d_%d' % (user_id, job_id))

                if new_job['is_valid'] == 1:
                    if new_job['host_ip'] == old_job['job_info']['host_ip']:
                        self.job_controller.stop_job(user_id, job_id)

                    self.job_schedules[(user_id, job_id)] = {'job_info': new_job, 'schedule_param': schedule_param}
                    self.schedule_jobs(user_id, job_id)

    def schedule_jobs(self, user_id=None, job_id=None):
        def schedule_by_datetime(job):
            if 'time' not in self.job_schedules[job]['schedule_param']:
                return

            if self.job_schedules[job]['schedule_param']['time'] == '':
                self.logger.debug('Starting job_%d_%d immediately.', job[0], job[1])
                self.job_controller.start_job(job[0], job[1])
            else:
                self.logger.debug("Job_%d_%d will be started at %s.",
                                  job[0], job[1], self.job_schedules[job]['schedule_param']['time'])
                self.scheduler.add_job(self.job_controller.start_job,
                                       'date', run_date=self.job_schedules[job]['schedule_param']['time'],
                                       args=[job[0], job[1]], id='job_%d_%d' % (job[0], job[1]))

        def schedule_by_interval(job):
            self.logger.debug("Job_%d_%d will be scheduled at interval:", job[0], job[1])
            scheduler_args = {}
            for param in self.job_schedules[job]['schedule_param'].keys():
                self.logger.debug('%s=%s', param, self.job_schedules[job]['schedule_param'][param])
                if param == 'start_date' or param == 'end_date':
                    scheduler_args[param] = self.job_schedules[job]['schedule_param'][param]
                else:
                    scheduler_args[param] = int(self.job_schedules[job]['schedule_param'][param])
            self.scheduler.add_job(self.job_controller.start_job, 'interval', args=[job[0], job[1]],
                                   id='job_%d_%d' % (job[0], job[1]), **scheduler_args)

        def schedule_by_cron(job):
            self.logger.debug("Job_%d_%d will be scheduled at times when:", job[0], job[1])
            for param in self.job_schedules[job]['schedule_param'].keys():
                self.logger.debug('%s=%s', param, self.job_schedules[job]['schedule_param'][param])
            self.scheduler.add_job(self.job_controller.start_job, 'cron', args=[job[0], job[1]],
                                   id='job_%d_%d' % (job[0], job[1]), **self.job_schedules[job]['schedule_param'])

        schedulers = {
            0: schedule_by_datetime,
            1: schedule_by_interval,
            2: schedule_by_cron
        }

        if user_id is None or job_id is None:
            for job in self.job_schedules.keys():
                schedulers[self.job_schedules[job]['job_info']['job_schedule_type']](job)
        else:
            job = (user_id, job_id)
            schedulers[self.job_schedules[job]['job_info']['job_schedule_type']](job)


if __name__ == "__main__":
    # logging.config.fileConfig(os.environ['SHEPHERD_LOGGING_CONF'], disable_existing_loggers=False)

    logging.config.dictConfig(LOGGING_CONF)

    if os.name != 'nt':
        signal.signal(signal.SIGTERM, onSignal)
        signal.signal(signal.SIGQUIT, onSignal)
        signal.signal(signal.SIGINT, onSignal)

    shepherd = Shepherd()

    shepherd.run()
