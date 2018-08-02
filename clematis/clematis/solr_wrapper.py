# -*- coding: utf-8 -*-

import os
import shutil
import json
import logging
import logging.config

from StringIO import StringIO
import pycurl
from urllib import urlencode

class SolrWrapper(object):
    logger = logging.getLogger("SolrWrapper")

    @classmethod
    def create_core(cls, user_id, job_id):
        buf = StringIO()

        core_name = 'job_%s_%s' % (user_id, job_id)
        curl = pycurl.Curl()

        url = 'http://{solr_server}/solr/admin/cores?action=CREATE&name={core_name}&configSet=crawler_configs&wt=json'.format(
                    solr_server=os.getenv('SOLR_SERVER'), core_name=core_name)

        curl.setopt(curl.URL, url)

        curl.setopt(curl.WRITEDATA, buf)

        curl.perform()

        result = json.loads(buf.getvalue())

        curl.close()

        SolrWrapper.logger.debug('Result of creating solr core is: %s', result)

        ret = result['responseHeader']['status']
        # 0: succeed, 500: core with the same name is exists.
        if ret != 0 and ret != 500:
            return False
        else:
            return True

    @classmethod
    def add_document(cls, user_id, job_id, doc_dict):

        post_data = {'add': {'commitWithin': 5000, 'doc': doc_dict}}
        post_data_str = json.dumps(post_data)

        # SolrWrapper.logger.debug(post_data_str)

        core_name = 'job_%s_%s' % (user_id, job_id)

        buf = StringIO()
        curl = pycurl.Curl()

        url = 'http://{solr_server}/solr/{core_name}/update?commit=true&wt=json'.format(
            solr_server=os.getenv('SOLR_SERVER'), core_name=core_name)

        curl.setopt(pycurl.URL, url)

        curl.setopt(pycurl.WRITEDATA, buf)
        curl.setopt(pycurl.POSTFIELDS, post_data_str)
        curl.setopt(pycurl.HTTPHEADER, ['Content-type:application/json'])

        print("Sending request ...")
        curl.perform()
        print("Response received.")

        result = json.loads(buf.getvalue())

        curl.close()

        SolrWrapper.logger.debug('Result of adding solr document is: %s', result)

        ret = result['responseHeader']['status']
        # 0: succeed, 500: document with the same id is exists.
        if ret != 0 and ret != 500:
            return False
        else:
            return True

    @classmethod
    def add_field(cls, user_id, job_id, field_name, field_type, is_stored):
        post_data = {'add-field': {'name': field_name, 'type': field_type, 'stored': is_stored}}

        post_data_str = json.dumps(post_data)

        SolrWrapper.logger.debug(post_data_str)

        core_name = 'job_%s_%s' % (user_id, job_id)

        buf = StringIO()
        curl = pycurl.Curl()

        url = 'http://{solr_server}/solr/{core_name}/schema?wt=json'.format(
            solr_server=os.getenv('SOLR_SERVER'), core_name=core_name)

        curl.setopt(pycurl.URL, url)

        curl.setopt(pycurl.WRITEDATA, buf)
        curl.setopt(pycurl.POSTFIELDS, post_data_str)
        curl.setopt(pycurl.HTTPHEADER, ['Content-type:application/json'])

        curl.perform()

        result = json.loads(buf.getvalue())

        curl.close()

        SolrWrapper.logger.debug('Result of adding solr field is: %s', result)

        ret = result['responseHeader']['status']
        # 0: succeed, 500: field with the same name is exists.
        if ret != 0 and ret != 500:
            return False
        else:
            return True

if __name__ == '__main__':
    logging.config.fileConfig(os.environ['SHEPHERD_LOGGING_CONF'], disable_existing_loggers=False)

    SolrWrapper.create_core('2', '4')
    # SolrWrapper.add_field('2', '4', 'field0001', 'strings', False)

    # doc = {
    #     'id': 7,
    #     'title_txt_hz': '文档标题',
    #     'doc_content_txt_hz': '''之前使用Python提交数据到服务器时都是采用自带的urllib库。前一段时间登录某Cas系统时，总是莫名的失败。失败的原因好像是cookie的问题，各个页面需要共享cookie。尝试了多个给urllib设置cookie的方法，还是没能成功。
    #                         后来，试了pycurl，竟然成功了，那就使用pycurl吧。（很抱歉，我没能追查出为什么采用urllib2没有成功，也没有彻底研究出为何pycurl能够成功）
    #                         pycurl官方下载链接我没有打开，本人通过该链接下载。另外，本人使用的是python2.7。
    #                         首先,对pycurl进行简单的封装''',
    #     'create_time_pdt': '2017-03-20T08:30:02Z',
    #     'author_txt_hz': '李洪非',
    # }
    #
    # SolrWrapper.add_document('2', '4', doc)
