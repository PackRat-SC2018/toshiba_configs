#!/bin/sh

# tint2 startup script

# terminate running tint2 ans other panels
killall -q conky
killall -q polybar
killall -q tint2

# wait until processes have shut down
while pgrep -u $UID -x tint2 >/dev/null; do sleep 1; done

# lauch the bars
# tint2 &
tint2 -c "$HOME/.config/tint2/tint2bspwmrc" &

exit 0;