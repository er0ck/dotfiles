#!/bin/bash

backup_file() {
  BASENAME=`basename $1`
  echo "backing up .$BASENAME"
  #echo "$HOME/.$BASENAME $HOME/.$BASENAME.bak"
  mv -n $HOME/.$BASENAME $HOME/.$BASENAME.bak > /dev/null 2>&1
}

create_symlink() {
  echo "symlinking to $1"
  BASENAME=`basename $1`
  ABSOLUTE_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)
  #echo "$ABSOLUTE_PATH/$1 $HOME/.$BASENAME"
  ln -s $ABSOLUTE_PATH/$1 $HOME/.$BASENAME
}

FILES=(bin git/gitconfig rubocop.yml pryrc shell/bash_profile shell/bashrc shell/inputrc shell/rvm_profile vim vim/vimrc)

for i in ${FILES[@]}; do
  backup_file ${i}
  create_symlink ${i}
done

source $HOME/.bash_profile

exit 0
