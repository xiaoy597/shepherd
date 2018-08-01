class GeneralSpiderHelper(object):
    def __init__(self):
        pass

    def get_page_links(self, params, cur_page_id, page_content):
        pass


class SpiderHelperSLSJ(GeneralSpiderHelper):

    def __init__(self):
        super(SpiderHelperSLSJ, self).__init__()
        self.siteId = 'http://www.xinhuanet.com/silkroad/slsj.htm'
        return

    def get_page_links(self, params, cur_page_id, page_content):
        lines = page_content.split('\n')
        [line for line in lines if ]


spiderHelpers = {
    'http://www.xinhuanet.com/silkroad/slsj.htm': SpiderHelperSLSJ()
}
