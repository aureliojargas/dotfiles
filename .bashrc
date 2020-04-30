# My dear ~/bin
test -d $HOME/bin && PATH="$_:$PATH"

# Lazy
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias l='ls -la'

# Colors ON
alias ls='ls --color=auto'
alias grep='grep --color'  # in Termux: pkg install grep

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
alias docker-gc='docker system prune'

# JSON
alias json-pp='python -m json.tool'

# Web
# curl -L https://raw.github.com/aureliojargas/css-grep/master/css-grep.txt > ~/.css.txt
alias css='cat ~/.css.txt | grep -i'

# VS Code
# List of absolute paths for files in the current dir.
# Use it inside VS Code builtin Terminal and Alt-click a path to open it in the editor
alias code-files='find "$PWD" -type f | grep -Fv /.git/'

# Git prompt and aliases
test -r ~/.gitbash && source ~/.gitbash
