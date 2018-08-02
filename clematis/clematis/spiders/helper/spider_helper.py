import re
import urllib
import urllib2
import StringIO
import gzip
import json


class GeneralSpiderHelper(object):
    def __init__(self):
        pass

    def get_page_links(self, page_content=None):
        pass


class SpiderHelperSLSJ(GeneralSpiderHelper):
    data_url = 'http://qc.wa.news.cn/nodeart/list?cnt=10&attr=undefined&tp=1&orderby=1'
    request_header = {
        'Connection': 'keep-alive',
        'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
        'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
        'Accept-Encoding': 'gzip,deflate',
        'Accept-Language': 'zh-CN,zh;q=0.9',
        'Cache-Control': 'max-age=0',
    }

    def __init__(self):
        super(SpiderHelperSLSJ, self).__init__()
        self.nid = ''
        self.page_data = None

    def get_page_links(self, page_content=None):
        if self.page_data is None:
            self.get_page_data( page_content)

        return [item['LinkUrl'] for item in self.page_data['list']]

    def get_page_data(self, page_content):
        page_data = {
            'list': []
        }

        self.get_nid(page_content)

        pgnum = 1
        while True:
            json_str = self.request_data(pgnum)[1:-1]
            result = json.loads(json_str)
            if result['status'] != 0:
                break
            else:
                page_data['list'].extend(result['data']['list'])
            pgnum += 1

        self.page_data = page_data

    def get_nid(self, page):
        nid_line = re.findall('"pageNid":\["\d+"\]', page)[-1]
        self.nid = re.match('[^\d]+(\d+).*', nid_line).group(1)
        return self.nid

    def request_data(self, pgnum):

        params = {
            "nid": self.nid,
            "pgnum": pgnum
        }

        data = urllib.urlencode(params)

        req = urllib2.Request(url=SpiderHelperSLSJ.data_url, data=data, headers=SpiderHelperSLSJ.request_header)
        rsp = urllib2.urlopen(req)

        if rsp.headers.dict['content-encoding'] == 'gzip':
            buf = StringIO.StringIO(rsp.read())
            content = gzip.GzipFile(fileobj=buf).read()
        else:
            content = rsp.read()

        return content


spiderHelpers = {
    'http://www.xinhuanet.com/silkroad/slsj.htm': SpiderHelperSLSJ()
}

if __name__ == "__main__":

    # content = open('c:/users/xiaoy/desktop/slsj.html').read()
    # print content

    request = urllib2.Request('http://www.xinhuanet.com/silkroad/slsj.htm')
    request.headers = {
        'Connection': 'keep-alive',
        'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
        'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
        'Accept-Encoding': 'gzip,deflate',
        'Accept-Language': 'zh-CN,zh;q=0.9',
        'Cache-Control': 'max-age=0',
    }

    response = urllib2.urlopen(request)

    if response.headers.dict['content-encoding'] == 'gzip':
        stream = StringIO.StringIO(response.read())
        html = gzip.GzipFile(fileobj=stream).read()
    else:
        html = response.read()

    print html

    print SpiderHelperSLSJ().get_page_links(page_content=html)
