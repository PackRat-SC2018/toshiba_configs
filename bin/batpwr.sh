#!/bin/sh

exec 2>&1


INTERVAL=300 # in seconds


while true

do

if [ ! "$(cat /sys/class/power_supply/BAT0/status)" = "Full" ]; then

battery_level=$(cat /sys/class/power_supply/BAT0/capacity)

if [ "${battery_level}" -le "10" ]; then

notify-send "Battery low" "Battery level is ${battery_level}%!"

elif [ "${battery_level}" -le "6" ]; then

notify-send "Battery very low" "Battery level is ${battery_level}%! Suspending system in 1 minute."

sleep 60

sudo zzz -z

fi

fi

sleep ${INTERVAL}

done
