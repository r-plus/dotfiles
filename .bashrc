HISTSIZE=500000

# homebrew PATH
export PATH=/opt/homebrew/bin:$PATH
BrewPath=$(brew --prefix)

# alias
alias ga="git commit --amend"
alias gs="git status"
alias gd='git diff'
alias gl='git log --graph --decorate --oneline'
alias tb='tig blame'
alias grep="grep --color=auto"
alias ll="ls -l"
alias ls="ls -aFG"
if which gmake > /dev/null; then
    alias m="gmake"
else
    alias m="make"
fi
alias md="m do"
alias mp="m package"
alias mi="m install"
alias mc="m clean && m clean FINALPACKAGE=1"
alias mcp="m clean-packages"
alias rd="rm *.deb"
alias vu="vagrant up"
alias vh="vagrant halt"
alias vs="vagrant ssh"
alias be="bundle exec"
alias b="brew"
alias less="less -R"
alias vimsjis='vim -c ":e ++enc=cp932"'
alias miall="
export THEOS_DEVICE_IP=i6; mi;
export THEOS_DEVICE_IP=i5s; mi;
export THEOS_DEVICE_IP=i5; mi;
export THEOS_DEVICE_IP=i4s; mi;
export THEOS_DEVICE_IP=i4; mi;
export THEOS_DEVICE_IP=mini2; mi;
export THEOS_DEVICE_IP=ipad3; mi;
export THEOS_DEVICE_IP=ipad1; mi;
"
# to avoid error when python is installed from homebrew, use macOS preinstalled python.
alias swift='PATH="/usr/bin:$PATH" swift'

# theos
export THEOS=/opt/theos
export THEOS_DEVICE_IP=i6s

# rbenv PATH
if [ -d ~/.rbenv ]; then
    export PATH=~/.rbenv/shims:$PATH
fi

# gpg
#if [ -n $(type -P gpg-agent) ]; then
#    pgrep -q gpg-agent || eval $(gpg-agent --daemon --allow-preset-passphrase --write-env-file ${HOME}/.gpg-agent-info)
#    [ -f ${HOME}/.gpg-agent-info ] && source ${HOME}/.gpg-agent-info
#    export GPG_AGENT_INFO
#    export GPG_TTY=`tty`
#fi

function isZsh() {
    [ $(basename $SHELL) = 'zsh' ] && echo 'true'
}

# homebrew git
if [ -f ${BrewPath}/etc/bash_completion.d/git-completion.bash ]; then
    . ${BrewPath}/etc/bash_completion.d/git-prompt.sh
    if [ -z "$(isZsh)" ]; then
        . ${BrewPath}/etc/bash_completion.d/git-completion.bash
        export PS1='\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '
    fi
    export PATH=$PATH:${BrewPath}/share/git-core/contrib/diff-highlight
fi

function completion_source() {
    if [ -f "$1" ]; then
        . "$1"
    fi
}

# homebrew bash completion
if [ -n "$(isZsh)" ]; then
    completion_source ${BrewPath}/bin/aws_zsh_completer.sh
else
    completion_source ${BrewPath}/etc/bash_completion.d/aws_bash_completer
    completion_source ${BrewPath}/etc/bash_completion.d/brew
    completion_source ${BrewPath}/etc/bash_completion.d/carthage
    completion_source ${BrewPath}/etc/bash_completion.d/bundler
fi
completion_source ${BrewPath}/etc/bash_completion.d/nvm

function git_rebase_remote() {
# ex. $1: master $2: local
    if [ $# -lt 2 ]; then
        echo "must have 2 args"
        return
    fi
    git co $1
    git pull
    git co $2
    git rebase $1
}

function git_push_remote() {
# ex. $1: master $2: local
    if [ $# -lt 2 ]; then
        echo "must have 2 args"
        return
    fi
    git co $1
    git rebase $2
    git push
    git co $2
}

alias grr="git_rebase_remote"
alias gpr="git_push_remote"

# nvm
export NVM_DIR="${HOME}/.nvm"
[ -n $(which brew) ] && [ -s "$(brew --prefix nvm)/nvm.sh" ] && . "$(brew --prefix nvm)/nvm.sh"

# iTerm2 tab title
if [ $ITERM_SESSION_ID ]; then
    export PROMPT_COMMAND='echo -ne "\033];${PWD##*/}\007"; '"$PROMPT_COMMAND";
fi

# source un tracked file.
if [ -f ~/.bashrc_local ]; then
    . ~/.bashrc_local
fi

# fastlane
export PATH="$HOME/.fastlane/bin:$PATH"

# project npm binary
export PATH=./node_modules/.bin:$PATH
# requireable from global installed npm
export NODE_PATH=$(npm root -g)
# new mint PATH
export PATH=~/.mint/bin:$PATH

# lesspipe
[ -x ${BrewPath}/bin/lesspipe.sh ] && export LESSOPEN="|${BrewPath}/bin/lesspipe.sh %s" LESS_ADVANCED_PREPROCESSOR=1
# copilot
if which github-copilot-cli > /dev/null; then
    eval "$(github-copilot-cli alias -- "$0")"
fi

function local_repo()
{
    (
        [ -d packages ] && cd packages
        [ ! -L Release ] && ln -s ~/dotfiles/Release Release
        dpkg-scanpackages . /dev/null > Packages 2>/dev/null
        gzip -f Packages
        python3 -m http.server 80
    )
}

