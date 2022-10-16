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

# Load all the aliases
test -r ~/.aliases && source $_

# aurelio.net: Add path to Jekyll-related tools
add_to_path bottom ~/.gem/ruby/2.5.0/bin

# ---------------------------------------------------------------------
# Bash setup to improve Git usage

# The Git Prompt magic alien device
# https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
type __git_ps1 > /dev/null 2>&1 || source ~/.git-prompt.sh

# Git prompt
GIT_PS1_SHOWDIRTYSTATE=1       # unstaged (*), staged (+)
#GIT_PS1_SHOWSTASHSTATE=1      # stashed ($)
#GIT_PS1_SHOWUNTRACKEDFILES=1  # untracked (%)
GIT_PS1_SHOWUPSTREAM='auto'    # behind (<), ahead (>), equal (=), diverged (<>)
#GIT_PS1_DESCRIBE_STYLE=branch # master~4 when detached HEAD
GIT_PS1_SHOWCOLORHINTS=1
PROMPT_COMMAND='__git_ps1 "\[\e[m\e[32;1m\]\w\[\e[m\]" "$(z=$?;test $z -gt 0 && echo "|\[\e[31;1m\]$z\[\e[m\]")| " "|%s"'
# Prompt: dir|git-branch|$?| _


# Git functions
gcm() {
    git_pre_commit
    git commit -m "$*"
}
gl2() {  # Show hash, summary
    gl --color=always "$@" | tr -s ' ' | cut -d ' ' -f 1,4-
}
gl3() {  # Show hash, date, summary
    gl --color=always "$@" | tr -s ' ' | cut -d ' ' -f 1,2,4-
}
git_cleanup() {
    local branch
    git fetch -p
    git branch --merged |
        cut -c3- |
        grep -vEx "main|master|gh-pages" |
        while read -r branch  # xargs -r not supported in BSD :(
        do
            git branch -d "$branch"
        done
}
git_replace() {  # args: pattern replacement [use_regex]
    # Get replace at https://github.com/aureliojargas/replace
    if test -n "$3"
    then
        git grep -P -I -l "$1" | xargs replace -i -f "$1" -t "$2" --regex
    else
        git grep -F -I -l "$1" | xargs replace -i -f "$1" -t "$2"
    fi
}
git_pull_forced() {
    # I'm assuming 10 commits ago the local is sync'ed with the remote
    git fetch
    git reset --hard HEAD~10
    git merge FETCH_HEAD
}
git_check_author() {
    # List commits from all branches whose author email is not $1
    set -u
    local email="$1"
    local branch
    local branches

    branches=$(git branch -a | grep -v ' -> ' | cut -c3-)  # local+remote

    for branch in $branches
    do
        echo "$branch:"
        git log --oneline --date=short --pretty=format:"%h %ad [%ae] %s" "$branch" |
            grep -v -F "[$email]"
    done
}
git_pre_commit() {
    local author=$(git config user.email)
    local origin=$(git remote get-url origin)

    local perso_author="verde@"
    local perso_origin="github.com:aureliojargas/"

    # if empty, it's true (odd, I know, but easier to handle)
    local is_perso_author=${author##*$perso_author*}
    local is_perso_origin=${origin##*$perso_origin*}

    # If author or repo are personal, both must be personal
    if { test -z "$is_perso_author" && ! test -z "$is_perso_origin"; } ||
       { test -z "$is_perso_origin" && ! test -z "$is_perso_author"; }
    then
        echo "WARNING: using $author in $origin. Is that ok?"
        read -r
    fi
}

# Funções ZZ - https://funcoeszz.net
zzon() {
    export ZZPATH="$HOME/k/a/funcoeszz/funcoeszz"
    export ZZDIR="$HOME/k/a/funcoeszz/zz"
    source "$ZZPATH"
}

# OS-specific settings
is_macos  && test -r ~/.bashrc.osx    && source $_
is_termux && test -r ~/.bashrc.termux && source $_
