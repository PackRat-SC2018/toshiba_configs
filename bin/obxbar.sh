#!/bin/sh

# terminate running bars
killall -q polybar

# wait until processes have shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# lauch the bars
polybar obxbar &

exit 0;
