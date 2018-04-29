# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
# PS1='[\u@\h \W]\$ '
export PS1='\[\033[0;36m\] ┌ ─ [\l] ─ \[\033[1;34m\][\w]\n \[\033[0;36m\]└ ─ > \[\033[0;37m\]$ \[\033[0;37m\]'

# user added

shopt -s histappend
shopt -s cmdhist
shopt -s histverify
shopt -s cdspell
shopt -s dirspell
shopt -s checkwinsize
shopt -s checkhash
shopt -s dotglob
shopt -s extglob
shopt -s globstar
shopt -s progcomp
shopt -u hostcomplete
shopt -s no_empty_cmd_completion
shopt -u sourcepath
shopt -s shift_verbose
shopt -s checkjobs
stty -ixon -ctlecho 2>/dev/null

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

if [ -f $HOME/.bash_aliases ] ; then
. $HOME/.bash_aliases
fi

# colored man pages
export PAGER="less"

export LESS_TERMCAP_mb=$(tput bold; tput setaf 2)
export LESS_TERMCAP_md=$(tput bold; tput setaf 6)
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4)
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7)
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)

# PATH=$PATH:$HOME/bin:$HOME/conky:./

# If user ID is greater than or equal to 1000 & if ~/bin exists and is a directory & if ~/bin is not already in your $PATH
# then export ~/bin to your $PATH.
#if [[ $UID -ge 1000 && -d $HOME/bin && -z $(echo $PATH | grep -o $HOME/bin) ]]
#then
#    export PATH=$HOME/bin:$HOME/conky:${PATH}
#fi

# export EDITOR="$(if [[ -n $DISPLAY ]]; then echo 'geany'; else echo 'nano'; fi)"

