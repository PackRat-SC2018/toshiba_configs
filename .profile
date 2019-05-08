# .profile created 4-18-2017
#

# pgrep sxhkd &>/dev/null; [ $? = 0 ] && killall sxhkd &

# set editor
export EDITOR="$(if [[ -n $DISPLAY ]]; then echo 'subl3'; else echo 'jmacs'; fi)"
export VISUAL="$(if [[ -n $DISPLAY ]]; then echo 'subl3'; else echo 'jmacs'; fi)"

if [ -n "$DISPLAY" ]; then
    export BROWSER=firefox
else 
    export BROWSER=w3m
fi

# If user ID is greater than or equal to 1000 & if ~/bin exists and is a directory & if ~/bin is not already in your $PATH
# then export ~/bin to your $PATH.
if [[ $UID -ge 1000 && -d $HOME/bin && -z $(echo $PATH | grep -o $HOME/bin) ]]
then
    export PATH=${PATH}:$HOME/bin:
fi

# default umask
umask 022

source $HOME/.bash_aliases

export PS1='\[\033[0;36m\] ┌ ─ [\l] ─ \[\033[1;34m\][\w]\n \[\033[0;36m\]└ ─ > \[\033[0;37m\]$ \[\033[0;37m\]'

# autologin on tty1 remove the exec if tty1 on wm exit required
# if [ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ]; then
# exec startx
# fi
