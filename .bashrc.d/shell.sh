#!/usr/bin/env bash

alias shell-info="ps -p \$\$"
alias current-shell="printf \"%s\n\" \"\$SHELL\""

alias list-aliases='alias -p'

alias list-bash-aliases='if [[ "$__MANPAGE_ALIASES__" ]]; then alias | grep -Po "(?<=alias )bash-.*"; fi'
