# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# some more ls aliases
alias ll='ls -alF'
alias l='ls -lF'

# Additional aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias po=popd
alias pd=pushd

alias res='screen -x'

alias sp='source $HOME/.gpg-agent-info'

# pstree-like output
alias pst='ps axjf'

export HISTIGNORE="&:l:[bf]g:exit:mutt:w:ws:jobs"
export HISTSIZE=100000
export HISTFILESIZE=500000

shopt -s cdspell cmdhist extglob

export CL1="\[\033[01;32m\]"
export CL2="\[\033[01;34m\]"
#export PS1="$CL1($CL2\D{%m/%d} \t$CL1) \j \u@\h:$CL2\w\n$CL2$ \[\033[0m\]"
# Add in dirs:
export PS1="$CL1($CL2\D{%m/%d} \t$CL1) \j \u@\h:$CL2\$(dirs)\n$CL2$ \[\033[0m\]"

export LANG=
export LESS="${LESS:+$LESS }-R -X"
export PAGER="less"
export EDITOR="vim"
export PATH=$HOME/bin:$PATH:$HOME/local/bin

if [ ! -z "$(which gpg2)" ]; then
  alias gpg="$(which gpg2)"
fi
if [ -e $HOME/.gnupg/S.gpg-agent.ssh ]; then
  export SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"
elif [ -e $HOME/.gpg-agent-info ]; then
  source $HOME/.gpg-agent-info
fi

alias fixagent='ln -sf $SSH_AUTH_SOCK $HOME/.ssh/agent-socket'
alias grabsshauthsock='export SSH_AUTH_SOCK="$( ls /tmp/ssh-*/agent.* | head -n1 )"'

#export GREP_OPTIONS="--line-number"

export P4CONFIG=$HOME/.p4config

export RAMDIR=/ramdisk/$USER
if [ -d /ramdisk -a ! -d ${RAMDIR} ]; then
  mkdir ${RAMDIR} && chmod 0700 ${RAMDIR}
fi

if [ -f $HOME/local/completion/pass.bash-completion ]; then
  source $HOME/local/completion/pass.bash-completion 
fi

export PASSWORD_STORE_X_SELECTION="primary"

if [ "$TERM" == "screen" ]; then
	export TERM="screen-256color"
fi

function bash_ps1() {
	export PS1='\[\033[01;32m\](\[\033[01;34m\]\D{%m/%d} \t\[\033[01;32m\]) \j \u@\h:\[\033[01;34m\]$(dirs)$(__git_ps1)\n\[\033[01;34m\]$ \[\033[0m\]'
	export GIT_PS1_SHOWDIRTYSTATE=1
}

# set et:sw=3:ts=3
