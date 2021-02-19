#!/bin/sh

pgrep picom &>/dev/null; [ $? = 0 ] && killall picom
pgrep conky &>/dev/null; [ $? = 0 ] && killall conky
pgrep polybar &>/dev/null; [ $? = 0 ] && killall polybar

conky -p4 -dc /home/doug/conky/conkyfluxboxrc &

conky -p 2 -d -c $HOME/conky/taoconky10rc &

exit 0;
