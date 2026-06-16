source $HOME/.aliases
export PATH="$HOME/.local/bin:$PATH"  # my scripts, uv tool
export LS_COLORS='di=33'  # GNU ls: yellow dirs, not blue
export EDITOR=vim
PS1='\[\033[7m\]\u@\h \w\[\033[0m\]\$ '  # 7=reverse

#shopt -s checkwinsize  # update $LINES and $COLUMNS
shopt -s globstar  # support ** in Bash>=4.0

# History
HISTSIZE=9999
HISTFILESIZE=9999
HISTCONTROL=ignoreboth   # ignoredups and ignorespace
HISTTIMEFORMAT='%F %T '  # history with timestamp
shopt -s histappend      # append to (not overwrite) the history file
