# ~/.profile: sh/bash login script
# Not read by bash if ~/.bash_profile or ~/.bash_login exists.

# PATH
test -d ~/bin && PATH="$HOME/bin:$PATH"

# When in Bash, include .bashrc
test -n "$BASH" -a -f ~/.bashrc && . ~/.bashrc
