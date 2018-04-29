#!/usr/bin/env bash

#The icon that would change color
icon=" "

if pgrep -x "compton" > /dev/null
then
	echo "$icon"
else
	echo "%{F#484852}$icon"
fi
