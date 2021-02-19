#!/bin/sh

exec scrot -q 100 -c -d 4 '%F_%s.jpg' -e 'mv $f ~/pictures' &

exit 0;
