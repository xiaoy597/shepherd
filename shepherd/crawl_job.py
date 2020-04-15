# -*- coding: utf-8 -*-

from clematis_wrapper.clematis.mysql_utils import MySQLUtils


class CrawlJob(object):

    def __init__(self):
        super(CrawlJob, self).__init__()

        self.fields = None

    def load(self, user_id, job_id, db_conn):

        cursor = db_conn.cursor()

        sql = "select * from spiderdb.crawl_job where user_id = %s and job_id = %s"

        cursor.execute(sql, (user_id, job_id))

        self.fields = MySQLUtils.get_rs_as_dict(cursor)[0]

        sql = "select * from spiderdb.crawl_page_config where user_id = %s and job_id = %s"

        cursor.execute(sql, (user_id, job_id))

        self.fields['pages'] = MySQLUtils.get_rs_as_dict(cursor)

        for page in self.fields['pages']:
            page['fields'] = self.load_page_field(user_id, job_id, page['page_id'], db_conn)
            page['links'] = self.load_page_link(user_id, job_id, page['page_id'], db_conn)

        sql = "select * from spiderdb.data_store where user_id = %s and data_store_id = %s"
        cursor.execute(sql, (user_id, self.fields['data_store_id']))

        self.fields['data_store'] = MySQLUtils.get_rs_as_dict(cursor)[0]

        sql = "select * from spiderdb.data_store_param where user_id = %s and data_store_id = %s"
        cursor.execute(sql, (user_id, self.fields['data_store_id']))

        for row in MySQLUtils.get_rs_as_dict(cursor):
            self.fields['data_store'][str(row['param_name'])] = row['param_value']

        sql = "select param_name, param_value from spiderdb.crawl_config where user_id = %s and job_id = %s"
        cursor.execute(sql, (user_id, job_id))
        configs = {}
        for row in MySQLUtils.get_rs_as_dict(cursor):
            configs[str(row['param_name'])] = row['param_value']

        self.fields['configs'] = configs

        cursor.close()

        return self

    def load_page_field(self, user_id, job_id, page_id, db_conn):
        cursor = db_conn.cursor()

        sql = "select * from spiderdb.page_field " \
              "  where user_id = %s and job_id = %s and page_id = %s"

        cursor.execute(sql, (user_id, job_id, page_id))

        fields = MySQLUtils.get_rs_as_dict(cursor)

        cursor.close()

        for field in fields:
            field['field_locates'] = self.load_field_locate(user_id, job_id, page_id, field['field_id'], db_conn)

        return fields

    def load_field_locate(self, user_id, job_id, page_id, field_id, db_conn):
        cursor = db_conn.cursor()

        sql = "select l.* from spiderdb.page_field_locate_relation r, spiderdb.page_field_locate l " \
              "  where r.field_locate_id = l.field_locate_id and " \
              "  r.user_id = %s and r.job_id = %s and r.page_id = %s and r.field_id = %s"

        cursor.execute(sql, (user_id, job_id, page_id, field_id))

        locates = MySQLUtils.get_rs_as_dict(cursor)

        cursor.close()

        return locates

    def load_page_link(self, user_id, job_id, page_id, db_conn):
        cursor = db_conn.cursor()

        sql = "select * from spiderdb.page_link " \
              "  where user_id = %s and job_id = %s and page_id = %s"

        cursor.execute(sql, (user_id, job_id, page_id))

        links = MySQLUtils.get_rs_as_dict(cursor)
        cursor.close()

        return links


import sys
import json
import mysql.connector

if __name__ == "__main__":
    sys.getdefaultencoding()
    connection = mysql.connector.connect(host='localhost', port=3306, user='root', passwd='root',
                                         charset='utf8')
    job = CrawlJob().load(1, 2, connection)

    print(json.dumps(job.fields, indent=4))
