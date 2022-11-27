#!/usr/bin/env bash


if shopt -q login_shell; then # In a login shell, so return/exit
    return
elif [[ ! $- == *i* ]]; then # In a non-interactive shell, so return/exit
    return
fi

eval "$(starship init bash)"

