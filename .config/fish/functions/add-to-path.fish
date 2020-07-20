function add-to-path --description "Add dir to PATH (top or bottom)"
    set -l where $argv[1]
    set -l dir $argv[2]
    set -l funcname (status current-function)

    if test (count $argv) -ne 2
        echo "$funcname: Expected two arguments, got "(count argv)
        return 1
    end

    if not string match -q '/*' $dir
        echo "$funcname: dir '$dir' is not absolute, aborting"
        return 1
    end

    # Remove trailing /
    set -l dir (string trim --right --char / $dir)

    if contains $dir $PATH
        echo "$funcname: dir '$dir' is already in PATH, nothing to do"
        return 0
    end

    if not test -d $dir
        echo "$funcname: dir '$dir' not found, skipping it"
        return 0
    end

    switch $where
        case top
            set PATH $dir $PATH
        case bottom
            set PATH $PATH $dir
        case '*'
            echo "$funcname: Invalid argument: $where (expected: top or bottom)"
            return 1
    end
end
