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

# don't put duplicate lines or lines starting with space in the history.
export HISTCONTROL=ignoreboth
export HISTIGNORE="&:l:[bf]g:exit:mutt:w:ws:jobs"
export HISTSIZE=100000
export HISTFILESIZE=500000

# append to the history file, don't overwrite it
shopt -s histappend

shopt -s cdspell cmdhist extglob

export PATH=$PATH:/sbin:/usr/sbin:~/bin

# Change the window title of X terminals 
case $TERM in
   xterm*|rxvt|Eterm|eterm)
      PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
      ;;
   screen)
      PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
      ;;
esac

##uncomment the following to activate bash-completion:
[ -f /etc/profile.d/bash-completion ] && source /etc/profile.d/bash-completion

export CL1="\[\033[01;32m\]"
export CL2="\[\033[01;34m\]"
export PS1="$CL1($CL2\D{%m/%d} \t$CL1) \j \u@\h:$CL2\w\n$CL2$ \[\033[0m\]"

export LANG=

export PAGER="less"

export GREP_OPTIONS="--color --line-number"

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

if [ $(uname -s) == "Darwin" ]; then
   alias ls="ls -F"

   if [ -f /usr/local/bin/vim ]; then
      export EDITOR="/usr/local/bin/vim"
   fi

   if [ -x /usr/local/bin/vim ]; then
      alias vim="/usr/local/bin/vim"
   fi
fi

# set et:sw=3:ts=3
