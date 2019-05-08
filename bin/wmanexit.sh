#!/usr/bin/env bash

yad --form --class=WmanExit --width=188 --height=360 --borders=5 --center --buttons-layout=left --undecorated --skip-taskbar --image=utilities-system-monitor --image-on-top \
--field="  Log Out!gnome-logout!Log out to console":fbtn "pkill `wmctrl -m | awk '/Name/ {print tolower($2)}'`" \
--field="  Lock Screen!gnome-lockscreen!Lock computer screen":fbtn "slock" \
--field="  Hibernate!gnome-session-hibernate!Hibernate the computer":fbtn "sudo ZZZ" \
--field="  Suspend!gnome-session-suspend!Suspend the computer":fbtn "sudo zzz" \
--field="  Restart!system-reboot!Reboot the computer":fbtn "sudo reboot" \
--field="  Shut Down!gnome-shutdown!Log out and power off":fbtn "sudo poweroff" \
--button=gtk-cancel \