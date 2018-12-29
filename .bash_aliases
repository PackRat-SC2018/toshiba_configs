# bash aliases
# created 20 Jan 2017
#==================================================#
alias ll='ls -lh -F --group-directories-first'
alias la='ls -A --group-directories-first'
alias ls='ls -CF --color --group-directories-first'
alias rm='rm -vi'
alias cp='cp -vi'
alias mv='mv -vi'
alias nano='nano -BSwl'
alias emacs='emacs -nw'
alias dfh='df -hT'
alias dfk='df -kT'
alias du='du -h'
alias duh='du -hca'
alias path='echo -e ${PATH//:/\\n}'
alias listusb='ls -l /dev/disk/by-id/*usb*'
alias sinfo='inxi -CSI -tcm2 -W 29803 --no-host'
alias screenfetch='screenfetch -n'
alias neoinfo='neofetch --backend off'
alias xbacklight='sudo xbacklight'
alias sshot='import -window root -quality 100 ~/pictures/i3screen-import-`date +%F_%s`.png'
alias scrotpng='scrot -q 100 -cd 5 ~/pictures/sshot-%T_%F.png'
alias scrotjpg='scrot -q 100 -c -d 5 ~/pictures/scrot-shot-%T_%F.jpg'
alias kconky='pkill -USR1 -x conky'
alias ktint2='killall -SIGUSR1 tint2'
alias kpolybar='pkill -USR1 -x polybar'
alias ufont='fc-cache -f -v'
alias prmount='sudo mount -o rw,umask=000'
alias rufont='sudo fc-cache -f -v'
alias hpcam='sudo modprobe uvcvideo'
alias playdvd='mpv dvd:// --sub=no'
alias playmedia='mpv --player-operation-mode=pseudo-gui'
alias esudo='sudo EDITOR=/usr/bin/emacs visudo'
alias obxprop='obxprop | grep "^_OB_APP"'
alias getmp3="youtube-dl -x --audio-format mp3"
alias forecast="curl 'wttr.in/aiken,south_carolina'"

# sshfs mounts - get port correct
alias mntdata="sshfs -p 2410 doug@BANDIT-01:/mnt/data01 /home/doug/bandit/data01"
alias mntpublic="sshfs -p 2410 doug@BANDIT-01:/mnt/public /home/doug/bandit/public"
alias umntdata="fusermount -u /home/doug/bandit/data01"
alias umntpublic="fusermount -u /home/doug/bandit/public"

# Functions
# Extract archives
extract () {
if [ -f $1 ] ; then
case $1 in
*.tar.bz2) tar xjf $1 ;;
*.tar.gz) tar xzf $1 ;;
*.bz2) bunzip2 $1 ;;
*.rar) rar x $1 ;;
*.gz) gunzip $1 ;;
*.tar) tar xf $1 ;;
*.tbz2) tar xjf $1 ;;
*.tgz) tar xzf $1 ;;
*.zip) unzip $1 ;;
*.Z) uncompress $1 ;;
*.7z) 7z x $1 ;;
*) echo "'$1' cannot be extracted via extract()" ;;
esac
else
echo "'$1' is not a valid file"
fi
}

