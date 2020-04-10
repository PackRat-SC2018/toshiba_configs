# .profile created 10-30-2019
#

# default umask
umask 022

# set editor
export EDITOR="$(if [[ -n $DISPLAY ]]; then echo 'subl3'; else echo 'nano'; fi)"
export VISUAL="$(if [[ -n $DISPLAY ]]; then echo 'subl3'; else echo 'nano'; fi)"

if [ -n "$DISPLAY" ]; then
    export BROWSER=firefox
else 
    export BROWSER=w3m
fi

# set the $PATH

# include sbin in PATH
if [ -d "/sbin" ] ; then
    PATH="/sbin:$PATH"
fi

if [ -d "/usr/sbin" ] ; then
    PATH="/usr/sbin:$PATH"
fi

if [ -d "/usr/local/bin" ] ; then
    PATH="/usr/local/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
#if [ -d "$HOME/bin" ] ; then
#    PATH="$HOME/bin:$PATH"
#fi

# If user ID is greater than or equal to 1000 & if ~/bin exists and is a directory & if ~/bin is not already in your $PATH
# then export ~/bin to your $PATH.
if [[ $UID -ge 1000 && -d $HOME/bin && -z $(echo $PATH | grep -o $HOME/bin) ]]
then
    export PATH=${PATH}:$HOME/bin:./
fi

# set shell
# . "$HOME/.mkshrc"
. "$HOME/.bashrc"
# . "$HOME/.zshrc"

# autologin on tty1 remove the exec if tty1 on wm exit required
# if [ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ]; then
# exec startx
# fi
