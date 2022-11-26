#!/usr/bin/env bash

# Systemd
alias reload-systemd="sudo systemctl daemon-reload"
alias systemd-reload="sudo systemctl daemon-reload"

# system logs & logging
alias clean-journal-logs='journalctl --vacuum-size=500M' # https://nbailey.ca/post/clean-the-systemd-journal/
alias clean-journal-by-date='sudo journalctl --vacuum-time=2d'
alias listlogs="ls -lASh /var/log"
