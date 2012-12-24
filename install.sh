#!/bin/bash

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
    echo "WARNING: $dotfilename already exists"
  fi
done
unset file
