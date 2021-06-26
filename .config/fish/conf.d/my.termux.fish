# Termux is a Linux emulator for Android
# https://termux.com

# https://github.com/fish-shell/fish-shell/issues/5394
if status is-interactive

    # Requirement: https://wiki.termux.com/wiki/Termux:API
    alias pbcopy=termux-clipboard-set
    alias pbpaste=termux-clipboard-get

    # Default cursor is a non-blinking block. Change it to |
    # https://www.reddit.com/r/termux/comments/d9rxeo/how_do_i_change_cursor/
    printf '\e[6 q'
end
