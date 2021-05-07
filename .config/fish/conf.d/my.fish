# Add my dear ~/bin to PATH
add-to-path top ~/bin

# aurelio.net: Add path to Jekyll-related tools
add-to-path bottom ~/.gem/ruby/2.5.0/bin

# https://github.com/fish-shell/fish-shell/issues/5394
if status is-interactive

    alias fish-my-config='find ~/.config/fish/ -not -type d'

    # GNU ls: yellow folders, not blue
    set -x LS_COLORS 'di=33'

    # Dear Python venv, please leave my prompt alone
    # https://github.com/pypa/virtualenv/blob/adcf327/src/virtualenv/activation/fish/activate.fish#L80
    set -x VIRTUAL_ENV_DISABLE_PROMPT 1

    # Lazy
    alias ..='cd ..'
    alias ...='cd ../..'
    alias ....='cd ../../..'
    alias .....='cd ../../../..'
    alias l='ls -la'

    # Colors ON
    # Use functions, not aliases: https://github.com/fish-shell/fish-shell/issues/6899
    function ls
        command ls --color=auto $argv
    end
    function grep
        command grep --color $argv
    end

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
    alias code-files='find $PWD -type f | grep -Fv /.git/'
end
