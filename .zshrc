# load bashrc.
source ~/.bashrc

# use macOS built-in zsh because brew installed zsh will not universal binary.
alias a64='exec arch -arch arm64e /bin/zsh'
alias x64='exec arch -arch x86_64 /bin/zsh'

# hisotry.
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

# Emacs keybind.
bindkey -e

# options.
setopt prompt_subst
setopt magic_equal_subst
setopt mark_dirs
setopt auto_param_slash
setopt auto_menu
setopt auto_list
setopt auto_param_keys
setopt list_types
setopt no_beep
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt hist_no_store
setopt extended_history
setopt share_history
setopt append_history

# completion.
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
fpath=($(brew --prefix)/share/zsh-completions $fpath)
autoload -Uz compinit
compinit

# colors.
autoload -Uz colors
colors

# cdr
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*:*:cdr:*:*' menu selection
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-max 500
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-file "${XDG_CACHE_HOME:-$HOME/.cache}/shell/chpwd-recent-dirs"
    zstyle ':chpwd:*' recent-dirs-pushd true
fi

# M-f and M-b style.
autoload -Uz select-word-style
select-word-style bash

# colorized directory completion.
export LS_COLORS='di=01;36'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# horizon movable completion.
zstyle ':completion:*:default' menu select=2

# custom prompt.
#
if [ -f $(brew --prefix)/etc/bash_completion.d/git-prompt.sh ]; then
    PROMPT='%{$fg[cyan]%}%~%{$reset_color%} %{$fg[green]%}$(uname -m)%{$fg[red]%}$(__git_ps1 " (%s)")%{$reset_color%}$ '
fi

# iTerm tab title.
precmd() {
  # sets the tab title to current dir
  echo -ne "\e]1;${PWD##*/}\a"
}

# fzf
export FZF_DEFAULT_OPTS="--reverse --border --inline-info --height=40"

# custom functions.
## Ctrl-r replacement. {{{
function fuzzy-select-history() {
    local tac
    if which gtac > /dev/null; then
        tac="gtac"
    elif which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N fuzzy-select-history
bindkey '^r' fuzzy-select-history
## }}}
## history cd. {{{
function fuzzy-cdr () {
    local selected_dir=$(cdr -l | awk '{ for (i=2; i<NF; i++) { printf("%s%s", $i, OFS) } print $NF }' | peco)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N fuzzy-cdr
bindkey '^@' fuzzy-cdr
## }}}

[ -f $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
