
class SpiderHelperRegistry(object):
    pass


class GeneralSpiderHelper(object):
    def __init__(self):
        pass


class SpiderHelperSLSJ(GeneralSpiderHelper):

    def __init__(self):
        super(SpiderHelperSLSJ, self).__init__()
        self.siteId = 'http://www.xinhuanet.com/silkroad/slsj.htm'
        return

    def siteId(self):
        return self.siteId
