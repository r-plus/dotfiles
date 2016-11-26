# dotfiles

### Setup for OS X

```bash
cd ~
git clone git://github.com/r-plus/dotfiles.git
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/view
mkdir -p ~/.vim/swap
mkdir -p ~/.vim/after
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/.bashrc ~/.bashrc
ln -s ~/dotfiles/.bash_profile ~/.bash_profile
ln -s ~/dotfiles/.ssh/config ~/.ssh/config
ln -s ~/dotfiles/.vim/after/ftplugin ~/.vim/after/ftplugin
ln -s ~/dotfiles/.lynxrc ~/.lynxrc
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.gemrc ~/.gemrc
ln -s ~/dotfiles/.theosrc ~/.theosrc
mkdir -p ~/.cache/dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein
ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight
```

### Vim-Plugins

* Install | :call dein#install()
* Update | :call dein#update()

### get vim-ref ref file.

    wget --no-check-certificate https://gist.github.com/r-plus/2762277/raw/c8cf993bec75b819759fad524b7b6b4661d41209/alc.vim .vim/bundle/vim-ref/autoload/ref/alc.vim
    // or
    curl -o .vim/bundle/vim-ref/autoload/ref/alc.vim -k https://gist.github.com/r-plus/2762277/raw/c8cf993bec75b819759fad524b7b6b4661d41209/alc.vim

### iTerm2

`defaults write com.googlecode.iterm2 OptimumTabWidth -int 2000`

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
    mkdir -p vimfiles/bundle
    mkdir -p vimfiles/swap
    mkdir -p vimfiles/after
    git clone https://github.com/Shougo/neobundle.vim.git vimfiles/bundle/neobundle.vim
    git clone https://github.com/r-plus/dotfiles.git

copy rc files and ftplugins

    cp ~/dotfiles/vimrc ~/vimfiles/vimrc
    cp ~/dotfiles/gvimrc ~/vimfiles/gvimrc
    cp -a ~/dotfiles/after/* ~/vimfiles/after/

install plugins! (Please use correct vim that can be used `git(git.exe)`)

    :NeoBundleInstall

### Lynx for Windows
[Lynx for Win32 - http://lynx-win32-pata.sourceforge.jp/index-ja.html](http://lynx-win32-pata.sourceforge.jp/index-ja.html)

#### Lynx via proxy
You must set proxy in `lynx.cfg`

    http_proxy:http://PROXY_SERVER:PORT/

#### the_platinum_searcher
[get pt binary from github](https://github.com/monochromegane/the_platinum_searcher#user)

### vimdiff for Windows
* Download diff `Binaries` and `Dependencies` from [DiffUtils for Windows](http://gnuwin32.sourceforge.net/packages/diffutils.htm)
* Put dlls and exes to vim directory.
