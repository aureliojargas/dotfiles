alias ls='ls --color=auto'
alias l='ls -la'

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

# Git prompt and aliases
test -r ~/.gitbash && source ~/.gitbash
