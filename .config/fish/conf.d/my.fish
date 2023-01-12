# Add my dear ~/bin to PATH
add-to-path top ~/bin

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

    # I always forget those commands
    function ssh-no-password
        eval (ssh-agent -c)
        ssh-add ~/.ssh/id_rsa
    end

    # -----------------------------------------------------------------
    # Git-related stuff

    function gcm
        git-pre-commit
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
end
