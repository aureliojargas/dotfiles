# dotfiles

My config files.

I try to be minimalist. No config fireworks here.

`.profile` calls `.bashrc` and there's no `.bash_profile`.


## Initial setup in a new machine

```console
# Download
cd $HOME
git clone git@github.com:aureliojargas/dotfiles.git

# Do not overwrite default .bashrc
echo 'test -f ~/dotfiles/.bashrc && source $_' >> ~/.bashrc

rm .profile
ln -s dotfiles/.profile

rm .inputrc
ln -s dotfiles/.inputrc

# Git config
ln -s dotfiles/.gitconfig
ln -s dotfiles/.gitbash

# If necessary (Cloud9 already has one)
curl -L https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > .git-prompt.sh

test -d bin || mkdir bin
curl -L https://raw.githubusercontent.com/git/git/master/contrib/diff-highlight/diff-highlight > ~/bin/diff-highlight
chmod +x bin/diff-highlight
```

Open a new terminal to activate it all.
