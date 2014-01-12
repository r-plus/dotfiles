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
alias vu="vagrant up"
alias vh="vagrant halt"
alias vs="vagrant ssh"
alias miall="
export THEOS_DEVICE_IP=i5s; mi;
export THEOS_DEVICE_IP=i5; mi;
export THEOS_DEVICE_IP=i4s; mi;
export THEOS_DEVICE_IP=i4; mi;
export THEOS_DEVICE_IP=mini2; mi;
export THEOS_DEVICE_IP=ipad3; mi;
export THEOS_DEVICE_IP=ipad2; mi;
export THEOS_DEVICE_IP=ipad1; mi;
"

# theos
export THEOS_DEVICE_IP=i4

# rbenv PATH
if [ -d ~/.rbenv ]; then
    export PATH=~/.rbenv/shims:$PATH
fi
