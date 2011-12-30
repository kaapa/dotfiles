ZSH=$HOME/.oh-my-zsh
ZSH_THEME="blinks"
plugins=(git osx)
source $ZSH/oh-my-zsh.sh

bindkey '^R' history-incremental-search-backward # Traditional history search

export PATH=/Users/petteri/.rbenv/shims:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

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
