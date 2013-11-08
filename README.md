# dotfiles

### Setup for OS X

    cd ~
    git clone git://github.com/r-plus/dotfiles.git
    mkdir -p ~/.vim/bundle
    mkdir -p ~/.vim/view
    mkdir -p ~/.vim/swap
    mkdir -p ~/.vim/after
    ln -s ~/dotfiles/vimrc ~/.vimrc
    ln -s ~/dotfiles/.bashrc .bashrc
    ln -s ~/dotfiles/.bash_profile .bash_profile
    ln -s ~/dotfiles/.ssh/config ~/.ssh/config
    ln -s ~/dotfiles/.vim/after/ftplugin ~/.vim/after/ftplugin
    git clone git://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim

### modify remote repository (for author)

    cd ~/dotfiles
    git remote rm origin
    git remote add origin git@github.com:r-plus/dotfiles.git

### Add mail address for github identity
Add `git config --global user.email hogehoge@gmail.com` to `.bashrc`

### Vim-Plugins

* Install | :NeoBundleInstall
* Update | :NeoBundleUpdate
* Remove | :NeoBundleClean

### lynx setup for Lion

    /opt/local/etc/lynx.cfg (MacPorts)
    /usr/local/etc/lynx.cfg (homebrew)

Add this line.  `CHARACTER_SET:utf-8` 

### get vim-ref ref file.

    wget --no-check-certificate https://gist.github.com/r-plus/2762277/raw/c8cf993bec75b819759fad524b7b6b4661d41209/alc.vim .vim/bundle/vim-ref/autoload/ref/alc.vim
    // or
    curl -o .vim/bundle/vim-ref/autoload/ref/alc.vim -k https://gist.github.com/r-plus/2762277/raw/c8cf993bec75b819759fad524b7b6b4661d41209/alc.vim

-----
## for Windows KaoriYa-vim(used mingw and minsys)
### First, install mingw, minsys and git.
http://git-scm.com/    
http://sourceforge.net/projects/mingw/files/

if you using proxy, set below (git bash)

    export HTTP_PROXY=http://PROXY_HOSTorIP:PORT
    export HTTPS_PROXY=http://PROXY_HOSTorIP:PORT
    // or
    git config --global http.proxy <PROXY_HOST or IP-Address>:<PORT>

proxy setting for cmd.exe

    proxycfg -u
    // or below for Windows 7 or later
    netsh winhttp import proxy source=ie

then clone neobundle and dotfiles.

    cd
    mkdir -p .vim/bundle
    mkdir -p .vim/swap
    mkdir -p .vim/after
    mkdir -p vimfiles
    git clone https://github.com/Shougo/neobundle.vim.git .vim/bundle/neobundle.vim
    git clone https://github.com/r-plus/dotfiles.git

copy rc files and ftplugins

    cp ~/dotfiles/vimrc ~/vimfiles/vimrc
    cp ~/dotfiles/gvimrc ~/vimfiles/gvimrc
    cp -a ~/dotfiles/after/* ~/.vim/after/

install plugins! (Please use correct vim that can be used `git(git.exe)`)

    :NeoBundleInstall

### Lynx for Windows
[Lynx for Win32 - http://lynx-win32-pata.sourceforge.jp/index-ja.html](http://lynx-win32-pata.sourceforge.jp/index-ja.html)

#### Lynx via proxy
You must set proxy in `lynx.cfg`

    http_proxy:http://PROXY_SERVER:PORT/

### vimdiff for Windows
* Download diff `Binaries` and `Dependencies` from [DiffUtils for Windows](http://gnuwin32.sourceforge.net/packages/diffutils.htm)
* Put dlls and exes to vim directory.
