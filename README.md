# dotfiles

My config files.

I try to be a minimalist. No config fireworks here.

Everything is inside `.bashrc` and there's no `.bash_profile` or `.profile`.


## Initial setup in a new machine

```console
# Download
cd $HOME
git clone git@github.com:aureliojargas/dotfiles.git

# Do not overwrite default .bashrc
echo 'test -f ~/dotfiles/.bashrc && source $_' >> ~/.bashrc

ln -s dotfiles/.inputrc
ln -s dotfiles/.vimrc
ln -s dotfiles/.vim
ln -s dotfiles/.gemrc

# Git config
ln -s dotfiles/.gitconfig
ln -s dotfiles/.gitbash
cp dotfiles/.gitconfig.local.template .gitconfig.local
vi .gitconfig.local

# If necessary (Cloud9 already has one)
test -f .git-prompt.sh || curl -L https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > .git-prompt.sh

# Colorful diffs
test -d bin || mkdir bin
curl -L https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy > bin/diff-so-fancy
chmod +x bin/diff-so-fancy
```

Open a new terminal to activate it all.
