# Use brew tools (if installed)
fish_add_path /home/linuxbrew/.linuxbrew/bin

# Add my dear ~/bin to PATH
fish_add_path ~/bin

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
end
