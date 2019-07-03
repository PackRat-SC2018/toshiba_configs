# If not running interactively, don't do anything
[[ $- != *i* ]] && return

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

autoload -Uz compinit
compinit

setopt AUTO_CD # No cd needed to change directories
setopt BANG_HIST # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS # Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_DUPS # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_SPACE # Don't record an entry starting with a space.
setopt HIST_REDUCE_BLANKS # Remove superfluous blanks before recording entry.
setopt HIST_SAVE_NO_DUPS # Don't write duplicate entries in the history file.
setopt INC_APPEND_HISTORY # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY # Share history between all sessions.

for c in cp rm chmod chown rename; do
    alias $c="$c -v"
done

# aliases and functions

# Test and then source alias definitions.
if [ -f ~/.zsh/zshaliases ]; then
        source ~/.zsh/zshaliases
else
        print "Note: ~/.zsh/zshaliases is unavailable."
fi

# Test and then source the functions.
if [ -f ~/.zsh/zshfunctions ]; then
        source ~/.zsh/zshfunctions
else
        print "Note: ~/.zsh/zshfunctions is unavailable."
fi

alias ll='ls -lh -F --group-directories-first'
alias la='ls -A --group-directories-first'
alias ls='ls -hNCF --color=auto --group-directories-first'
alias rm='rm -vi'
alias cp='cp -vi'
alias mv='mv -vi'
alias mkdir='mkdir -pv'
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
alias mntarch='sshfs -p 1456 doug@WILLOW-01:/mnt/public /home/doug/archlabs'
alias umntarch='fusermount -u /home/doug/archlabs'
alias aura='aura -n 'user''
alias wget='wget -c'
alias mntpublic='sshfs -p 2410 doug@BANDIT-01:/mnt/public /home/doug/bandit/public'
alias mntdata='sshfs -p 2410 doug@BANDIT-01:/mnt/data01 /home/doug/bandit/data01'
alias umntpublic='fusermount -u /home/doug/bandit/public'
alias umntdata='fusermount -u /home/doug/bandit/data01'

alias doy="date '+%j'"
alias ydoy="date '+%j%y'"
alias yydoy="date '+%j%Y'"
alias vdt="date '+%v'"
alias dt="date '+%D %r'"
alias dt0="date '+%D'"
alias isodate="date '+%G-%m-%d'"
alias isodt="date '+%G-%m-%d %H:%M'"
alias isodts="date '+%G-%m-%d %H:%M:%S'"

alias d="ls -1p | sed -n '/\/$/s/^/    /p;'"
alias dl="ls -lhp | grep '^d'"
alias DL="ls -lTthp | grep '^d'"

alias x='ls -xF'
alias r='ls -1RF'
alias rr='ls -lRF'  
alias R='BLOCKSIZE=1m ls -s1R'
# alias ll='ls -Llh'
alias lm='BLOCKSIZE=1m ls -sF'
alias lmm='BLOCKSIZE=1m ls -1sSF'
#alias Lz="stat -f '%Lz' "
#alias Z="stat -f '%z' "
##### Z=bytes
alias dirs="ls -1Ap | grep '/$' | column"
alias files="ls -1AF | sed  '/[@/]$/d;s/\*$//' |column" 
alias files1="ls -1AF | sed  '/[@/]$/d;s/\*$//'"
alias syms="ls -1AF | grep '@$'"
#alias 2cd='pbcopy <<< $PWD'
#alias cd2='cd $(pbpaste <<< $PWD)'
alias aux='ps aux'
alias vax='ps vax'
alias jax='ps jax'
alias lax='ps lax'
alias axl='ps axl'
alias ax='ps ax'
alias cax='ps cax'
alias caxl='ps caxl'
#alias pcpu='ps rcxo pcpu,pid,uid,command'
#alias pmem='ps mxco pmem,pid,uid,command'
#alias ptop='ps mcxo pcpu,pmem,pid,uid,command | head -n $(( LINES - 3 ))'
#alias mem='ps mxco rss,pid,uid,command'

alias 1ping='ping -qc 1 -t 2'

#------------------------------
# History stuff
#------------------------------
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

#------------------------------
# Variables
#------------------------------
export EDITOR="$(if [[ -n $DISPLAY ]]; then echo 'subl3'; else echo 'jmacs'; fi)"
export VISUAL="$(if [[ -n $DISPLAY ]]; then echo 'subl3'; else echo 'jmacs'; fi)"

if [ -n "$DISPLAY" ]; then
    export BROWSER=firefox
else 
    export BROWSER=w3m
fi

typeset -U path
# path=(~/bin /other/things/in/path $path[@])
path=(~/bin ~/conky $path[@])

#-----------------------------
# Dircolors
#-----------------------------
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

#------------------------------
# ShellFuncs
#------------------------------
# -- coloured manuals
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

#------------------------------
# Prompt
#------------------------------

autoload -Uz promptinit
promptinit

autoload -U colors zsh/terminfo
colors

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats "%{${fg[cyan]}%}[%{${fg[green]}%}%s%{${fg[cyan]}%}][%{${fg[blue]}%}%r/%S%%{${fg[cyan]}%}][%{${fg[blue]}%}%b%{${fg[yellow]}%}%m%u%c%{${fg[cyan]}%}]%{$reset_color%}"

setprompt() {
  setopt prompt_subst

  if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then 
    p_host='%F{yellow}%M%f'
  else
    p_host='%F{green}%M%f'
  fi

  PS1=${(j::Q)${(Z:Cn:):-$'
    %F{3}[%f
    %(!.%F{red}%n%f.%F{3}%l%f)
    %F{3}]%f
    %F{8}-%f
    %F{12}[%f
    %F{12}%~%f
    %F{12}]%f
    %(!.%F{red}%#%f.%F{7}%#%f)
    " "
  '}}

  PS2=$'%_>'
  RPROMPT=$'${vcs_info_msg_0_}'
}
setprompt

#prompt=[%l]-[%d]-%#

# neofetch
