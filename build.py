# -*- coding:utf-8 -*-

import sys
import os
import shutil
import zipfile


def build_pack(pack_name, file_list):
    build_name = '_'.join([pack_name, version])
    release_path = os.path.join('dist', build_name)
    if os.path.exists(release_path):
        shutil.rmtree(release_path)

    os.mkdir(release_path)

    for src, dst in file_list:
        if os.path.isdir(src):
            shutil.copytree(src, os.path.join(release_path, dst))
        else:
            shutil.copy(src, os.path.join(release_path, dst))

    curr_path = os.getcwd()
    os.chdir('dist')

    zipf = zipfile.ZipFile(build_name + '.zip', 'w', zipfile.ZIP_DEFLATED)
    for dirpath, dirnames, filenames in os.walk(build_name):
        for filename in filenames:
            print 'Adding %s/%s to archive ...' % (dirpath, filename)
            zipf.write(os.path.join(dirpath, filename))

    zipf.close()
    shutil.rmtree(build_name)

    os.chdir(curr_path)


pack_def = {
    'shepherd': [
        ('clematis', 'clematis'),
        ('shepherd', 'shepherd')
    ],
    'spider-agent': [
        ('spider-agent.py', 'spider-agent.py')
    ]
}

pack_list = []
if len(sys.argv) < 2:
    print 'No pack name supplied, build shepherd by default.'
    pack_list.append('shepherd')
else:
    for arg in sys.argv[1:]:
        pack_list.append(arg)

version = '0.1.0'

if not os.path.exists('dist'):
    os.mkdir('dist')

for my_pack in pack_list:
    if my_pack not in pack_def:
        print 'Unknown pack %s' % sys.argv[1]
        exit(1)

    build_pack(my_pack, pack_def[my_pack])


