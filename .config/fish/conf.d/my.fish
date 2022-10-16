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
end
