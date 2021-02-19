#!/bin/bash

# killall -q juiced ; juiced -d &

juiced -d &

numlockx on &

xmodmap /home/doug/.Xmodmap &

exec dbus-run-session sway

exit 0;
