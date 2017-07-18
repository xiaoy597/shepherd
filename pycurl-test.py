# -*- coding: utf-8 -*-

from StringIO import StringIO
import pycurl
import json
from urllib import urlencode


def ping_service(my_curl, fields):
    buf = StringIO()
    my_curl.setopt(my_curl.WRITEDATA, buf)
    my_curl.setopt(my_curl.POSTFIELDS, fields)

    my_curl.perform()

    json_data = buf.getvalue()
    # Body is a string in some encoding.
    # In Python 2, we can print it without knowing what the encoding is.
    print(json_data)

    data = json.loads(json_data)
    print data
    # for k in data.keys():
    #     print k, data[k]


if __name__ == "__main__":
    my_curl = pycurl.Curl()
    my_curl.setopt(my_curl.URL, 'http://127.0.0.1:8888/spider-config')

    postfields = urlencode({'user_id':1, 'job_id':1})

    for i in range(1):
        print "Try the %d time ..." % i
        ping_service(my_curl, postfields)
