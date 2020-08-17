# Termux is a Linux emulator for Android
# https://termux.com

# https://github.com/fish-shell/fish-shell/issues/5394
if status is-interactive

    # Requirement: https://wiki.termux.com/wiki/Termux:API
    alias pbcopy=termux-clipboard-set
    alias pbpaste=termux-clipboard-get
end
