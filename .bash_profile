#This file is sourced by bash when you log in interactively.
[ -f ~/.bashrc ] && . ~/.bashrc

# disable checking for new mail
unset MAILCHECK

# Setup GPG:
export GPG_TTY=$(tty)
#if [ -f "${HOME}/.gpg-agent-info" ]; then
#  . "${HOME}/.gpg-agent-info"
#  export GPG_AGENT_INFO
#fi

## Start up the ssh-agent
##
#SSHAGENT=/usr/bin/ssh-agent
#SSHAGENTARGS="-s"
#SSHSOCKLOC="$HOME/.ssh/agent-socket"
#
#if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
#    eval `$SSHAGENT $SSHAGENTARGS`
#    trap "kill $SSH_AGENT_PID" 0
#    export SSH_AUTH_SOCK SSH_AGENT_PID
#
#    # Make a semi-permanent symbolic link to the ssh-agent auth sock for
#    # reattached screens to see
#    #
#    ln -sf "$SSH_AUTH_SOCK" "$SSHSOCKLOC"
#fi
