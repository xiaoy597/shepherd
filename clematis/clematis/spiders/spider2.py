# -*- coding: utf-8 -*-
import json
import logging
import logging.config
import os
import re
import pycurl
import time
import datetime
from StringIO import StringIO
from urllib import urlencode

import scrapy
from hbase import Hbase
from hbase.ttypes import Mutation
from scrapy import signals
from scrapy.exceptions import DontCloseSpider
from selenium.common.exceptions import NoSuchElementException
from selenium.common.exceptions import StaleElementReferenceException
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait
from thrift.protocol import TBinaryProtocol
from thrift.transport import TSocket
from thrift.transport import TTransport

from clematis.const import *
from clematis.solr_wrapper import SolrWrapper


class Spider2(scrapy.Spider):
    name = 'spider2'
    allowed_domains = []
    user_agent = 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) ' + \
                 'Chrome/58.0.3029.110 Safari/537.36'

    def start_requests(self):

        self.logger.info("Starting to crawl %s" % self.params['job_name'])

        self.stats_exporter.update_stats(0)

        if self.params['start_urls'] is not None:
            urls = self.params['start_urls'].split(',')
        else:
            urls = []

        if len(urls) == 0:
            urls = self.generate_value_list(self.params['configs']['start_url_pattern'])

        self.logger.debug(urls)

        if not SolrWrapper.create_core(self.params['user_id'], self.params['job_id']):
            raise Exception("Failed to create solr index for job_%s_%s", self.params['user_id'], self.params['job_id'])

        page_type = filter(lambda p: p['page_id'] == self.params['entry_page_id'],
                           [page for page in self.params['pages']])[0]['page_type']

        request_headers = self.crawler.settings.getdict('DEFAULT_REQUEST_HEADERS')
        for param in self.params['configs']:
            if param.startswith('http_header'):
                index = self.params['configs'][param].find(':')
                header_name = self.params['configs'][param][0:index].strip()
                header_value = self.params['configs'][param][index + 1:].strip()
                request_headers[header_name] = header_value

        self.logger.debug("Request headers: %s", request_headers)

        for url in urls:
            if self.params['configs']['request_type'] == 'get':
                if page_type == SPIDER_STATIC_PAGE:
                    yield scrapy.Request(url=url, callback=self.parse_static_page,
                                         meta={'my_page_id': self.params['entry_page_id']},
                                         headers=request_headers)
                elif page_type == SPIDER_DYNAMIC_PAGE:
                    yield scrapy.Request(url=url, callback=self.parse_dynamic_page,
                                         meta={"my_page_type": "dynamic",
                                               'my_page_id': self.params['entry_page_id']},
                                         dont_filter=True,
                                         headers=request_headers)
                else:
                    yield scrapy.Request(url=url, callback=self.parse_json_page,
                                         meta={'my_page_id': self.params['entry_page_id']},
                                         headers=request_headers)
            else:
                form_fields = {}
                for param in self.params['configs']:
                    if param.startswith('form_field'):
                        index = self.params['configs'][param].find('=')
                        field_name = self.params['configs'][param][0:index].strip()
                        field_value = self.params['configs'][param][index + 1:].strip()
                        form_fields[field_name] = field_value

                self.logger.debug("Form fields: %s", form_fields)

                form_sets = self.generate_form_value_set(form_fields)

                self.logger.debug("Form set: %s", form_sets)

                for form_set in form_sets:
                    if page_type == SPIDER_STATIC_PAGE:
                        yield scrapy.FormRequest(url=url, callback=self.parse_static_page,
                                                 meta={'my_page_id': self.params['entry_page_id'],
                                                       'my_form_data': str(form_set),
                                                       # If we want to come along with a proxy ...
                                                       # 'proxy': 'http://127.0.0.1:8888',
                                                       },
                                                 headers=request_headers, formdata=form_set)
                    elif page_type == SPIDER_DYNAMIC_PAGE:
                        yield scrapy.FormRequest(url=url, callback=self.parse_dynamic_page,
                                                 meta={"my_page_type": "dynamic",
                                                       'my_page_id': self.params['entry_page_id'],
                                                       'my_form_data': str(form_set),
                                                       },
                                                 dont_filter=True,
                                                 headers=request_headers, formdata=form_set)
                    else:
                        yield scrapy.FormRequest(url=url, callback=self.parse_json_page,
                                                 meta={'my_page_id': self.params['entry_page_id'],
                                                       'my_form_data': str(form_set),
                                                       },
                                                 headers=request_headers, formdata=form_set)

    def generate_form_value_set(self, form_fields):
        form_field_value_list = {}
        for field_name in form_fields.keys():
            form_field_value_list[field_name] = self.generate_value_list(form_fields[field_name])

        form_value_set = []
        for field_name in form_fields.keys():
            value_list = []
            for v in form_field_value_list[field_name]:
                value_list.append({field_name: v})
            form_value_set = self.list_dict_join(form_value_set, value_list)

        return form_value_set

    def list_dict_join(self, list1, list2):
        result = []
        for d1 in list1:
            for d2 in list2:
                d = d1.copy()
                d.update(d2)
                result.append(d)

        if len(result) == 0:
            result = list2

        return result

    def generate_value_list(self, value_pattern):
        value_list = []

        params = re.findall(r'\${[\w]+}', value_pattern)
        if len(params) == 0:
            value_list = [value_pattern]
            return value_list

        param_value_list = {}
        for param in params:
            param_value = self.params['configs'][param[2:-1]]
            if param_value is not None:
                m = re.match(r'range\([^)]+\)', param_value)
                if m is not None:
                    limits = (m.group()[6:-1]).split(',')
                    if len(limits) != 2:
                        self.logger.error("Illegal range definition %s:%s", param, param_value)
                        return value_list
                    param_value_list[param] = self.generate_range_value_list(limits)
                else:
                    param_value_list[param] = [param_value]
            else:
                self.logger.error("Param %s is not defined.", param)
                return value_list

        value_list = self.replace_params(value_pattern, param_value_list)
        return value_list

    def generate_urls(self):
        urls = []

        url_pattern = self.params['configs']['start_url_pattern']

        params = re.findall(r'\${[\w]+}', url_pattern)

        self.logger.debug('In url pattern: %s', url_pattern)
        self.logger.debug('Find params: %s', params)

        param_value_list = {}
        for param in params:
            param_value = self.params['configs'][param[2:-1]]
            if param_value is not None:
                m = re.match(r'range\([^)]+\)', param_value)
                if m is not None:
                    limits = (m.group()[6:-1]).split(',')
                    if len(limits) != 2:
                        self.logger.error("Illegal range definition %s:%s", param, param_value)
                        return urls
                    param_value_list[param] = self.generate_range_value_list(limits)
                else:
                    param_value_list[param] = [param_value]
            else:
                self.logger.error("Param %s is not defined.", param)
                return urls

        urls = self.replace_params(url_pattern, param_value_list)
        return urls

    def replace_params(self, value_pattern, param_value_list):
        (param, value_list) = param_value_list.popitem()
        if len(param_value_list) > 0:
            values_more = []
            values = self.replace_params(value_pattern, param_value_list)
            for v in values:
                values_more = values_more + [v.replace(param, value) for value in value_list]
            return values_more
        else:
            return [value_pattern.replace(param, value) for value in value_list]

    def generate_range_value_list(self, limits):
        value_list = []

        if re.match('^\d{4}-\d{2}-\d{2}$', limits[0].strip()) is not None:
            # Date type
            start_date = datetime.datetime.strptime(limits[0].strip(), '%Y-%m-%d')
            end_date = datetime.datetime.strptime(limits[1].strip(), '%Y-%m-%d')
            delta = datetime.timedelta(days=1)

            while start_date <= end_date:
                if start_date.weekday() < 5:
                    value_list.append(start_date.strftime('%Y-%m-%d'))
                start_date = start_date + delta
        else:
            self.logger.warning("Only support value range for date type.")
            pass

        return value_list

    @classmethod
    def from_crawler(cls, crawler, *args, **kwargs):
        spider = cls(*args, **kwargs)
        spider._set_crawler(crawler)

        spider.crawler.signals.connect(spider.spider_idle, signal=signals.spider_idle)
        spider.crawler.signals.connect(spider.spider_close, signal=signals.spider_closed)
        spider.crawler.signals.connect(spider.engine_stop, signal=signals.engine_stopped)

        print "Current Directory is " + os.getcwd()

        if os.getenv('SPIDER_AGENT_HOME') is not None:
            logging.getLogger('selenium').setLevel(logging.INFO)
            logging.getLogger('scrapy').setLevel(logging.DEBUG)
        else:
            logging.config.fileConfig(os.environ['SPIDER_LOGGING_CONF'], disable_existing_loggers=False)

        spider.params = spider.get_job_param(crawler.settings.get('USER_ID'), crawler.settings.get('JOB_ID'))

        spider.logger.debug(spider.params)

        spider.stats_exporter = StatsExporter(spider)

        spider.logger.debug("%s is configured.", cls.__name__)

        return spider

    def __init__(self, **kwargs):
        super(Spider2, self).__init__(**kwargs)

        self.browser = None
        self.default_window = None
        self.page_num = 0
        self.request_queue = []
        self.params = None
        self.hbase_client = None
        self.page_dump_params = None
        self.page_serials = {}
        self.page_numbers = {}
        self.start_time = time.time()
        self.stats_exporter = None

    def spider_idle(self):
        self.logger.info("Spider idle signal is caught.")

        stats_info = "Stats for last scrapping >>>"
        for k, v in self.crawler.stats.__dict__['_stats'].iteritems():
            stats_info += '\n' + k + ": " + str(v)

        stats_info += "\nStats for last scrapping <<<"

        self.logger.info(stats_info)

        self.stats_exporter.update_stats(1)

        if len(self.request_queue) > 0:
            count = 4 - len(self.browser.window_handles)
            while count > 0 and len(self.request_queue) > 0:
                req = self.request_queue.pop(0)
                self.logger.debug("Dequeuing %s", req.url)
                self.crawler.engine.crawl(req, spider=self)
                count -= 1
            raise DontCloseSpider

    def spider_close(self):
        self.logger.info("Spider close signal is caught.")

        self.stats_exporter.update_stats(2)

        if self.browser is not None:
            self.browser.quit()

    def engine_stop(self):
        self.logger.info("Engine stop signal is caught.")

        # self.stats_exporter.update_stats(3)

        if self.browser is not None:
            self.browser.quit()

    def get_job_param(self, user_id, job_id):

        buf = StringIO()
        fields = urlencode({'user_id': user_id, 'job_id': job_id})

        curl = pycurl.Curl()
        curl.setopt(curl.URL, 'http://%s:%s/spider-config' % (os.getenv('SHEPHERD_HOST'), os.getenv('SHEPHERD_PORT')))
        curl.setopt(curl.WRITEDATA, buf)
        curl.setopt(curl.POSTFIELDS, fields)
        curl.perform()

        json_data = buf.getvalue()
        self.logger.debug("Job Configuration:\n" + json_data)

        return json.loads(json_data)

    def parse_json_page(self, response):
        crawl_time = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())

        meta = response.request.meta
        if meta is None or 'my_page_id' not in meta:
            raise Exception('Meta is missing for request ' + response.request.url)

        page_def = filter(lambda x: x['page_id'] == meta['my_page_id'], self.params['pages'])[0]

        self.logger.debug("Parsing page %s from URL %s", page_def['page_name'], response.request.url)

        self.logger.debug("Response is :[%s]", response.text)

        m = re.match(self.params['configs']['json_extract_pattern'], response.text)
        if m is None:
            self.logger.error("No JSON data is extracted using pattern [%s]",
                              self.params['configs']['json_extract_pattern'])
            return

        json_str = m.group(int(self.params['configs']['json_extract_group']))
        self.logger.debug("Extracted JSON data is %s", json_str)

        json_data = json.loads(json_str)

        content = self.get_field_list(json_data, page_def)

        self.logger.debug("Page content: %s", str(content))

        if len(content) > 0:
            index_doc = {
                'id': response.request.url + ',' + crawl_time +
                      (',' + meta['my_form_data'] if 'my_form_data' in meta else ''),
                'page_id': page_def['page_id'],
                'page_content': json.dumps(content, ensure_ascii=False),
                'page_source': response.text,
                'crawl_time': crawl_time
            }
            if not SolrWrapper.add_document(self.params['user_id'], self.params['job_id'], index_doc):
                self.logger.error('Failed to add document to Solr.')

        if page_def['save_page_source']:
            self.dump_page_source(page_def['page_id'], crawl_time, response.request.url, response.text)

        if page_def['data_format'] == SPIDER_DATA_FORMAT_TABLE:
            rows = self.content_to_rows(content)

            self.logger.debug("Page content as rows: %s", str(rows))

            for row in rows:
                row['_collect_time'] = crawl_time
                row['_page_id'] = page_def['page_id']
                self.logger.debug("Sending row: %s", str(row))
                yield row

    def parse_static_page(self, response):

        crawl_time = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())

        meta = response.request.meta
        if meta is None or 'my_page_id' not in meta:
            raise Exception('Meta is missing for request ' + response.request.url)

        page_def = filter(lambda x: x['page_id'] == meta['my_page_id'], self.params['pages'])[0]

        self.logger.debug("Parsing page %s from URL %s", page_def['page_name'], response.request.url)

        self.logger.debug("Response text is : %s", response.text)

        content = self.get_field_list(response, page_def)

        self.logger.debug("Page content: %s", str(content))

        if len(content) > 0:
            index_doc = {
                'id': response.request.url + ',' + crawl_time +
                      (',' + meta['my_form_data'] if 'my_form_data' in meta else ''),
                'page_id': page_def['page_id'],
                'page_content': json.dumps(content, ensure_ascii=False),
                'page_source': response.text,
                'crawl_time': crawl_time
            }
            if not SolrWrapper.add_document(self.params['user_id'], self.params['job_id'], index_doc):
                self.logger.error('Failed to add document to Solr.')

        new_requests = self.get_page_link(response, page_def)

        if page_def['save_page_source']:
            self.dump_page_source(page_def['page_id'], crawl_time, response.request.url, response.text)

        if page_def['data_format'] == SPIDER_DATA_FORMAT_TABLE:
            rows = self.content_to_rows(content)

            # self.logger.debug("Page content as rows: %s", str(rows))

            for row in rows:
                row['_collect_time'] = crawl_time
                row['_page_id'] = page_def['page_id']
                self.logger.debug("Sending row: %s", str(row))
                yield row

        for req in new_requests:
            yield req

        # Turning page for static page is not tested.
        if page_def['is_multi_page']:
            if page_def['page_id'] not in self.page_numbers:
                self.page_numbers[page_def['page_id']] = 1

            if self.page_numbers[page_def['page_id']] >= page_def['max_page_num']:
                return
            else:
                next_page = response.xpath(page_def['paginate_element'])

                if len(next_page) == 0:
                    self.logger.exception("Paginate element [%s] is not found.", page_def['paginate_element'])
                    return
                else:
                    self.logger.debug("Turning to next page ...")
                    self.page_numbers[page_def['page_id']] += 1

                    link = next_page[0].xpath('./@href').extract()
                    yield scrapy.Request(link, callback=self.parse_static_page, dont_filter=True,
                                         meta={"my_page_id": page_def['page_id']})

    def parse_dynamic_page(self, response):

        self.stats_exporter.update_stats(1)

        crawl_time = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())

        meta = response.request.meta
        if meta is None or 'my_page_id' not in meta:
            raise Exception('Meta is missing for request ' + response.request.url)

        page_def = filter(lambda x: x['page_id'] == meta['my_page_id'], self.params['pages'])[0]

        self.logger.debug("Parsing page %s from URL %s", page_def['page_name'], response.request.url)

        self.browser.switch_to.window(response.headers["handle"])

        time.sleep(2)

        try:
            WebDriverWait(self.browser, 30).until(
                EC.presence_of_element_located((By.XPATH, page_def['load_indicator'])))
        except TimeoutException as e:
            self.logger.exception("Time out for getting content from page %s", response.url)
            self.browser.close()
            yield scrapy.Request(url=response.request.url, callback=self.parse_dynamic_page,
                                 meta={"my_page_type": "dynamic", 'my_page_id': meta['my_page_id']},
                                 dont_filter=True)
            return

        try:
            new_requests = self.get_page_link(response, page_def)

            content = self.get_field_list(response, page_def)

            self.logger.debug("Page content is: %s", content)

            if len(content) > 0:
                index_doc = {
                    'id': response.request.url + ',' + crawl_time +
                          (',' + meta['my_form_data'] if 'my_form_data' in meta else ''),
                    'page_id': page_def['page_id'],
                    'page_content': json.dumps(content, ensure_ascii=False),
                    'page_source': self.browser.page_source,
                    'crawl_time': crawl_time
                }
                if not SolrWrapper.add_document(self.params['user_id'], self.params['job_id'], index_doc):
                    self.logger.error('Failed to add document to Solr.')

            if page_def['save_page_source']:
                self.dump_page_source(page_def['page_id'], crawl_time, response.request.url, self.browser.page_source)
        except StaleElementReferenceException:
            self.logger.debug("Page %s is updated during parsing, try it again ...")
            yield scrapy.Request(url=response.request.url, callback=self.parse_dynamic_page,
                                 meta={"my_page_type": "dynamic", 'my_page_id': meta['my_page_id']},
                                 dont_filter=True)
            return

        if page_def['data_format'] == SPIDER_DATA_FORMAT_TABLE:
            rows = self.content_to_rows(content)

            # self.logger.debug("Page content as rows: %s", str(rows))

            for row in rows:
                row['_collect_time'] = crawl_time
                row['_page_id'] = page_def['page_id']
                self.logger.debug("Sending row: %s", str(row))
                yield row

        for req in new_requests:
            yield req

        self.browser.switch_to.window(response.headers["handle"])
        if page_def['is_multi_page']:
            if page_def['page_id'] not in self.page_numbers:
                self.page_numbers[page_def['page_id']] = 1

            if self.page_numbers[page_def['page_id']] >= page_def['max_page_num']:
                self.browser.close()
                return
            else:
                if page_def['paginate_element'] != '':
                    try:
                        time.sleep(max(page_def['page_interval'] - 2, 0))
                        next_page = self.browser.find_element_by_xpath(page_def['paginate_element'])
                        next_page.click()
                    except NoSuchElementException as e:
                        self.logger.exception("Paginate element [%s] is not found.", page_def['paginate_element'])
                        self.browser.close()
                    else:
                        self.logger.debug("Turning to next page ...")
                        self.page_numbers[page_def['page_id']] += 1

                        yield scrapy.Request(self.browser.current_url,
                                             callback=self.parse_dynamic_page,
                                             dont_filter=True,
                                             meta={"my_page_type": "update",
                                                   "my_window": self.browser.current_window_handle,
                                                   "my_page_id": page_def['page_id']
                                                   }
                                             )
                else:
                    # Self refresh page.
                    time.sleep(max(page_def['page_interval'] - 2, 0))
                    self.page_numbers[page_def['page_id']] += 1
                    yield scrapy.Request(response.request.url,
                                         callback=self.parse_dynamic_page,
                                         dont_filter=True,
                                         meta={"my_page_type": "update",
                                               "my_window": self.browser.current_window_handle,
                                               "my_page_id": page_def['page_id']
                                               }
                                         )

        else:
            self.browser.close()

    def get_page_link(self, response, page_def):

        links = []
        request_list = []
        page_type = page_def['page_type']

        # Extracting page links from static page is not tested.
        if page_type == SPIDER_STATIC_PAGE:
            for link in page_def['links']:
                try:
                    for link_element in response.xpath(link['link_locate_pattern']):
                        self.logger.debug('Find link: %s[%s]',
                                          link_element.xpath('./@href').extract(),
                                          link_element.xpath('.//text()').extract())
                        links.append((link_element.xpath('./@href').extract(), link['next_page_id']))
                except (NoSuchElementException, StaleElementReferenceException) as e:
                    self.logger.exception('No element is found from path %s', link['link_locate_pattern'])
        else:
            for link in page_def['links']:
                try:
                    for link_element in self.browser.find_elements_by_xpath(link['link_locate_pattern']):
                        self.logger.debug('Find link: %s[%s]', link_element.get_attribute("href"), link_element.text)
                        links.append((link_element.get_attribute("href"), link['next_page_id']))
                except (NoSuchElementException, StaleElementReferenceException) as e:
                    self.logger.exception('No element is found from path %s', link['link_locate_pattern'])

        if page_type == SPIDER_STATIC_PAGE:
            count = 32
        else:
            count = 4 - len(self.browser.window_handles)

        for link, next_page_id in links:
            next_page_def = filter(lambda x: x['page_id'] == next_page_id, self.params['pages'])[0]
            if next_page_def['page_type'] == SPIDER_STATIC_PAGE:
                req = scrapy.Request(link, callback=self.parse_static_page,
                                     meta={"my_page_id": next_page_id}, dont_filter=True)
            else:
                req = scrapy.Request(link, callback=self.parse_dynamic_page,
                                     meta={"my_page_id": next_page_id, "my_page_type": 'dynamic'}, dont_filter=True)
            if count < 0:
                self.logger.debug("Enqueuing %s", str(link))
                self.request_queue.append(req)
            else:
                self.logger.debug("Requesting %s", str(link))
                request_list.append(req)
            count -= 1

        return request_list

    def get_field_list(self, response, page_def, current_field_list=None, xpath_var_dict={}, level=1):

        content = {}
        if current_field_list is None:
            current_field_list = filter(lambda x: x['parent_field_id'] == 0, page_def['fields'])

        if len(current_field_list) == 0:
            return content

        for field in current_field_list:
            content[field['field_name']] = self.get_field_values(response, page_def, field, xpath_var_dict, level)

        return content

    def get_element_content(self, page_type, element, extract_pattern):

        if page_type == SPIDER_DYNAMIC_PAGE:
            if extract_pattern == 'text':
                text = element.text
                if len(text) == 0:
                    text = element.get_attribute('textContent')
                return text
            elif extract_pattern == 'self-text':
                return element.text[0:element.text.index(
                    ''.join(map(lambda e: e.text, element.find_elements_by_xpath('./*')))
                )]
            elif extract_pattern.startswith('@'):
                return element.get_attribute(extract_pattern[1:])
            else:
                raise Exception("Unsupported field extract pattern [%s]", extract_pattern)
        else:
            if extract_pattern == 'text':
                return ''.join(element.xpath('.//text()').extract())
            elif extract_pattern == 'self-text':
                return ''.join(element.xpath('./text()').extract())
            elif extract_pattern.starswith('@'):
                return ''.join(element.xpath('./' + extract_pattern).extract())
            else:
                raise Exception("Unsupported field extract pattern [%s]", extract_pattern)

    def get_field_values(self, response, page_def, field, xpath_var_dict, level):
        element_index_var = '${FIELD_LEVEL_' + str(level) + '_INDEX}'

        field_value_list = []

        list_index = 1
        var_defined_in_xpath = True
        while var_defined_in_xpath:
            xpath_var_dict[element_index_var] = str(list_index)

            temp_field_value_list = []
            for field_path in field['field_locates']:

                xpath = field_path['field_locate_pattern']
                for xpath_var in xpath_var_dict.keys():
                    xpath = xpath.replace(xpath_var, xpath_var_dict[xpath_var])

                if xpath == field_path['field_locate_pattern']:
                    var_defined_in_xpath = False

                if page_def['page_type'] == SPIDER_JSON_PAGE:
                    expr = 'response' + xpath
                    temp_field_value_list.append(eval(expr))
                else:
                    if page_def['page_type'] == SPIDER_STATIC_PAGE:
                        field_value_elements = response.xpath(xpath)
                        self.logger.debug("%s evaluated to %s", xpath, str(field_value_elements.extract()))
                    elif page_def['page_type'] == SPIDER_DYNAMIC_PAGE:
                        field_value_elements = self.browser.find_elements_by_xpath(xpath)
                        self.logger.debug("%s evaluated to %s", xpath, str(field_value_elements))

                    if field_value_elements is not None and len(field_value_elements) > 0:
                        if field['combine_field_value']:

                            field_value = reduce(lambda x, y: x + ' ' + y,
                                                 [self.get_element_content(page_def['page_type'], elem,
                                                                           field_path['field_ext_pattern'])
                                                  for elem in field_value_elements]).replace('\n', '').strip()

                            temp_field_value_list.append(field_value)
                        else:
                            for field_value_element in field_value_elements:
                                field_value = self.get_element_content(
                                    page_def['page_type'], field_value_element,
                                    field_path['field_ext_pattern']).replace('\n', '').strip()

                                temp_field_value_list.append(field_value)

            if len(temp_field_value_list) == 0:
                break

            for field_value in temp_field_value_list:
                field_value_list.append((field_value, self.get_field_list(
                    response,
                    page_def,
                    filter(lambda x: x['parent_field_id'] == field['field_id'],
                           page_def['fields']),
                    xpath_var_dict, level + 1)
                                         ))
            list_index += 1

        return field_value_list

    def content_to_rows(self, content):
        my_rows = []
        columns = {}
        for field in content.keys():
            if len(content[field]) == 0:
                columns[field] = ['']
            else:
                for field_value, sub_content in content[field]:
                    sub_rows = self.content_to_rows(sub_content)
                    if len(sub_rows) > 0:
                        for sub_row in sub_rows:
                            sub_row[field] = field_value
                        my_rows.extend(sub_rows)
                    else:
                        if field not in columns:
                            columns[field] = []
                        columns[field].append(field_value)
        if len(my_rows) > 0 or len(columns) == 0:
            return my_rows
        else:
            index = 0
            while True:
                row = {}
                field_num = 0
                for field in columns.keys():
                    if len(columns[field]) < index + 1:
                        row[field] = columns[field][len(columns[field]) - 1]
                    else:
                        row[field] = columns[field][index]
                        field_num += 1
                if field_num == 0:
                    return my_rows
                my_rows.append(row)
                index += 1

    def dump_page_source(self, page_id, crawl_time, url, page):

        if os.getenv('SPIDER_PAGE_DUMP').upper() == 'FALSE':
            return

        if self.hbase_client is None:
            transport = TTransport.TBufferedTransport(
                TSocket.TSocket(os.getenv('SPIDER_PAGE_DUMP_HOST'), os.getenv('SPIDER_PAGE_DUMP_PORT')))
            protocol = TBinaryProtocol.TBinaryProtocol(transport)
            self.hbase_client = Hbase.Client(protocol)
            transport.open()

        if page_id not in self.page_serials:
            self.page_serials[page_id] = 0
        else:
            self.page_serials[page_id] += 1

        row = "%d_%d_%d_%d_%d" % \
              (self.params['user_id'], self.params['job_id'], int(self.start_time), page_id, self.page_serials[page_id])

        columns = {
            'f1:url': url,
            'f1:crawl_time': crawl_time,
            'f2:page': page.encode('utf8'),
        }

        # self.logger.debug("row: %s", row)
        # self.logger.debug("columns: %s", str(columns))

        self.hbase_client.mutateRow(
            os.getenv('SPIDER_PAGE_DUMP_TABLE'), row,
            map(lambda (k, v): Mutation(column=k, value=v), columns.items()), None)

        self.logger.debug("Row %s dumped to spider_page, url=%s", row, url)


from io import BytesIO


class StatsExporter(object):
    def __init__(self, spider):
        super(StatsExporter, self).__init__()
        self.logger = logging.getLogger(self.__class__.__name__)

        self.spider = spider

    def update_stats(self, run_status):
        stats_info = self.spider.crawler.stats.__dict__['_stats']

        self.logger.debug('Stats Info: %s', str(stats_info))

        fields = {
            'user_id': self.spider.params['user_id'],
            'job_id': self.spider.params['job_id'],
            'start_time': time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(self.spider.start_time)),
            'run_status': run_status,
            'download_num': (lambda x: stats_info[x] if x in stats_info else 0)('downloader/response_count'),
            'pending_num': len(self.spider.request_queue),
            'error_num': 0
        }

        buffer1 = BytesIO()
        my_curl = pycurl.Curl()
        my_curl.setopt(my_curl.URL,
                       'http://%s:%s/update-status' % (os.getenv('SHEPHERD_HOST'), os.getenv('SHEPHERD_PORT')))
        my_curl.setopt(my_curl.WRITEDATA, buffer1)
        my_curl.setopt(my_curl.POSTFIELDS, urlencode(fields))

        my_curl.perform()

        self.logger.debug('Response for update stats is %d' % my_curl.getinfo(my_curl.RESPONSE_CODE))
