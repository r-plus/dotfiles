#dotfiles

    cd ~
    git clone git://github.com/r-plus/dotfiles.git
    ln -s dotfiles/.vimrc .vimrc
    ln -s dotfiles/.bashrc .bashrc
    ln -s dotfiles/.bash_profile .bash_profile
    mkdir -p ~/.vim/bundle
    git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

##Vim-Plugins

* Install| :NeoBundleInstall
* Update | :NeoBundleInstall!
* Remove | :NeoBundleClean

###vimproc
`make -f ~/.vim/bundle/vimproc/make_mac.mak`

###lynx setup for Lion
`/opt/local/etc/lynx.cfg` (MacPorts)   
CHARACTER_SET:utf-8
