#!/bin/sh

# terminate running bars
killall -q conky
killall -q polybar
killall -q tint2

# wait until processes have shut down
while pgrep -u $UID -x tint2 >/dev/null; do sleep 1; done

# lauch tint2
tint2 &

exit 0;

