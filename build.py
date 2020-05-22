# -*- coding:utf-8 -*-

import sys
import os
import shutil
import zipfile
import pathlib


def clear_cache(root_path):
    for file in pathlib.Path(root_path).rglob('*'):
        if file.exists() and file.is_dir() and file.name == '__pycache__':
            print(f'Removing {file} ...')
            shutil.rmtree(str(file))


def build_pack(pack_name, file_list):
    print('Building pack %s ...' % pack_name)

    build_name = '_'.join([pack_name, version])
    release_path = os.path.join('dist', build_name)
    if os.path.exists(release_path):
        shutil.rmtree(release_path)

    os.mkdir(release_path)

    for src, dst in file_list:
        if src == '':
            os.mkdir(os.path.join(release_path, dst))
        elif os.path.isdir(src):
            clear_cache(src)
            shutil.copytree(src, os.path.join(release_path, dst))
        else:
            shutil.copy(src, os.path.join(release_path, dst))

    curr_path = os.getcwd()
    os.chdir('dist')

    zipf = zipfile.ZipFile(build_name + '.zip', 'w', zipfile.ZIP_DEFLATED)
    for dirpath, dirnames, filenames in os.walk(build_name):
        for filename in filenames:
            print('Adding %s/%s to archive ...' % (dirpath, filename))
            zipf.write(os.path.join(dirpath, filename))
        for dirname in dirnames:
            print('Adding %s/%s to archive ...' % (dirpath, dirname))
            zipf.write(os.path.join(dirpath, dirname))

    zipf.close()
    shutil.rmtree(build_name)

    print('Done.\n')

    os.chdir(curr_path)


pack_def = {
    'shepherd': [
        ('clematis_wrapper', 'clematis_wrapper'),
        ('shepherd', 'shepherd'),
        ('tool', 'bin'),
        ('setup/shepherd-env', 'shepherd-env')
    ],
    'spider-agent': [
        ('spider-agent.py', 'spider-agent.py'),
        ('', 'shepherd'),
        ('shepherd/logging_conf.py', 'shepherd/logging_conf.py'),
        ('clematis_wrapper/clematis/logging.conf', 'logging.conf'),
        ('scrapyd.conf.default', 'scrapyd.conf.default'),
        ('tool', 'bin'),
        ('setup/spider-agent-env', 'spider-agent-env'),
        ('', 'scrapyd')
    ],
    'shepherd-conda': [
        ('setup/conda-requirements.txt', 'conda-requirements.txt'),
        ('setup/pip-requirements.txt', 'pip-requirements.txt'),
        ('setup/condarc', 'condarc'),
        ('setup/pip.conf', 'pip.conf')
    ],
    'shepherd-db': [
        ('setup/demo/spiderdb.sql', 'spiderdb.sql'),
        ('setup/demo/spider_data.sql', 'spider_data.sql')
    ],
    'shepherd-solr': [
        ('setup/solr/crawler_configs', 'crawler_configs')
    ]
}

pack_list = []
if len(sys.argv) < 2:
    print('No pack name supplied, build shepherd by default.')
    pack_list.append('shepherd')
else:
    for arg in sys.argv[1:]:
        pack_list.append(arg)

version = '0.1.0'

if not os.path.exists('dist'):
    os.mkdir('dist')

for my_pack in pack_list:
    if my_pack not in pack_def:
        print('Unknown pack %s' % my_pack)
        exit(1)

    build_pack(my_pack, pack_def[my_pack])
