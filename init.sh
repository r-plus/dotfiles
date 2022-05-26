#!/bin/bash

cd ~
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/view
mkdir -p ~/.vim/swap
mkdir -p ~/.vim/after
mkdir -p ~/.cache/shell
mkdir -p ~/.config/karabiner
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/.bashrc ~/.bashrc
ln -s ~/dotfiles/.bash_profile ~/.bash_profile
ln -s ~/dotfiles/.ssh/config ~/.ssh/config
ln -s ~/dotfiles/.vim/after/ftplugin ~/.vim/after/ftplugin
ln -s ~/dotfiles/.lynxrc ~/.lynxrc
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.gemrc ~/.gemrc
ln -s ~/dotfiles/.theosrc ~/.theosrc
ln -s ~/dotfiles/.eslintrc.js ~/.eslintrc.js
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.tigrc ~/.tigrc
# https://karabiner-elements.pqrs.org/docs/manual/misc/configuration-file-path/#about-symbolic-link
rm -fr ~/dotfiles/karabiner
ln -s ~/dotfiles/karabiner ~/.config/karabiner
# dein
mkdir -p ~/.cache/dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein
rm ./installer.sh

defaults write com.apple.dt.Xcode ShowBuildOperationDuration YES
defaults write com.googlecode.iterm2 OptimumTabWidth -int 2000
defaults write com.apple.Finder AppleShowAllFiles true

# deoplete
if which pip3; then
    pip3 install --user pynvim
fi
