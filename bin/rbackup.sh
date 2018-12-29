#!/bin/sh

# rsync backup utility script
#

#config
OPT="-arPh"
SRC="/home/doug/"
DEST="/mnt/willow/backups/"
DATE=`date "+%F_%s"`
# DATE=`date "+%Y_%B_%d_%s"`
NAME="ZOE-01"
SPACE="."
#LOCALDEST="/mnt/public/backups/"
LOCALDEST="/mnt/bandit/usb01/backups/"

# rsync to backup
rsync $OPT --exclude-from='/home/doug/bin/rexcludes.txt' $SRC ${DEST}$NAME$SPACE$DATE
# rsync $OPT --exclude-from='/home/doug/bin/rexcludes.txt' $SRC ${LOCALDEST}backup_08102017
