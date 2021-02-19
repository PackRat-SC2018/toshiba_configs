#!/bin/sh

# rsync backup utility script
#

#config
OPT="-arPh"
SRC="/home/doug/"
# DEST="/run/media/doug/SDD-4GB-BU/"
DEST="/run/media/doug/SDHD-4GB/backups/"
NAME="ZOE-01"
SPACE="."
DATE=`date "+%F_%s"`

# rsync to backup
rsync $OPT --exclude-from='/home/doug/bin/rexcludes.txt' $SRC ${DEST}$NAME$SPACE$DATE

exit 0;
