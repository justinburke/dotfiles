# This file is sourced by all *interactive* bash shells on startup.  This
# file *should generate no output* or it will break the scp and rcp commands.

# colors for ls, etc.
if [ -e /etc/DIR_COLORS ]; then
   eval `dircolors -b /etc/DIR_COLORS`
fi

alias l='ls -l'
alias ls="ls --color=auto"
alias ll="l -a"

alias more='less'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias po=popd
alias pd=pushd

alias res='screen -x'
alias ws='w | sort'

alias pst='ps axjf'   # pstree-like output from ps

# don't put duplicate lines or lines starting with space in the history.
export HISTCONTROL=ignoreboth
export HISTIGNORE="&:l:[bf]g:exit:mutt:w:ws:jobs"
export HISTSIZE=100000
export HISTFILESIZE=500000

# append to the history file, don't overwrite it
shopt -s histappend

shopt -s cdspell cmdhist extglob

# https://spin.atomicobject.com/2016/05/28/log-bash-history/
if [[ ! -d ~/.logs ]]; then
	mkdir ~/.logs;
fi
export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi'

export PATH=$PATH:/sbin:/usr/sbin:~/bin

# Disabled 2017-12-16; replaced with command logging.
## Change the window title of X terminals
#case $TERM in
#   xterm*|rxvt|Eterm|eterm)
#      PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
#      ;;
#   screen)
#      PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
#      ;;
#esac

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export CL1="\[\033[01;32m\]"
export CL2="\[\033[01;34m\]"
export PS1="$CL1($CL2\D{%m/%d} \t$CL1) \j \u@\h:$CL2\w\n$CL2$ \[\033[0m\]"

export LANG=

export PAGER="less"

# GREP_OPTIONS has been deprecated
#export GREP_OPTIONS="--color --line-number"

# Fix sort order:
# (From http://www.madboa.com/geek/utf8/)
export LC_COLLATE="C"

# use -X so that less doesn't clear the screen
export LESS="${LESS:+$LESS }-X -R"

alias fixagent="ln -sf $SSH_AUTH_SOCK $HOME/.ssh/agent-socket"
alias sp='source $HOME/.gpg-agent-info'

export RAMDIR=/ramdisk/$USER
if [ -d /ramdisk -a ! -d $RAMDIR ]; then
   mkdir $RAMDIR && chmod 0700 $RAMDIR
fi

if [ -f /etc/bash_completion.d/password-store ]; then
   source /etc/bash_completion.d/password-store
elif [ -f /usr/local/etc/bash_completion.d/password-store ]; then
   source /usr/local/etc/bash_completion.d/password-store
fi

if [ -f /usr/local/etc/bash_completion.d/brew ]; then
   source /usr/local/etc/bash_completion.d/brew
fi

export EDITOR=vim
if [ $(uname -s) == "Darwin" ]; then
   alias ls="ls -F"

   if [ -f /usr/local/bin/vim ]; then
      export EDITOR="/usr/local/bin/vim"
   fi

   if [ -x /usr/local/bin/vim ]; then
      alias vim="/usr/local/bin/vim"
   fi
fi

export GIT_EDITOR=$EDITOR

which brew 2>/dev/null
if [[ !? == 0 && -x "$(brew --prefix)/bin/ctags" ]]; then
  alias ctags="$(brew --prefix)/bin/ctags"
fi

function git_ps() {
	export PS1='\[\033[01;32m\](\[\033[01;34m\]\D{%m/%d} \t\[\033[01;32m\]) \j \u@\h:\[\033[01;34m\]$(dirs)$(__git_ps1)\n\[\033[01;34m\]$ \[\033[0m\]'
	export GIT_PS1_SHOWDIRTYSTATE=1
}

# set et:sw=3:ts=3
