# Add my dear ~/bin to PATH
add-to-path top ~/bin

# aurelio.net: Add path to Jekyll-related tools
add-to-path bottom ~/.gem/ruby/2.5.0/bin

# https://github.com/fish-shell/fish-shell/issues/5394
if status is-interactive

    # GNU ls: yellow folders, not blue
    set -x LS_COLORS 'di=33'

    # Dear Python venv, please leave my prompt alone
    # https://github.com/pypa/virtualenv/blob/adcf327/src/virtualenv/activation/fish/activate.fish#L80
    set -x VIRTUAL_ENV_DISABLE_PROMPT 1

    # Load aliases
    test -r ~/.aliases
    and source ~/.aliases

    # Colors ON
    # Use functions, not aliases: https://github.com/fish-shell/fish-shell/issues/6899
    functions --erase ls grep # remove aliases
    function ls
        command ls --color=auto $argv
    end
    function grep
        command grep --color $argv
    end

    # -----------------------------------------------------------------
    # Git-related stuff

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
        grep -vEx "main|master|gh-pages" |
        xargs -r git branch -d "$branch"
    end

    function git_replace # args: pattern replacement [use_regex]
        # Get replace at https://github.com/aureliojargas/replace
        if test (count $argv) -eq 3
            git grep -P -I -l $argv[1] | xargs replace -i -f $argv[1] -t $argv[2] --regex
        else
            git grep -F -I -l $argv[1] | xargs replace -i -f $argv[1] -t $argv[2]
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
end
