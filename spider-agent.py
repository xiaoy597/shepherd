# -*- coding: utf-8 -*-

import os
import logging.config
import subprocess
import psutil
import threading
import time


def run_scrapyd():
    logger.debug("Starting scrapyd in %s", scrapyd_work_dir)
    p = subprocess.Popen(args=['scrapyd'], cwd=scrapyd_work_dir)
    p.wait()


def clear_orphan_process():
    while True:
        logger.debug('Checking orphant process ...')
        plist = []
        for proc in filter(lambda p: p.name().lower().startswith('firefox') or p.name().lower().startswith('geckodriver'),
                           psutil.process_iter()):
            plist.append((proc, proc.parent()))

        for p, parent in plist:
            if p.name().lower().startswith('geckodriver') and (parent is None or parent.pid == 1):

                child = filter(lambda x: x[0].name().lower().startswith('firefox') and x[1].pid == p.pid, plist)[0]
                logger.info('killing firefox(%d) ...', child[0].pid)
                os.kill(child[0].pid, 9)

                logger.info('Killing geckodriver(%d) ...', p.pid)
                os.kill(p.pid, 9)

        time.sleep(10)

if __name__ == '__main__':
    scrapyd_work_dir = os.getenv('SPIDER_AGENT_WORK_DIR')

    os.chdir(scrapyd_work_dir)

    logging.config.fileConfig(os.environ['SPIDER_LOGGING_CONF'], disable_existing_loggers=False)
    logger = logging.getLogger('spider-agent')

    t1 = threading.Thread(target=run_scrapyd)
    t1.start()

    t2 = threading.Thread(target=clear_orphan_process)
    t2.daemon = True
    t2.start()

    t1.join()



