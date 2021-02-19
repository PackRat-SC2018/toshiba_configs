#!/bin/bash
# shellcheck disable=SC2059,SC2064,SC2086

# simple lightweight lemonbar script for use with dk


bg="#111111"
fg="#666666"
highlight="#002E9B"
underline=2
seperator=" | "

# font0="-xos4-terminus-medium-r-normal-*-14-140-72-72-c-80-iso10646-1"
font0="Roboto Mono:size=10:regular:antialias=true:hintstyle=slight"
font1="-xos4-terminus-medium-r-normal-*-14-140-72-72-c-80-iso10646-1"
font2="DejaVu Markup:size=10:regular:antialias=true:hintstyle=slight"
font3="Mononoki Nerd Font:size=18:regular:antialias=true:hintstyle=slight"

fifo="/tmp/bar.fifo"

# mimic dwm style layout symbols
typeset -A layouts=(
[tile]="[]="
[mono]="[M]"
[none]="><>"
[grid]="###"
[spiral]="(@)"
[dwindle]="[\\]"
[tstack]="F^F"
)

clock()
{
	if [[ $1 ]]; then
		while :; do
			date +"%%{A1:$1:}T%a %e %b %R%%{A}"
			sleep 10
		done
	else
		while :; do
			date +"T%a %e %b %R"
			sleep 10
		done
	fi
}

battery()
{
	if [[ $1 ]]; then
		while :; do
			printf 'B%s\n' "%{A1:$1:}$(acpi --battery 2>/dev/null | awk '/Battery 0/' | cut -d, -f2 | tr -d '[:space:]')%{A}"
			sleep 10
		done
	else
		while :; do
			printf 'B%s\n' "$(acpi --battery 2>/dev/null | awk '/Battery 0/' | cut -d, -f2 | tr -d '[:space:]')"
			sleep 10
		done
	fi
}

volume()
{
	if [[ $1 ]]; then
		while :; do
			printf 'V%s\n' "%{A1:$1:}$(amixer -M get Master | awk '$0~/%/{print $4}' | tr -d '[]')%{A}"
			sleep 0.2
		done
	else
		while :; do
			printf 'V%s\n' "$(amixer -M get Master | awk '$0~/%/{print $4}' | tr -d '[]')"
			sleep 0.2
		done
	fi
}

parsefifo()
{
	typeset f='' b='' u='' wm='' time='' bat='' vol='' title='' layout=''

	while read -r line; do
		case $line in
			T*) time="${line#?}" ;;
			V*) vol="${line#?}" ;;
			B*) bat="${line#?}" ;;
			A*) title="${line#?}" ;;
			L*) l="${line#?}"; layout="${layouts[$l]}" ;;
			W*)
				wm='' IFS=':'
				set -- ${line#?}
				while (( $# > 0 )); do
					item=$1
					name=${item#?}
					case $item in
						A*) f="$highlight" b="$bg" u="$highlight" ;; # occupied   - focused
						a*) f="$fg" b="$bg" u="$highlight" ;;        # occupied   - unfocused
						I*) f="$highlight" b="$bg" u="$fg" ;;        # unoccupied - focused
						i*) f="$fg" b="$bg" u="$fg" ;;               # unoccupied - unfocused
					esac
					wm="$wm%{F$f}%{B$b}%{+u}%{U$u}%{A:dkcmd ws $name:} $name %{A}%{-u}%{B-}%{F-}"
					shift
				done
				;;
		esac
		printf "%s\n" "%{l}$wm  $layout $seperator %{c}$title%{r}$seperator BAT0: $bat  VOL: $vol  $time "
	done
}


# kill the process and cleanup if we exit or get killed
trap "trap - TERM; kill 0; rm -f '$fifo'" INT TERM QUIT EXIT

# make the fifo
[ -e "$fifo" ] && rm "$fifo"
mkfifo "$fifo"


# here we dump info into the FIFO, order does not matter things are parsed
# out using the first character of the line click commands for left button
# can be added by passing an argument containing the command
clock '' > "$fifo" &
battery '' > "$fifo" &
volume 'amixer' > "$fifo" &
dkcmd status > "$fifo" &


# run the pipeline
parsefifo < "$fifo" | lemonbar -a 32 -u $underline -B "$bg" -F "$fg" -f "$font0" -f "$font1" -f "$font2" -f "$font3" | sh

# vim:ft=sh:fdm=marker:fmr={,}
