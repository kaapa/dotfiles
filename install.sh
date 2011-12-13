#!/bin/sh
shopt -s nocasematch

white="\033[0m"
red="\033[0;31m"
green="\033[0;32m"
yellow="\033[0;33m"
cyan="\033[0;36m"

function install() {
  local title=$1
  local executable=$2
  local command=$3
  echo "\n${white}Detecting ${title}..."
  if ! which $executable > /dev/null; then
    echo "${yellow}${title} was not found, installing it:${white}\n"
    eval $command
    if [ $? == 1 ]; then
      echo "\n${red}${title} installation failed"
      echo "${white}Unable to continue without ${title}, aborting installation"
      exit
    else
      echo "\n${green}${title} installed"
    fi
  else
    echo "${green}${title} found, skipping installation"
  fi
}

function install_dotfile() {
  local source=$1
  local target=$2
  local command=$3
  echo ""
  if [ -d "$target" ] || [ -f "$target" ] || [ -h "$target" ]; then
    echo "${yellow}${target} already exists"
    if [ ! -d "$target" ] && diff "$source" "$target" > /dev/null; then
      echo "${green}Skipping to next file as files are identical"
      return
    else
      echo "${white}Backing it up to ${target}-original";
      rm -Rf "${target}-original"
      mv -f "$target" "${target}-original"
    fi
  fi
  eval $command
  echo "${green}Created ${target}"
}

function copy_dotfile() {
  install_dotfile $1 $2 "cp -R '${1}' '${2}'"
}

function symlink_dotfile() {
  install_dotfile $1 $2 "ln -s '${1}' '${2}'"
}

function configure() {
  echo "\n${white}Setting up the configuration files..."

  symlink_dotfile ~/".dotfiles/vimrc" ~/".vimrc"
  symlink_dotfile ~/".dotfiles/vim" ~/".vim"
  symlink_dotfile ~/".dotfiles/zshrc" ~/".zshrc"
  copy_dotfile ~/".dotfiles/gitconfig" ~/".gitconfig"

  echo  "\n${white}Starting Vim to install bundles\c"

  for i in {1..3}
  do
    sleep 1
    echo "${white}.\c"
  done

  echo $white

  vim -c BundleInstall -c 'bufdo q!'

  if [ $? == 1 ]; then
    echo "\n${red}Installation of Vim bundles failed"
    echo "${white}You might want to try running 'vim -c BundleInstall'"
  else
    echo "\n${green}Installation of Vim bundles was successful"
  fi

  echo "\n${white}Setting ZSH the default shell..."

  chsh -s /bin/zsh

  echo "  editor = `which vim`" >> ~/.gitconfig

  echo "\n${white}Your name for Git configuration? \c"
  read git_name

  echo "\n${white}Your email for Git configuration? \c"
  read git_email

  echo "[user]\n  name = ${git_name}\n  email = ${git_email}" >> ~/.gitconfig

  echo "\n${white}Do you use Github? [y/n] \c"

  read use_github

  if [[ "y|yes" =~ $use_github ]]; then

    echo "\n${white}What is your github username? \c"
    read github_user

    echo "\n${white}What is your github token? \c"
    read github_token

    echo "[github]\n  user = ${github_user}\n  token = ${github_token}" >> ~/.gitconfig
  fi
}

if [[ $OSTYPE =~ "darwin" ]]; then

  echo "\n${white}This installation script will try to install the following tools:"

  echo "\n${white}* Homebrew"
  echo "${white}* Git"
  echo "${white}* Mercurial"
  echo "${white}* Vim"
  echo "${white}* ZSH"
  echo "${white}* Ack"
  echo "${white}* Exuberant ctags"

  echo "\n${white}Continue? [y/n] \c"

  read continue

  if [[ ! "y|yes" =~ $continue ]]; then
    exit
  fi

  echo "${white}Installing tools..."

  install "Homebrew" "brew" '/usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"'
  install "Git" "git" "brew install git"
  install "Mercurial" "hg" "brew install hg"
  install "Vim" "vim" "brew install https://raw.github.com/adamv/homebrew-alt/master/duplicates/vim.rb"
  install "ZSH" "zsh" "brew install zsh"
  install "Ack" "ack" "brew install ack"

  echo "\n${white}OS X provides a version of Exuberant ctags incompatible with Vim's TagList plugin"
  install "Exuberant ctags" "/usr/local/bin/ctags" "brew install ctags"
  echo "${white}To override incompatible system provided ctags we need to add Homebrew binaries to Vim's path"
  echo "${white}Detecting if /etc/paths contains Homebrew's package path (/usr/local/bin)..."

  if ! grep /usr/local/bin /etc/paths > /dev/null; then
    echo "/usr/local/bin"|cat - /etc/paths > /tmp/out && sudo mv /tmp/out /etc/paths
    echo "${green}/usr/local/bin has been added to /etc/paths"
  else
    echo "${green}/usr/local/bin was already in /etc/paths"
  fi

  configure

else

  if ! which "apt-get" > /dev/null; then
    echo "\n${red}Apt package manager was not found. Aborting installation"
    exit
  fi

  echo "\n${white}This installation script will install the following tools unless already present:"

  echo "\n${white}* Git"
  echo "${white}* Vim"
  echo "${white}* ZSH"
  echo "${white}* Exuberant ctags"

  echo "\n${white}Continue? [y/n] \c"

  read continue

  if [[ ! "y|yes" =~ $continue ]]; then
    exit
  fi

  echo "${white}Installing tools..."

  install "Git" "git" "sudo apt-get install git"
  install "Vim" "vim" "sudo apt-get install vim-nox"
  install "ZSH" "zsh" "sudo apt-get install zsh"
  install "Ack" "ack" "sudo apt-get install ack"
  install "Exuberant ctags" "ctags" "sudo apt-get install exuberant-ctags"

  configure

fi
