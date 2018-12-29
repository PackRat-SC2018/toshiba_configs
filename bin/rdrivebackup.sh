#!/bin/sh

# rsync backup utility script
#

#config
OPT="-arPh"
SRC="/home/doug/"
# DEST="/mnt/willow/zoe/"
# DATE=`date "+%Y_%B_%d_%s"`
DATE=`date "+%F_%s"`
NAME="ZOE-01"
SPACE="."
LOCALDEST="/home/doug/rdmnt/backups/"

# rsync to backup
rsync $OPT --exclude-from='/home/doug/bin/rexcludes.txt' $SRC ${LOCALDEST}$NAME$SPACE$DATE
