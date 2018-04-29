# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/jburke/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Adopted from https://unix.stackexchange.com/a/124447
path_update() {
	case ":${PATH:=$1}:" in
		*:$1:*) ;;
		*) PATH="$PATH:$1" ;;
	esac;
}

path_update /sbin
path_update /usr/sbin
path_update $HOME/bin
path_update /usr/local/bin

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

alias l='ls -lhF'
alias ll='ls -lahF'

alias more='less'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias po=popd
alias pd=pushd

alias res='screen -x'
alias ws='w | sort'

alias pst='ps axjf'   # pstree-like output from ps

bindkey '^R' history-incremental-pattern-search-backward
bindkey '^F' history-incremental-pattern-search-forward

# History settings from https://unix.stackexchange.com/a/273863:
# More info here: http://zsh.sourceforge.net/Doc/Release/Options.html#History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
HISTORY_IGNORE="(&|l|[bf]g|exit|w|ws|jobs)"
# Note about `setopt`: names are case insensitive and underscores are ignored.
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt NO_SHARE_HISTORY          # Don't share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt NO_HIST_IGNORE_ALL_DUPS   # Keep duplicate entries when they appear elsewhere in history.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt NO_HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt NO_HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

ZLE_REMOVE_SUFFIX_CHARS=""       # Don't automatically remove trailing (suffix) characters.
                                 # Default value is ' \t\n;&|'.
setopt NO_AUTO_REMOVE_SLASH      # Don't automatically remove trailing slash after a completion.

# Ctrl+W
# Originally from https://github.com/andreafrancia/dot-files/blob/master/.zshrc
unix-word-rubout() {
    local WORDCHARS="*?/_-.[]~=&;!#$%^(){}<>'\""
    zle backward-kill-word
}
zle -N unix-word-rubout
bindkey '^W' unix-word-rubout


if [[ $(uname -s) == "Darwin" ]]; then
  if [[ -x /usr/local/bin/vim ]]; then
    export EDITOR="/usr/local/bin/vim"
    alias vim="/usr/local/bin/vim"
  fi

  if [[ -x "$(command -v brew)" && -x "$(brew --prefix)/bin/ctags" ]]; then
    alias ctags="$(brew --prefix)/bin/ctags"
  fi
fi

# vi:syntax=sh
