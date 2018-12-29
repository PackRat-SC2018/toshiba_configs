#!/usr/bin/env bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

# kill apps from other wm's
#pgrep sxhkd &>/dev/null; [ $? = 0 ] && killall sxhkd &
#pgrep conky &>/dev/null; [ $? = 0 ] && killall conky &
#pgrep compton &>/dev/null; [ $? = 0 ] && killall compton &
#pgrep polybar &>/dev/null; [ $? = 0 ] && killall polybar &
#pgrep slstatus &>/dev/null; [ $? = 0 ] && killall i3status &

killall -q compton
killall -q conky
killall -q slstatus

# standard environment
xmodmap "$HOME/.Xmodmap" &
xrdb -l "$HOME/.Xresources" &
xsetroot -solid "#2B2F72" &

numlockx on

# battery monitor
juiced -d

# polybar
# Terminate already running bar instances
pkill -x polybar &

# Wait until the processes have been shut down
#while pgrep -x polybar >/dev/null; do sleep 1; done

#(sleep 2s && polybar awesome-bar) &

# nitrogen --restore &
"$HOME/.fehbg" &

# (sleep 2s && tint2) &
