#dotfiles

    cd ~
    git clone git://github.com/r-plus/dotfiles.git
    ln -s dotfiles/.vimrc .vimrc
    ln -s dotfiles/.bashrc .bashrc
    ln -s dotfiles/.bash_profile .bash_profile
    mkdir -p ~/.vim/bundle
    git clone git://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim

###Vim-Plugins

* Install | :NeoBundleInstall
* Update | :NeoBundleInstall!
* Remove | :NeoBundleClean

###vimproc
`cd ~/.vim/bundle/vimproc/; make -f ~/.vim/bundle/vimproc/make_mac.mak`

###lynx setup for Lion
`/opt/local/etc/lynx.cfg` (MacPorts)   
CHARACTER_SET:utf-8

-----
##for Windows(Cygwin)
if you using proxy, set below (bash)

    export HTTP_PROXY=http://PROXY_HOSTorIP:PORT
    export HTTPS_PROXY=http://PROXY_HOSTorIP:PORT
    export FTP_PROXY=http://PROXY_HOSTorIP:PORT

then clone neobundle and dotfiles (Required `git` package for cygwin)

    cd $HOMEPATH; mkdir -p .vim/bundle
    git clone https://github.com/Shougo/neobundle.vim.git .vim/bundle/neobundle.vim
    git clone https://github.com/r-plus/dotfiles.git

and https protocol to replace the git protocol in `.vimrc` (many company blocking git protocol)   
`$HOMEPATH/_vimrc` is for KaoriYa-vim/gvim, `~/.vimrc` for cygwin's one.

    sed -e 's%git://%https://%' dotfiles/.vimrc > _vimrc

install plugins! (Please use correct vim (`$HOMEPATH/_vimrc`: KaoriYa-vim, `~/.vimrc`: Cygwin's vim))

    :NeoBundleInstall

make the vimproc.dll (Required `make` and `gcc` package for cygwin)

    cd .vim/bundle/vimproc; make -f make_cygwin.mak

###Lynx for Windows
[Lynx for Win32 - http://lynx-win32-pata.sourceforge.jp/index-ja.html](http://lynx-win32-pata.sourceforge.jp/index-ja.html)
