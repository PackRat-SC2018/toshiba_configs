#!/bin/sh

acpi -b | awk '/Battery 0/ { print $3" "$4"," }' | sed 's/,//g'

exit 0
