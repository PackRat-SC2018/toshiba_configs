#!/bin/sh

# terminate running juice daemons
killall -q juiced

# wait until processes have shut down
while pgrep -u $UID -x juiced >/dev/null; do sleep 1; done

# lauch the bars
juiced -d &

exit 0;
