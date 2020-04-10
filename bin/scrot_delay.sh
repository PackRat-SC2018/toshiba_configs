#!/bin/sh

exec scrot -q 100 -c -d 4 '%B_%s_$wx$h.jpg' -e 'mv $f ~/pictures' &

exit 0;
