#!/bin/bash

cd ~
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/view
mkdir -p ~/.vim/swap
mkdir -p ~/.vim/after
mkdir -p ~/.cache/shell
mkdir -p ~/.config
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
ln -s ~/dotfiles/.xvimrc ~/.xvimrc
# https://karabiner-elements.pqrs.org/docs/manual/misc/configuration-file-path/#about-symbolic-link
rm -fr ~/.config/karabiner
ln -s ~/dotfiles/karabiner ~/.config/karabiner

defaults write com.apple.dt.Xcode ShowBuildOperationDuration YES
defaults write com.googlecode.iterm2 OptimumTabWidth -int 2000
defaults write com.apple.Finder AppleShowAllFiles 1
defaults write com.apple.Finder ShowHardDrivesOnDesktop 1
defaults write com.apple.Finder ShowStatusBar 1
defaults write com.apple.Finder ShowPathbar 1
defaults write com.apple.screencapture location ~/Downloads
defaults write NSGlobalDomain AppleShowAllExtensions 1
defaults write -g ApplePressAndHoldEnabled -bool false

# deoplete
if which pip3; then
    pip3 install --user pynvim
fi

# TouchID for sudo
sed -e 's/^#auth/auth/' /etc/pam.d/sudo_local.template | sudo tee /etc/pam.d/sudo_local

# Download not cask managables
cd ~/Downloads
curl -O "https://github.com/kishikawakatsumi/BandwidthLimiter/releases/download/v0.1.3/Bandwidth-Limiter-0.1.3.dmg"
curl -O "https://sideloadly.io/SideloadlySetup.dmg"
curl -O "https://github.com/tue-savvy/SimulatorManager/releases/download/1.3/SimulatorManager.zip"
cd
