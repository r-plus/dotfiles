# alias
alias gs="git status"
alias gd='git diff'
alias grep="grep --color=auto"
alias ll="ls -l"
alias ls="ls -aFG"
alias m="make"
alias mp="make package"
alias mi="make install"
alias mc="make clean"
alias rd="rm *.deb"
alias v="vagrant"

# theos
export THEOS_DEVICE_IP=i4

# rbenv PATH
if [ -d ~/.rbenv ]; then
    export PATH=~/.rbenv/shims:$PATH
fi
