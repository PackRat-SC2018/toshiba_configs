#!/usr/bin/python
# _*_ coding: utf-8 _*_

import sys
import psutil
import time

result_start = psutil.net_io_counters()
time.sleep(1)
result_finish = psutil.net_io_counters()

print('U: {:0.2f}'.format((result_finish[0] - result_start[0]) / 1024) + ' D: {:0.2f} kB/s'.format(
    (result_finish[1] - result_start[1]) / 1024))
