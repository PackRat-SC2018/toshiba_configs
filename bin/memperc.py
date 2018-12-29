import os
import psutil

def memory_usage_psutil():
    # return the memory usage in percentage like top
    process = psutil.Process(os.getpid())
    mem = process.memory_percent()
    return mem

consume_memory = range(20*1000*1000)

while True:
    print memory_usage_psutil()