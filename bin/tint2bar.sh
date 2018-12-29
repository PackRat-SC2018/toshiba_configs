#!/bin/sh

# tint2 bar
#
killall -q polybar
killall -q conky
killall -q tint2

# wait until processes have shut down
while pgrep -u $UID -x tint2 >/dev/null; do sleep 1; done

# launch tint2
tint2 &

exit 0;
