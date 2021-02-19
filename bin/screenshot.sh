#!/bin/sh
#

screenshot() {
	case $1 in
	full)
		# scrot -m -q 100 -cd 5 '%B_%s_$wx$h.jpg' -e 'mv $f ~/pictures'
		maim -u ~/Pictures/$(date +%F_%s).png
		;;
	window)
		sleep 1
		#scrot -s -q 100 '%B_%s_$wx$h.jpg' -e 'mv $f ~/pictures'
		maim -u -s ~/Pictures/$(date +%F_%s).png
		;;
	*)
		;;
	esac;
}

screenshot $1
