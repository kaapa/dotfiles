ZSH=$HOME/.oh-my-zsh
ZSH_THEME="blinks"
plugins=(git rvm)
source $ZSH/oh-my-zsh.sh

bindkey '^R' history-incremental-search-backward # Traditional history search

# Minimal prompt for a tmux session
if { [ -n "$TMUX" ]; } then
  PROMPT='%{%f%k%b%}
%{%K{black}%}$(_prompt_char)%{%K{black}%} %#%{%f%k%b%} '
  ZSH_THEME_GIT_PROMPT_SUFFIX=']'
  RPROMPT='$(git_prompt_info)'
fi

export PATH=~/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin

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

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

open_ssh_tunnel () {
  local LOCAL_PORT=${1:?Local port missing}
  local REMOTE_PORT=${2:?Remote port missing}
  local REMOTE_HOST=${3:?Remote host missing}
  ssh -v -L ${LOCAL_PORT}:localhost:${REMOTE_PORT} ${REMOTE_HOST} -N
}

random_string() {
  cat /dev/urandom|tr -dc "a-zA-Z0-9-_\$\?"|fold -w 9|head
}
