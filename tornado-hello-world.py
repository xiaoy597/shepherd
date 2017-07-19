# -*- coding: utf-8 -*-

import tornado.ioloop
import tornado.web
import json
import MySQLdb
from MySQLdb.cursors import DictCursor
from crawl_job import CrawlJob
import os


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

    def get(self):
        data = {'key': u'数据项目'}
        json_data = json.dumps(data)
        self.write(json_data)

    def post(self, *args, **kwargs):
        print "user_id = %s" % self.get_argument('user_id')
        print "job_id = %s" % self.get_argument('job_id')

        # conn = MySQLdb.connect(host=os.getenv('SHEPHERD_DB_HOST'), port=3306,
        #                        user=os.getenv('SHEPHERD_DB_USER'),
        #                        passwd=os.getenv('SHEPHERD_DB_PASS'),
        #                        cursorclass=DictCursor, charset='utf8')
        #
        # job = CrawlJob().load(int(self.get_argument('user_id')), int(self.get_argument('job_id')), conn)
        #
        # # data = {'key' : u'数据项目'}
        #
        # json_data = json.dumps(job.fields, indent=4)
        # self.write(json_data)
        #
        # conn.close()
        self.write("SUCCEED")


application = tornado.web.Application([
    (r"/spider-config", SpiderConfigRequestHandler),
    (r"/update-status", UpdateStatusRequestHandler),
])

if __name__ == "__main__":
    application.listen(8888)
    tornado.ioloop.IOLoop.instance().start()
