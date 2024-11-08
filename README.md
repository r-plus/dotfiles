# dotfiles

### Setup for macOS

```bash
make init
```

### Homebrew

Restore from Brewfile.

```bash
brew bundle
```

### Vim-Plugins

* Install | :call dein#install()
* Update | :call dein#update()

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
