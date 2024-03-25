function brew_activate --description 'Activate brew environment (if brew is available)'

    # brew is already setup, nothing to do
    set -q HOMEBREW_REPOSITORY; and return 0

    # Possible paths for the brew command (Mac, Linux)
    set -l brew_paths \
        /opt/homebrew/bin/brew \
        /home/linuxbrew/.linuxbrew/bin/brew

    # Activate the first path found (if any)
    for brew in $brew_paths
        if command --query $brew
            eval ($brew shellenv)
            break
        end
    end
end
