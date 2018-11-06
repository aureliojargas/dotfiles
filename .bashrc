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

# Activate ** recursive glob pattern (requires bash >=4.0)
#shopt -s globstar

# Yellow folders are better than blue
test -z "$LS_COLORS" && eval $(dircolors)  # pkg/brew install coreutils
LS_COLORS=${LS_COLORS/:di=01;34/:di=33}

# Docker
alias docker-gc='docker run --rm -v /var/run/docker.sock:/var/run/docker.sock spotify/docker-gc'

# JSON
alias json-pp='python -m json.tool'

# Git prompt and aliases
test -r ~/.gitbash && source ~/.gitbash
