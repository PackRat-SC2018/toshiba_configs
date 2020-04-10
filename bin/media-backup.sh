#!/bin/sh

# rsync backup utility script
#

#config
OPT="-arPh"
SRC="/home/doug/"
DEST="/run/media/doug/64A0-88B3/"
# DEST="/run/media/doug/SDHC-32GBL/backups/"
NAME="ZOE-01"
SPACE="."
DATE=`date "+%F_%s"`

# rsync to backup
rsync $OPT --exclude-from='/home/doug/bin/rexcludes.txt' $SRC ${DEST}$NAME$SPACE$DATE

exit 0;
