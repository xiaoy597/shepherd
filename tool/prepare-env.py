# -*- coding:utf-8 -*-

import os
import shutil
import sys

envs = {
    'spider-agent': [
        'SPIDER_PACKAGE',
        'SPIDER_AGENT_HOME',
        'SPIDER_AGENT_WORK_DIR',
        'SPIDER_LOGGING_CONF',
        'SPIDER_PAGE_DUMP',
        'SHEPHERD_HOST',
        'SHEPHERD_PORT'
    ],
    'shepherd': [
        'SPIDER_PACKAGE',
        'SHEPHERD_HOME',
        'SHEPHERD_LOGGING_CONF',
        'SHEPHERD_SPIDER_TEMPLATE',
        'SHEPHERD_JOB_PREPARE_PATH',
        'SHEPHERD_DB_HOST',
        'SHEPHERD_DB_NAME',
        'SHEPHERD_DB_USER',
        'SHEPHERD_DB_PASS',
    ],
}


def check_env(pack):
    for env in envs[pack]:
        if os.getenv(env) is None:
            print 'Environment variable %s is not set.' % env
            exit(1)

    pack_home = 'SPIDER_AGENT_HOME' if pack == 'spider-agent' else 'SHEPHERD_HOME'
    for dirpath, dirnames, files in os.walk(os.path.join(os.getenv(pack_home), 'bin')):
        for file in files:
            os.chmod(os.path.join(dirpath, file), 0777)

    if pack_home == 'SPIDER_AGENT_HOME':
        scrapyd_conf = os.path.join(os.getenv('HOME'), '.scrapyd.conf')
        if not os.path.exists(scrapyd_conf):
            shutil.copy(os.path.join(os.getenv(pack_home), 'scrapyd.conf.default'), scrapyd_conf)

def check_anaconda():
    home_dir = os.getenv('HOME')

    if not os.path.exists(os.path.join(home_dir, 'anaconda2')):
        print 'Anaconda2 is not found.'
        exit(1)

    fix_anaconda_scripts(os.path.join(home_dir, 'anaconda2'))


def fix_anaconda_scripts(anaconda_path):
    scripts = [
        'bin/ipython', 'bin/scrapy', 'bin/scrapyd', 'bin/scrapyd-client', 'bin/scrapyd-deploy'
    ]

    for script in scripts:
        script_path = os.path.join(anaconda_path, script)
        if not os.path.exists(script_path):
            print '%s is not found.' % script_path
            exit(1)

        print 'Checking %s ...' % script_path
        fin = open(script_path, 'r')
        if fin.readline().startswith('#!%s' % anaconda_path):
            fin.close()
            continue

        print 'Fixing %s ...' % script_path
        fout = open(script_path + '.tmp', 'w')
        fout.write(os.path.join('#!%s' % anaconda_path, 'bin', 'python') + '\n')
        fout.writelines(fin.readlines())
        fin.close()
        fout.close()
        shutil.move(script_path, script_path + '.bak')
        shutil.move(script_path + '.tmp', script_path)
        os.chmod(script_path, 0777)

if __name__ == '__main__':
    check_anaconda()
    check_env(sys.argv[1])
