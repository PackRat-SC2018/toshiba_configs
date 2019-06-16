#!/bin/sh
# this file is executed when calling startx

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# user init scripts and settings
[ -r ~/.Xmodmap ] && xmodmap ~/.Xmodmap
[ -r ~/.Xresources ] && xrdb -merge ~/.Xresources
[ -r ~/.xprofile ] && . ~/.xprofile

# to start a different WM, set session="WM" below, or in console run:
#    startx ~/.xinitrc WM

# session to run if none passed as first arg ($1)
session="${1:-fluxbox}"

# set environment wm for use in scripts
export WM="$session"

# do NOT put commands below the exec lines
case $session in
    fluxbox)    exec dbus-launch --sh-syntax --exit-with-session startfluxbox ;;
    i3)         exec dbus-launch --sh-syntax --exit-with-session i3 ;;
    bspwm)      exec dbus-launch --sh-syntax --exit-with-session bspwm ;;
    *)          exec "$session" # Unknown, try running it
esac
