
from scrapy import cmdline
from scrapy.utils.log import configure_logging

configure_logging({'LOG_FORMAT': '%(levelname)s: %(message)s'})

cmdline.execute(['scrapy', 'crawl', 'spider2'])