ZSH=$HOME/.oh-my-zsh
ZSH_THEME="blinks"
plugins=(git osx vi-mode)
source $ZSH/oh-my-zsh.sh

bindkey -v
bindkey '\e[3~' delete-char # bind fn-backspace to delete
bindkey "^?" backward-delete-char # Fix backspace from breaking when returning to insert mode
bindkey '^R' history-incremental-search-backward # Traditional history search

export PATH=/Users/petteri/.rbenv/shims:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
RPS1='$(vi_mode_prompt_info) ${return_code}'

# Speed up git completion
# http://talkings.org/post/5236392664/zsh-and-slow-git-completion
__git_files () {
  _wanted files expl 'local files' _files
}

# Always pushd when changing directory
setopt auto_pushd

# Fuzzy matching of completions for when you mistype them:
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
