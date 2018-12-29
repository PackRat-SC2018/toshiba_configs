#!/bin/sh

# terminate running bars
killall -q sxhkd

# wait until processes have shut down
while pgrep -u $UID -x sxhkd >/dev/null; do sleep 1; done

# lauch the key grabber
sxhkd &

exit 0;

