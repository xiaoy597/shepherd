# -*- coding: utf-8 -*-

import os
import shutil
import json
import logging
import logging.config
import subprocess

def start_scrapyd():
    print "Starting scrapyd in %s" % scrapyd_work_dir
    p = subprocess.Popen(args=['scrapyd'], cwd=scrapyd_work_dir)
    p.wait()

if __name__ == '__main__':
    scrapyd_work_dir = os.getenv('SPIDER_AGENT_WORK_DIR')
    start_scrapyd()

