#!/bin/sh

exec scrot -q 100 -cd 5 'sshot-%T_%F.png' -e 'mv $f /home/doug/images/' &

exit 0
