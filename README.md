# dotfiles

My config files.

I try to be a minimalist. No config fireworks here.

Everything is inside `.bashrc` and there's no `.bash_profile` or `.profile`.


## Initial setup in a new machine

```bash
# All the following commands are home-related
cd $HOME

# Download
mkdir -p k/a
git clone git@github.com:aureliojargas/dotfiles.git k/a/dotfiles

# Do not overwrite default .bashrc
echo 'test -f ~/k/a/dotfiles/.bashrc && source $_' >> .bashrc

ln -s k/a/dotfiles/.inputrc
ln -s k/a/dotfiles/.vimrc
ln -s k/a/dotfiles/.vim
ln -s k/a/dotfiles/.screenrc
ln -s k/a/dotfiles/.gemrc
ln -s k/a/dotfiles/.termux

# Git config
ln -s k/a/dotfiles/.gitconfig
ln -s k/a/dotfiles/.gitbash
cp k/a/dotfiles/.gitconfig.local.template .gitconfig.local
vi .gitconfig.local

# If necessary (Cloud9 already has one)
test -f .git-prompt.sh || curl -L https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > .git-prompt.sh

# Colorful diffs
test -d bin || mkdir bin
curl -L https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy > bin/diff-so-fancy
chmod +x bin/diff-so-fancy
```

Open a new terminal to activate it all.

## Additional setup for macOS

```bash
echo 'test -f ~/k/a/dotfiles/.bashrc.osx && source $_' >> .bashrc

# Install extra software
brew install coreutils ed gnu-sed python shellcheck tig wget

# GNU ed should be used as the git core.editor's ed
ln -s /usr/local/bin/ged ~/bin/ed
```
