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
if [ -f ~/.shell_aliases ]; then
        source ~/.shell_aliases
else
        print "Note: ~/.zsh/zshaliases is unavailable."
fi

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
