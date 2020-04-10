#!/usr/bin/env bash

question=$(echo "  lock|  suspend|  logout|  reboot|  shutdown" | rofi -sep "|" \
    -dmenu -i -p 'System: ' "" -width 20 -hide-scrollbar -font "Ubuntu 11" \
    -eh 1 -line-padding 4 -padding 20 -no-config -lines 5 -color-enabled \
    -color-window "#2b303b, #8fa1b3, #2b303b" \
    -color-normal "#2b303b, #8fa1b3, #2b303b, #8fa1b3, #2b303b")

case $question in
    *lock)
        slock
        ;;
    *suspend)
        sudo zzz
        ;;
    *logout)
        killall `wmctrl -m | awk '/Name/ {print tolower($2)}'`
        ;;
    *reboot)
        sudo reboot
        ;;
    *shutdown)
        sudo poweroff
        ;;
    *)
        exit 0  # do nothing on wrong response
        ;;
esac
