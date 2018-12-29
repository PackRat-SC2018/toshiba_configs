#!/bin/sh

# kill processes we don't want running

killall -q compton
killall -q polybar
killall -q conky

while pgrep -u $UID -x conky >/dev/null; do sleep 1; done

# start conky
conky -p 2 -dc "$HOME/conky/conkybspwmrc" &

exit 0;