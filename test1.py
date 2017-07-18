
class MyClass(object):
    var = None

    def __init__(self, **kwargs):
        self.var = kwargs['var']
        self.var1 = kwargs['var1']

    def hello(self):
        print "hello! %s, %s" % (self.var, self.var1)

if __name__ == "__main__":
    obj = MyClass(var="123", var1='12333')
    obj.hello()

