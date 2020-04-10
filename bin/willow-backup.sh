#!/bin/sh

# rsync backup utility script
#

#config
OPT="-arPh"
SRC="/home/doug/"
DATE=`date "+%F_%s"`
NAME="ZOE-01"
SPACE="."
LOCALDEST="/home/doug/Willow/backups/"

# rsync to backup
rsync $OPT --exclude-from='/home/doug/bin/rexcludes.txt' $SRC ${LOCALDEST}$NAME$SPACE$DATE
