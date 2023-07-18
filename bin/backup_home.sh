#!/usr/bin/env bash

#shellcheck disable=SC1090
. ~/bin/lib/vishus_backup_lib.sh

dir=$PWD
cd "$HOME/Code" || exit
clean_code.sh || exit
cd "$dir" || exit

backup "$HOME/.bashrc.d" "home"
backup "$HOME/.bashrc.d" "home" ~/.bashrc.d
backup "$HOME/.bashrc.d" "home" /

backup "$HOME" "home" apps/open-url.desktop
backup "$HOME" "home" apps/open-urls.desktop
backup "$HOME" "home" Templates
backup "$HOME" "home" .bashrc.d
backup "$HOME" "home" .bash_history
backup "$HOME" "home" .bash_profile
backup "$HOME" "home" .gitconfig
backup "$HOME" "home" .mrconfig
backup "$HOME" "home" .nanorc
backup "$HOME" "home" .profile
backup "$HOME" "home" .tmux.conf
backup "$HOME" "home" .selinux
backup "$HOME" "home" .local/share/nautilus/scripts
backup "$HOME" "home" .local/share/rhythmbox
backup "$HOME" "home" .config/alacritty
backup "$HOME" "home" .config/autokey
backup "$HOME" "home" .config/autostart
backup "$HOME" "home" .config/Code/User/keybindings.json
backup "$HOME" "home" .config/Code/User/settings.json
backup "$HOME" "home" .config/enchant/en_US.dic
backup "$HOME" "home" .config/gh
backup "$HOME" "home" .config/lsd
backup "$HOME" "home" .config/neofetch
backup "$HOME" "home" .config/nvim
backup "$HOME" "home" .config/monitors.xml
backup "$HOME" "home" Code
backup "$HOME" "home" ~/Documents

# backup "$HOME" "home" bin
# backup "$HOME" "home" apps/containers
# backup "$HOME" "home" fonts
# backup "$HOME" "home" .local/share/privateinternetaccess
# backup "$HOME" "home" .config/privateinternetaccess
# backup "$HOME" "home" .config/filezilla
# backup "$HOME" "home" .yubi_secret

# backup "/ares" "ares" apps
# backup "/ares" "ares" art
# backup "/ares" "ares" books
# backup "/ares" "ares" code
# backup "/ares" "ares" data
# backup "/ares" "ares" personal
# backup "/ares" "ares" photos
