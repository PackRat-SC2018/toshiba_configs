#!/bin/sh
#
pgrep conky &>/dev/null; [ $? = 0 ] && killall conky
pgrep compton &>/dev/null; [ $? = 0 ] && killall compton
#
# conky -p 2 -dc "$HOME/conky/conkyfluxboxrc" & 
conky -p 2 -dc "$HOME/conky/conkyhorizrc" & 

exit 0
