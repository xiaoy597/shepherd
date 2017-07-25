import psutil
import os

plist = []
for p in filter(lambda p: p.name() == 'firefox.exe' or p.name() == 'geckodriver.exe', psutil.process_iter()):
    print p, p.parent()
    plist.append((p, p.parent()))

for p, parent in plist:
    if parent is None and p.name() == 'geckodriver.exe':
        print 'kill %d' % p.pid
        os.kill(p.pid, 9)
        c = filter(lambda p1: p1[0].name() == 'firefox.exe' and p1[1].pid == p.pid, plist)[0]
        print 'kill %d' % c[0].pid
        os.kill(c[0].pid, 9)

