#!/usr/bin/env bash

#shellcheck disable=SC1090
. ~/bin/lib/quickbak.sh

backup "$HOME" "home" .bashrc.d
backup "$HOME" "home" .bash_history
backup "$HOME" "home" .bash_profile
backup "$HOME" "home" bin
backup "$HOME" "home" .gitconfig
backup "$HOME" "home" .mrconfig
backup "$HOME" "home" .nanorc
backup "$HOME" "home" .profile
backup "$HOME" "home" .selinux
backup "$HOME" "home" .tmux.conf

backup "$HOME/.bashrc.d" "home"
backup "$HOME/.bashrc.d" "home" ~/.bashrc.d
backup "$HOME/.bashrc.d" "home" /
backup "$HOME" "home" ~/Documents
backup "/ares/docs" "ares" data
backup "/ares" "ares" "books" 
# backup "$HOME" "home" "/ares/data/popular baby names 2005.csv"
# backup "/ares/tmp2"
# backup "/ares/tmp3/tmp3.1"
# backup "/ares/tmp/"
# backup "/ares/tmp"
# backup "/ares"
backup "$HOME" "home" /home/andrew/Documents
