#!/bin/sh

# this file is executed when calling startx

# to start a different WM, set session="WM" below, or in console run:
#    startx ~/.xinitrc WM


# session to run if none passed as first arg ($1)
session="${1:-fluxbox}"

# set environment wm for use in scripts
export WM="$session"

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# display timeout and sleep
xset s 600 1200
xset dpms 3600 3700 4000

# keyboard repeat rate
xset r rate 400 50
kbdrate -d 400 -r 50

# do NOT put commands below the exec lines
case $session in
    fluxbox)    exec dbus-launch --sh-syntax  --exit-with-session /usr/bin/startfluxbox ;;
    fvwm)       exec dbus-launch --sh-syntax  --exit-with-session /usr/local/bin/startfvwm ;;
    dwm)        exec dbus-launch --sh-syntax  --exit-with-session /usr/local/bin/startdwm ;;
    spectrwm)   exec dbus-launch --sh-syntax  --exit-with-session /usr/local/bin/startspectrwm ;;
    i3)         exec dbus-launch --sh-syntax  --exit-with-session i3 ;;
    bspwm)      exec dbus-launch --sh-syntax  --exit-with-session bspwm ;;
    awesome)    exec dbus-launch --sh-syntax  --exit-with-session awesome ;;
    *)          exec "$session" # Unknown, try running it
esac
