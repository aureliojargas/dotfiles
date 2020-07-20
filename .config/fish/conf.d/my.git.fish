# Git-related stuff

# ed: Show a ruler as reference to git commit 50/72 max width
alias ed-ruler='echo "-----------------------------------------------50|-------------------72|"'

# Lazy
alias ga='git add'
alias gap='git add -p'
alias gau='git add -u'
alias gb='git branch -va'
alias gc='ed-ruler; git commit'
alias gca='git_pre_commit; ed-ruler; git commit --amend'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdw='GIT_PAGER= git diff' # wrap long lines
alias gg='git grep'
alias gl='git log -n 20 --oneline --reverse --date=short --pretty=format:"%Cblue%h%Creset %C(yellow)%ad%Creset %Cred%<(25,trunc)%ae%Creset %s"'
alias glg='git log --oneline --decorate --all --graph'
alias gpf='git push -f'
alias gpu='git push -u'
alias gr='git remote -v'
alias grp='git reset -p'
alias gs='git status'
alias gsd='git stash show -p stash@{0}'
alias gsl='git stash list'
alias gw='git show'
alias gws='git show --stat'

function gcm
    git_pre_commit
    git commit -m "$argv"
end

function gl2 # Show hash, summary
    gl --color=always $argv | tr -s ' ' | cut -d ' ' -f 1,4-
end

function gl3 # Show hash, date, summary
    gl --color=always $argv | tr -s ' ' | cut -d ' ' -f 1,2,4-
end

function git_cleanup
    git fetch -p
    git branch --merged |
    cut -c3- |
    grep -vEx "master|gh-pages" |
    xargs -r git branch -d "$branch"
end

function git_replace # args: pattern replacement [use_regex]
    # Get replace at https://github.com/aureliojargas/replace
    if test (count $argv) -eq 3
        git grep -P -I -l "$1" | xargs replace -i -f "$1" -t "$2" --regex
    else
        git grep -F -I -l "$1" | xargs replace -i -f "$1" -t "$2"
    end
end

function git_pull_forced
    # I'm assuming 10 commits ago the local is sync'ed with the remote
    git fetch
    git reset --hard HEAD~10
    git merge FETCH_HEAD
end

function git_check_author # args: email
    # List commits from all branches whose author email is not $email
    set -l email $argv[1]
    set -l branches (git branch -a | grep -v ' -> ' | cut -c3-) # local+remote

    for branch in $branches
        echo "$branch:"
        git log --oneline --date=short --pretty=format:"%h %ad [%ae] %s" "$branch" |
        grep -v -F "[$email]"
    end
end

function git_pre_commit
    set -l author (git config user.email)
    set -l origin (git remote get-url origin)

    set -l perso_author "verde@"
    set -l perso_origin "github.com:aureliojargas/"

    set -l is_perso_author (string match -- "*$perso_author*" $author)
    set -l is_perso_origin (string match -- "*$perso_origin*" $origin)

    # If author or repo are personal, both must be personal
    if test -n "$is_perso_author"
        and test -n "$is_perso_origin"
        :
    else if test -n "$is_perso_author"
        or test -n "$is_perso_origin"
        echo "WARNING: using $author in $origin. Is that ok?"
        read
    end
end
