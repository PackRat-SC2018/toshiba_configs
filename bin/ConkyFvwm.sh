#!/bin/sh
#
pgrep conky &>/dev/null; [ $? = 0 ] && killall conky
pgrep picom &>/dev/null; [ $? = 0 ] && killall picom
pkill -x polybar
#
# conky -p2 -dc /home/doug/conky/conkyhorizrc &
# conky -p2 -dc /home/doug/conky/conkyfvwmrc &
conky -p2 -dc /home/doug/conky/conkyfvwmsysrc &

exit 0;

