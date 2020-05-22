import os
import shutil
import logging


def log_file_handler(filename, mode='a', encoding=None, owner=None):
    if owner:
        if not os.path.exists(filename):
            open(filename, 'a').close()
        shutil.chown(filename, *owner)
    return logging.FileHandler(filename, mode, encoding)


LOGGING_CONF = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'default': {
            'format': '%(asctime)s %(levelname)s %(name)s %(message)s'
        },
        'console': {
            '()': 'colorlog.ColoredFormatter',
            'format': '%(log_color)s %(asctime)s %(name)-15s %(threadName)s %(levelname)-8s %(message)s'
        },
        'file': {
            'format': '%(asctime)s %(name)-15s %(threadName)s %(levelname)-8s %(message)s'
        }
    },
    'handlers': {
        'file': {
            '()': log_file_handler,
            'level': 'DEBUG',
            'formatter': 'file',
            # The values below are passed to the handler creator callable
            # as keyword arguments.
            'filename': 'shepherd.log',
            'mode': 'w',
            'encoding': 'utf-8',
        },
        'console': {
            'class': 'logging.StreamHandler',
            'formatter': 'console'
        }
    },
    'root': {
        'handlers': ['file', 'console'],
        'level': 'DEBUG',
    },
    'scrapy': {
        'handlers': ['file', 'console'],
        'level': 'WARNING',
    },
}
