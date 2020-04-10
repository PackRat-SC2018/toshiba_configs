#!/bin/sh
#
pgrep conky &>/dev/null; [ $? = 0 ] && killall conky
pgrep compton &>/dev/null; [ $? = 0 ] && killall compton
pkill -x polybar
#
# conky -p4 -dc /home/doug/conky/conkyfboxrc &
conky -p4 -dc /home/doug/conky/conkysysinforc &

exit 0
