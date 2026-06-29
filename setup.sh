#!/bin/bash

echo "  ____ _                            ____        _    __ _ _            "
echo " / ___| |__  _ __ ___  _ __   ___  |  _ \  ___ | |_ / _(_) | ___  ___  "
echo "| |   | '_ \| '__/ _ \| '_ \ / _ \ | | | |/ _ \| __| |_| | |/ _ \/ __| "
echo "| |___| | | | | | (_) | | | | (_) || |_| | (_) | |_|  _| | |  __/\__ \ "
echo " \____|_| |_|_|  \___/|_| |_|\___(_)____/ \___/ \__|_| |_|_|\___||___/ "
echo "  ===================================================================  "
echo "                                                                       "

dir_base=$(CDPATH= cd "$(dirname "$0")" && pwd -P)
cd "$dir_base" || exit 1

list_ln="
.bash_profile
.bashrc
.profile
.shellrc
.zprofile
.zshrc
.gitconfig
.gitignore
.vimrc
.tmux.conf
"
for file in $list_ln; do
	ln -sfn "$dir_base/$file" "$HOME/$file"
done

git stash
git pull origin master
git stash pop

"$dir_base/setup-git.sh" || exit 1

# vim
echo
echo " >> Setup vim"
vim +NeoBundleInstall +qall
