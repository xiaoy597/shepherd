# -*- coding: utf-8 -*-

import os
import logging.config
import subprocess
import psutil
import threading
import time
import signal


def run_scrapyd():
    logger.info("Starting scrapyd in %s", scrapyd_work_dir)
    p = subprocess.Popen(args=['scrapyd'], cwd=scrapyd_work_dir)
    sub_process_list.append(p)


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


def run_xvfb():
    if len(list(filter(lambda p: p.name().lower() == 'xvfb', psutil.process_iter()))) > 0:
        logger.info("Xvfb is running.")
        return

    logger.info('Starting Xvfb ...')
    p = subprocess.Popen(args=['Xvfb', ':1', '-screen', '0', '1024x768x24', '-nolisten', 'tcp'])
    sub_process_list.append(p)


def signal_handler(signum, frame):
    global should_exit
    logger.info('Terminating spider-agent by signal %d ...', signum)
    for p in sub_process_list:
        p.terminate()
    should_exit = True


if __name__ == '__main__':
    sub_process_list = []
    should_exit = False

    scrapyd_work_dir = os.getenv('SPIDER_AGENT_WORK_DIR')

    os.chdir(scrapyd_work_dir)

    logging.config.fileConfig(os.environ['SPIDER_LOGGING_CONF'], disable_existing_loggers=False)
    logger = logging.getLogger('spider-agent')

    if os.name != 'nt':
        run_xvfb()

    run_scrapyd()

    signal.signal(signal.SIGTERM, signal_handler)
    signal.signal(signal.SIGINT, signal_handler)

    t1 = threading.Thread(target=clear_orphan_process)
    t1.daemon = True
    t1.start()

    while not should_exit:
        time.sleep(1)
