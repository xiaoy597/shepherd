# -*- coding: utf-8 -*-

import os
import json
import logging
import logging.config
import tornado.ioloop
import tornado.web
import MySQLdb
from MySQLdb.cursors import DictCursor

from crawl_job import CrawlJob


class SpiderConfigRequestHandler(tornado.web.RequestHandler):
    def get(self):
        data = {'key': u'数据项目'}
        json_data = json.dumps(data)
        self.write(json_data)

    def post(self, *args, **kwargs):
        print "user_id = %s" % self.get_argument('user_id')
        print "job_id = %s" % self.get_argument('job_id')

        conn = MySQLdb.connect(host=os.getenv('SHEPHERD_DB_HOST'), port=3306,
                               user=os.getenv('SHEPHERD_DB_USER'),
                               passwd=os.getenv('SHEPHERD_DB_PASS'),
                               cursorclass=DictCursor, charset='utf8')

        job = CrawlJob().load(int(self.get_argument('user_id')), int(self.get_argument('job_id')), conn)

        print job.fields

        json_data = json.dumps(job.fields, indent=4)
        self.write(json_data)

        conn.close()


class UpdateStatusRequestHandler(tornado.web.RequestHandler):

    def __init__(self, *args, **kwargs):
        super(UpdateStatusRequestHandler, self).__init__(*args, **kwargs)

        self.logger = logging.getLogger(self.__class__.__name__)
        self.logger.info("Instance created.")

        self.conn = MySQLdb.connect(host=os.getenv('SHEPHERD_DB_HOST'), port=3306,
                                    user=os.getenv('SHEPHERD_DB_USER'),
                                    passwd=os.getenv('SHEPHERD_DB_PASS'),
                                    cursorclass=DictCursor, charset='utf8')
        self.conn.autocommit(True)

    def get(self):
        data = {'key': u'数据项目'}
        json_data = json.dumps(data)
        self.write(json_data)

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

        cursor = self.conn.cursor()

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


if __name__ == "__main__":
    logging.config.fileConfig(os.environ['SPIDER_LOGGING_CONF'], disable_existing_loggers=False)

    application = tornado.web.Application([
        (r"/spider-config", SpiderConfigRequestHandler),
        (r"/update-status", UpdateStatusRequestHandler),
    ])

    application.listen(8888)

    tornado.ioloop.IOLoop.instance().start()
