#!/usr/bin/env bash

#shellcheck disable=SC1090
. ~/bin/lib/vishus_backup_lib.sh

dir=$PWD
cd "$HOME/Code" || exit
clean_code.sh || exit
cd "$dir" || exit

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

backup "$HOME" "home" .local/share/backgrounds
backup "$HOME" "home" .local/share/nautilus-python
backup "$HOME" "home" .local/share/nautilus/scripts
backup "$HOME" "home" .local/share/rhythmbox

backup "$HOME" "home" .config/alacritty
backup "$HOME" "home" .config/autokey
backup "$HOME" "home" .config/autostart
backup "$HOME" "home" .config/coc
backup "$HOME" "home" .config/Code/User/keybindings.json
backup "$HOME" "home" .config/Code/User/settings.json
backup "$HOME" "home" .config/enchant/en_US.dic
backup "$HOME" "home" .config/fontconfig
backup "$HOME" "home" .config/gh
backup "$HOME" "home" .config/lsd
backup "$HOME" "home" .config/nvim
backup "$HOME" "home" .config/neofetch
backup "$HOME" "home" .config/monitors.xml
backup "$HOME" "home" .config/starship.toml

backup "$HOME" "home" Code
backup "$HOME" "home" Documents
backup "$HOME" "home" fonts
backup "$HOME" "home" Templates

backup "$HOME" "home" apps/containers

backup "$HOME" "home" .gnupg
backup "$HOME" "home" .ssh
backup "$HOME" "home" .yubi_secret
backup "$HOME" "home" .cargo/credentials
backup "$HOME" "home" .config/gh
backup "$HOME" "home" .config/gh
backup "$HOME" "home" .config/filezilla
backup "$HOME" "home" .config/privateinternetaccess
backup "$HOME" "home" .local/share/privateinternetaccess

backup "/etc" "etc" /etc/selinux/config

backup "/home/andrew/Code/personal/who-dis" "who-dis" /home/andrew/Code/personal/who-dis/setup.txt
backup "/etc" "who-dis" /etc/ddclient.conf
backup "/etc/nginx" "who-dis/nginx" nginx.conf
backup "/etc/nginx" "who-dis/nginx" snippets
backup "/etc/nginx" "who-dis/nginx" conf.d

backup "/ares" "ares" apps
backup "/ares" "ares" art
backup "/ares" "ares" books
backup "/ares" "ares" code
backup "/ares" "ares" docs/data
backup "/ares" "ares" docs/personal
backup "/ares" "ares" photos
backup "/ares" "ares" backups/code
backup "/ares" "ares" backups/dad
backup "/ares" "ares" backups/personal
