# .profile created 4-18-2017
#

# pgrep sxhkd &>/dev/null; [ $? = 0 ] && killall sxhkd &

# set editor
export EDITOR="$(if [[ -n $DISPLAY ]]; then echo 'geany'; else echo 'emacs'; fi)"

if [ -n "$DISPLAY" ]; then
    export BROWSER=firefox
else 
    export BROWSER=w3m
fi

# set the $PATH
export PATH="${PATH}:$HOME/bin:$HOME/conky"

# default umask
umask 022

. ~/.bashrc
