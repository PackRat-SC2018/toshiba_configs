#!/bin/sh
# Example Bar Action Script for Linux.
# Requires: acpi, iostat.
# Tested on: Debian 10, Fedora 31.
#

print_date() {
	# The date is printed to the status bar by default.
	# To print the date through this script, set clock_enabled to 0
	# in spectrwm.conf.  Uncomment "print_date" below.
	FORMAT="%a %e %b %R  "
	DATE=`date "+${FORMAT}"`
	echo -n "${DATE}     "
}

print_mem() {
	MEM=`/usr/bin/free -m | grep ^Mem: | sed -E 's/ +/ /g' | cut -d ' ' -f4`
	echo -n "Free: ${MEM}M   "
}

print_memperc() {
	MEMPERC=`free | awk '/Mem/{printf("%.0f%"), $3/$2*100}'`
	echo -n "MEM:  ${MEMPERC}   "
}

_print_cpu() {
#	printf "CPU: %3d%% User %3d%% Nice %3d%% Sys %3d%% Idle  " $1 $2 $3 $6
	printf "CPU: %2d%%   " $1
}

print_cpu() {
	OUT=""
	# Remove the decimal part from all the percentages.
	while [ "${1}x" != "x" ]; do
		OUT="$OUT `echo "${1}" | cut -d '.' -f1`"
		shift;
	done
	_print_cpu $OUT
}

print_cpuspeed() {
	CPU_SPEED=`/usr/bin/lscpu | grep '^CPU MHz:' | sed -E 's/ +/ /g' | cut -d ' ' -f3 | cut -d '.' -f1`
	# printf "CPU speed: %4d MHz  " $CPU_SPEED
	printf "%4d MHz   " $CPU_SPEED
}

print_uptime() {
	UPTIME=`uptime | awk -F, '{sub(".*up ",x,$1);print $1}'`
	printf "UP: ${UPTIME}   "
}

print_load(){
	LOAD=`awk '{print $1" "$2" "$3}' < /proc/loadavg`
	printf "${LOAD}   "
}

print_signal(){
	QUALITY=`iwconfig wlp1s0 | awk '/Link Quality=/ {gsub(".*Quality=",x,$2);print $2}'`
	printf "NET: ${QUALITY}   "
}

print_bitrate(){
	BITRATE=`iwconfig wlp1s0 | awk '/Bit Rate=/ {gsub(".*Rate=",x,$2);print $2 $3}'`
	printf "${BITRATE}  "
}

print_bat() {
	AC_STATUS="$3"
	BAT_STATUS="$6"
	# Most battery statuses fit into a single word, except "Not charging"
	# for which we need to have special handling.
	if [ "$BAT_STATUS" = "Not" ]; then
		BAT_STATUS="$BAT_STATUS $7"
		shift
	fi
	BAT_LEVEL="`echo "$7" | tr -d ','`"

	if [ "$AC_STATUS" != "" -o "$BAT_STATUS" != "" ]; then
		if [ "$BAT_STATUS" = "Discharging," ]; then
			echo -n "BAT0: $BAT_LEVEL Disc  "
		else
			case "$AC_STATUS" in
			on-line)
				AC_STRING=" Char "
				;;
			*)
				AC_STRING=""
				;;
			esac
			case "$BAT_STATUS" in
			"")
				BAT_STRING="(no battery)"
				;;
			*harging,|Full,)
				BAT_STRING="$BAT_LEVEL"
				;;
			*)
				BAT_STRING="(battery unknown)"
				;;
			esac

			FULL="BAT0: ${BAT_STRING} ${AC_STRING} "
			if [ "$FULL" != "" ]; then
				echo -n "$FULL"
			fi
		fi
	fi
}

# Cache the output of acpi(8), no need to call that every second.
ACPI_DATA=""
I=0
while :; do
	IOSTAT_DATA=`/usr/bin/iostat -c | grep '[0-9]$'`
	if [ $I -eq 0 ]; then
		ACPI_DATA=`/usr/bin/acpi -a 2>/dev/null; /usr/bin/acpi -b 2>/dev/null`
	fi
#	print_memperc
#	print_cpu $IOSTAT_DATA
	print_signal
	echo ""
	I=$(( ( ${I} + 1 ) % 11 ))
	sleep 1
done
