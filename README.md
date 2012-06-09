#dotfiles

    cd ~
    git clone git://github.com/r-plus/dotfiles.git
    ln -s dotfiles/.vimrc .vimrc
    ln -s dotfiles/.bashrc .bashrc
    ln -s dotfiles/.bash_profile .bash_profile
    mkdir -p ~/.vim/bundle
    git clone git://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim

###Vim-Plugins

* Install| :NeoBundleInstall
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

    cd ~; mkdir -p .vim/bundle
    git clone https://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
    git clone https://github.com/r-plus/dotfiles.git
    

and replace git protocol to https protocol in `.vimrc` (many company blocking git protocol)

    sed -e 's%git://%https://%' dotfiles/.vimrc > _vimrc

make the vimproc.dll (Required `make` and `gcc` package for cygwin)


    cd ~/.vim/bundle/vimproc; make -f make_cygwin.mak

Finally, install plogins!

    vim
    :NeoBundleInstall
    
###Install lynx for Windows
[Lynx for Win32 - http://lynx-win32-pata.sourceforge.jp/index-ja.html](http://lynx-win32-pata.sourceforge.jp/index-ja.html)
