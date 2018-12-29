#!/bin/sh

acpi -b | awk '/Battery 0/ { print $4"," }' | sed 's/,//g'

exit 0
