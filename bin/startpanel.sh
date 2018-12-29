#!/bin/sh

# tint2 startup script

# terminate running tint2
killall -q tint2

# wait until processes have shut down
while pgrep -u $UID -x tint2 >/dev/null; do sleep 1; done

# lauch the bars
# tint2 &
tint2 -c "$HOME/.config/tint2/tint2obxrc" &

exit 0