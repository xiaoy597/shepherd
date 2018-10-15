#
# from twisted.internet import reactor
# import scrapy
# from scrapy.crawler import CrawlerRunner
# from scrapy.utils.log import configure_logging
# from clematis.spiders.spider2 import Spider2
#
#
# configure_logging({'LOG_FORMAT': '%(levelname)s: %(message)s'})
# runner = CrawlerRunner()
#
# d = runner.crawl(Spider2)
# d.addBoth(lambda _: reactor.stop())
#
# # the script will block here until the crawling is finished
# reactor.run()
#
#

from scrapy import cmdline
from scrapy.utils.log import configure_logging

configure_logging({'LOG_FORMAT': '%(levelname)s: %(message)s'})

cmdline.execute(['scrapy', 'crawl', 'spider2'])