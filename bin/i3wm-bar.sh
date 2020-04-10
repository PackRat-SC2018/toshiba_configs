#!/bin/sh

# terminate running bars
killall -q conky
killall -q polybar

# wait until processes have shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# lauch the bars
polybar i3-bar &

exit 0;

