# My dear ~/bin
test -d $HOME/bin && PATH="$_:$PATH"

alias ls='ls --color=auto'
alias l='ls -la'
alias grep='grep --color'

# Lazy
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# History
HISTSIZE=9999
HISTFILESIZE=9999
HISTCONTROL=ignoreboth   # ignoredups and ignorespace
HISTTIMEFORMAT='%F %T '  # history with timestamp
shopt -s histappend      # append to (!overwrite) the history file

# Check window size after each command, update $LINES and $COLUMNS
shopt -s checkwinsize

# Yellow folders are better than blue
LS_COLORS=$(echo "$LS_COLORS" | sed 's/:di=01;34/:di=01;33/')

# Docker
alias docker-gc='docker run --rm -v /var/run/docker.sock:/var/run/docker.sock spotify/docker-gc'

# Git prompt and aliases
test -r ~/.gitbash && source ~/.gitbash
