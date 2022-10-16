add_to_path() {
    local dir="${2%/}"  # remove trailing /

    # Skip if not a dir
    test -d "$dir" || return 0

    # Skip if already added
    echo ":$PATH:" | grep -q ":$dir:" && return 0

    case "$1" in
        top   ) PATH="$dir:$PATH" ;;
        bottom) PATH="$PATH:$dir" ;;
    esac
}

is_termux() {
    case "$HOME" in *termux*) true;; *) false;; esac
}

is_macos() {
    test "$(uname)" = Darwin
}

# My dear ~/bin
add_to_path top $HOME/bin

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

# GNU ls: yellow folders, not blue
export LS_COLORS='di=33'

# Git prompt and aliases
test -r ~/.aliases && source $_
test -r ~/.gitbash && source $_

# aurelio.net: Add path to Jekyll-related tools
add_to_path bottom ~/.gem/ruby/2.5.0/bin

# Funções ZZ - https://funcoeszz.net
zzon() {
    export ZZPATH="$HOME/k/a/funcoeszz/funcoeszz"
    export ZZDIR="$HOME/k/a/funcoeszz/zz"
    source "$ZZPATH"
}

# OS-specific settings
is_macos  && test -r ~/.bashrc.osx    && source $_
is_termux && test -r ~/.bashrc.termux && source $_
