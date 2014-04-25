#!/bin/zsh
##
## link.sh for in  /home/darki/.dotfiles
## 
## Made by emmanuel ohland
## Login   <ohland_e@epitech.net>
## 
## Started on  Thu Apr 24 01:31:32 2014 emmanuel ohland
## Last update Fri Apr 25 23:25:21 2014 emmanuel ohland
##

list=(`ls -1`)
exclude=('README.md' 'LICENSE' 'link.sh')

# exclude files from $exclude
for file in "${exclude[@]}"
do
  list=(${list[@]/#%$file})
done

for file in "${list[@]}"
do
  dest="$HOME/.$file"
  flags='vTsi'

  # if $dest is not a symlink
  if [[ ! -h "$dest" ]]
  then
    flags+='b' # tells ln to backup the existing file
  fi
  ln -$flags "$PWD/$file" "$HOME/.$file"
done
