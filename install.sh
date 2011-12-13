#!/bin/sh
# if [ ! -d ~/.oh-my-zsh ]
# then
#   echo "\033[0;33mGetting dotf\033[0m You'll need to remove ~/.dotfiles if you want to install"
#   /usr/bin/env git clone https://github.com/kaapa/dotfiles ~/.dotfiles
#   exit
# fi
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

function symlink() {
  local source=$1
  local target=$2
  echo ""
  if [ -f "$target" ] || [ -h "$target" ]; then
    echo "${yellow}Found ${target}"
    if diff "$source" "$target" > /dev/null; then
      echo "${green}The same version of $target already existed"
      return
    else
      echo "${white}Backing it up to ${target}-original";
      cp -RH "$target" "${target}-original"
      rm -R "$target"
    fi
  fi
  ln -s "$source" "$target"
  echo "${green}Created symbolic link ${target}"
}

echo "${white}Detecting OS..."
if [[ $OSTYPE =~ "darwin" ]]; then

  echo "${green}OS X detected"

  install "Homebrew" "brew" '/usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"'
  install "Mercurial" "hg" "brew install hg"
  install "Vim" "vim" "brew install https://raw.github.com/adamv/homebrew-alt/master/duplicates/vim.rb"
  install "ZSH" "zsh" "brew install zsh"

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

  echo "\n${white}Creating symbolic links for the configuration files..."

  symlink ~/".dotfiles/vimrc" ~/".vimrc"
  symlink ~/".dotfiles/vim" ~/".vim"
  symlink ~/".dotfiles/zshrc" ~/".zshrc"

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

else

  echo "${green}Linux detected"
fi
