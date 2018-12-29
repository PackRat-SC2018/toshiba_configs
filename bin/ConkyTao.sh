#!/bin/sh
#
# pgrep conky &>/dev/null; [ $? = 0 ] && killall conky
#
conky -d -c /home/doug/conky/taoconky10rc &

exit 0;
