#!/bin/bash

echo "  ____ _                            ____        _    __ _ _            "
echo " / ___| |__  _ __ ___  _ __   ___  |  _ \  ___ | |_ / _(_) | ___  ___  "
echo "| |   | '_ \| '__/ _ \| '_ \ / _ \ | | | |/ _ \| __| |_| | |/ _ \/ __| "
echo "| |___| | | | | | (_) | | | | (_) || |_| | (_) | |_|  _| | |  __/\__ \ "
echo " \____|_| |_|_|  \___/|_| |_|\___(_)____/ \___/ \__|_| |_|_|\___||___/ "
echo "  ===================================================================  "
echo "                                                                       "

dir_base=$(cd $(dirname $0);pwd)
cd $dir_base

list_ln="
.bash_profile
.zshrc
.gitconfig
.gitignore
.vimrc
.tmux.conf
"
for file in $list_ln; do
	ln -sf $dir_base/$file ~/$file
done

git stash
git pull origin master
git stash pop

# git
echo
echo " >> Setup git"
read -p "user.name: " input_name
read -p "user.email: " input_email
git config --global user.name "$input_name"
git config --global user.email "$input_email"

# vim
echo
echo " >> Setup vim"
vim +NeoBundleInstall +qall
