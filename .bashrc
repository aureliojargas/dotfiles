alias l='ls -la'

# History with timestamp
export HISTTIMEFORMAT='%F %T '

# Yellow folders are better than blue
LS_COLORS=$(echo "$LS_COLORS" | sed 's/:di=01;34/:di=01;33/')

# Git prompt
#GIT_PS1_SHOWDIRTYSTATE=1      # unstaged (*) and staged (+) changes
#GIT_PS1_SHOWSTASHSTATE=1      # stashed ($)
#GIT_PS1_SHOWUNTRACKEDFILES=1  # untracked (%)
GIT_PS1_SHOWUPSTREAM='auto'   # behind (<), ahead (>), equal (=), diverged (<>)
GIT_PS1_SHOWCOLORHINTS=1
source ~/.git-prompt.sh
PROMPT_COMMAND='__git_ps1 "\033[42;30m\u@\h:\w\033[m" "\n\\\$ "'

# Git aliases
alias gs='git status'
alias gw='git show'
alias gsl='git stash list'
alias gsd='git stash show -p stash@{0}'
alias gd='git diff'
alias gdw='GIT_PAGER= git diff'  # wrap long lines
alias gdc='git diff --cached'
alias ga='git add'
alias gca='git commit --amend'
alias gb='git branch -va'
alias gr='git remote -v'
alias gl='git log -n 20 --oneline --reverse --date=short --pretty=format:"%Cgreen%h%Creset %Cred%ad%Creset %s"'
alias gla='git log -n 20 --oneline --reverse --date=short --pretty=format:"%Cgreen%h%Creset %Cred%ad%Creset %Cblue%<(20,trunc)%ae%Creset %s"'
# http://opensource.apple.com/source/Git/Git-19/src/git-htmldocs/pretty-formats.txt
gcm() {
    git commit -m "$*"
}
