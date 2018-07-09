#!/bin/sh

# polybar
# Terminate already running bar instances
pkill -x polybar &

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

(sleep 2s && polybar i3-bar) &