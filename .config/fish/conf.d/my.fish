alias fish-my-config='find ~/.config/fish/ -not -type d'

# Add my dear ~/bin to PATH
add-to-path top ~/bin

# GNU ls: yellow folders, not blue
set -x LS_COLORS 'di=33'

# Lazy
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias l='ls -la'

# Colors ON
alias ls='command ls --color=auto'
alias grep='command grep --color'

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

# aurelio.net: Add path to Jekyll-related tools
add-to-path bottom ~/.gem/ruby/2.3.0/bin
