# Setup all the dotfiles into a new machine.
# May be run multiple times in the same machine.
# Usage: fish setup.fish

set dotfiles_dir $HOME/k/a/dotfiles
set user_bin $HOME/bin

function is_termux
    string match -q '*termux*' $HOME
end

function is_macos
    test (uname) = Darwin
end

function is_linux
    test -f /etc/debian_version
end

function log
    set_color cyan
    echo "[$argv]"
    set_color normal
end

function done
    if set -q argv[1]
        set message $argv
    else
        set message Done
    end
    set_color green
    echo ✓ $message
    set_color normal
end

function already_done
    if set -q argv[1]
        set message $argv
    else
        set message Already done
    end
    set_color yellow
    echo ✓ $message
    set_color normal
end

function failed
    if set -q argv[1]
        set message $argv
    else
        set message Failed
    end
    set_color red
    echo × $message
    set_color normal
end

function insert_line -a line file
    if grep -F -x -q $line $file
        already_done
    else
        echo $line >>$file
        done
    end
end

function create_symlink -a target symlink
    if not test (count $argv) -eq 2
        echo ERROR: usage: create_symlink target symlink
        exit 1
    end

    # Make sure the symlink parent dir exists
    mkdir -p (dirname $symlink)

    if test -L $symlink
        if test (readlink $symlink) = $target
            already_done $symlink is already done
        else
            failed $symlink is a symlink to an unknown file
        end
    else if test -f $symlink
        failed $symlink is a normal file, skipping symlink creation
    else if test -d $symlink
        failed $symlink is a directory, skipping symlink creation
    else
        ln -s -v $target $symlink
    end
end

#-----------------------------------------------------------------------

set paths \
    .config/fish/conf.d/my.fish \
    .config/fish/conf.d/my.git.fish \
    .config/fish/functions/add-to-path.fish \
    .config/fish/functions/fish_prompt.fish \
    .gemrc \
    .gitbash \
    .gitconfig \
    .inputrc \
    .screenrc \
    .tmux.conf \
    .vim \
    .vimrc

if is_termux
    set paths $paths \
        .bashrc.termux \
        .config/fish/conf.d/my.termux.fish \
        .termux
end

if is_macos
    set paths $paths \
        .bashrc.osx \
        .config/fish/conf.d/my.osx.fish
end

log 'Clone/update repository'
if not test -d $dotfiles_dir
    mkdir -p (dirname $dotfiles_dir)
    git clone git@github.com:aureliojargas/dotfiles.git $dotfiles_dir
else
    git -C $dotfiles_dir pull
end

log 'Create symlinks'
for path_ in $paths
    create_symlink $dotfiles_dir/$path_ $HOME/$path_
end

log 'Source dotfiles custom .bashrc from ~/.bashrc'
insert_line "test -f $dotfiles_dir/.bashrc && source \$_" $HOME/.bashrc

log 'Download .git-prompt.sh for Bash'
set git_prompt $HOME/.git-prompt.sh
if test -f $git_prompt
    already_done
else
    curl --location https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh >$git_prompt
    done
end

log 'Create user bin directory'
if test -d $user_bin
    already_done
else
    mkdir -p -v $user_bin
end

log 'Install diff-so-fancy in user bin'
set fancy_diff $user_bin/diff-so-fancy
if test -f $fancy_diff; and test -x $fancy_diff
    already_done
else
    curl -L https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy >$fancy_diff
    chmod +x $fancy_diff
    done Installed $fancy_diff
end

if is_macos
    log "macOS: Add 'ed' symlink so GNU ed can be used as git core.editor"
    create_symlink /usr/local/bin/ged $HOME/bin/ed

    log 'macOS: Install extra software'
    echo Please run:
    echo brew install coreutils ed fish gnu-sed python shellcheck tig wget
    echo pip3 install --user black git-revise pylint
end

if is_termux
    log 'Termux: Install extra software'
    echo Please run:
    echo pkg update
    echo pkg install file fish git make openssh python python2 tig vim
    echo 'pkg install lynx  # funcoeszz'
    echo 'pkg install perl  # diff-so-fancy'
    echo 'pkg install ruby  # Jekyll'
    echo 'pkg install termux-api  # pbcopy/pbpaste alias'
    echo pip3 install black git-revise pylint
end

if is_linux
    log 'Linux: Install extra software'
    echo Please run:
    echo sudo apt update
    echo sudo apt install ed make python3-pip tig
    echo 'sudo apt install lynx  # funcoeszz'
    echo 'sudo apt install ruby  # Jekyll'
    echo pip3 install black git-revise pylint
end

log 'Setup Git local configuration (manual intervention needed)'
set git_config_local $HOME/.gitconfig.local
if test -f $git_config_local
    already_done
else
    cp -v $dotfiles_dir/.gitconfig.local.template $git_config_local
    echo Please edit $git_config_local
end
