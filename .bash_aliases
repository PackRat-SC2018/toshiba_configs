# bash aliases
# created 20 Jan 2017
#==================================================#
alias ll='ls -lh -F --group-directories-first'
alias la='ls -A --group-directories-first'
alias ls='ls -hNCF --color=auto --group-directories-first'
alias rm='rm -vi'
alias cp='cp -vi'
alias mv='mv -vi'
alias dfh='df -hT'
alias dfk='df -kT'
alias du='du -h'
alias duh='du -hca'
alias path='echo -e ${PATH//:/\\n}'
alias emacs='emacs -nw'
alias joe='joe --wordwrap'
alias listusb='ls -l /dev/disk/by-id/*usb*'
alias sinfo='inxi -CSI -tcm3 -W 29803 --no-host'
alias screenfetch='screenfetch -n'
alias shotdate='date +%A_%s'
alias sshot='import -window root -quality 100 ~/pictures/screen-import-$(shotdate).png'
alias scrotpng='scrot -q 100 -c -d 5 ~/pictures/scrot-shot-%B_%e_%s.png'
alias scrotjpg='scrot -q 100 -c -d 5 ~/pictures/scrot-shot-%a_%e_%s.jpg'
alias kconky='killall -SIGUSR1 conky'
alias ktint2='killall -SIGUSR1 tint2'
alias kpolybar='killall -SIGUSR1 polybar'
alias ufont='fc-cache -f -v'
alias rufont='sudo fc-cache -f -v'
alias prmount='sudo mount -o rw,umask=000'
alias usbmnt='sudo mount -o rw,umask=000 /dev/sdc1 /media/usbhd'
alias win7mnt='sudo mount -o rw,umask=000 /dev/sda5 /mnt/Win7'
alias takeshot='neofetch ; scrotpng'
alias neoinfo='neofetch --backend off --color_blocks off'
alias getmp3='youtube-dl -x  --no-mtime --audio-format mp3'
alias mntarch='sshfs -p 9742 doug@WILLOW-01:/mnt/public /home/doug/archlabs'
alias umntarch='fusermount -u /home/doug/archlabs'
alias aura='aura -n 'user''
alias wget='wget -c'
alias mntpublic='sshfs -p 2410 doug@BANDIT-01:/mnt/public /home/doug/bandit/public'
alias mntdata='sshfs -p 2410 doug@BANDIT-01:/mnt/data01 /home/doug/bandit/data01'
alias umntpublic='fusermount -u /home/doug/bandit/public'
alias umntdata='fusermount -u /home/doug/bandit/data01'

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

