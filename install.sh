#!/bin/bash

if [ $SHELL != '/bin/zsh' ]; then
  chsh -s $(which zsh)
fi

#
# Symlink all dotfiles into ~/
#
for file in **/*.symlink; do
  filename=${file%.*}
  dotfilename=".${filename##*/}"

  source=`pwd`/$file
  target=$HOME/$dotfilename

  if [ ! -e $target ]; then
    ln -s $source $target
    echo "INFO: $dotfilename symlink created"
  else
    echo "WARNING: $dotfilename already exists, no changes were made"
  fi
done
unset file

source $HOME/.zshrc
