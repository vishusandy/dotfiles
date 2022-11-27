#!/usr/bin/env bash
# don't put duplicate lines or lines starting with space in the history.
#   HISTCONTROL=ignoredups:ignorespace
#   or HISTCONTROL=ignoreboth
# See bash(1) for more options

export HISTFILE=~/.bash_history
export HISTSIZE=-1
export HISTFILESIZE=-1
export HISTCONTROL=ignoredups
export HISTTIMEFORMAT="%F %I:%M%P" # date +"%I:%M%P"
