#!/usr/bin/env bash

alias edit-exports='sudo nano /etc/exports && echo "exporting..." && sudo exportfs -a && echo "restarting nfs..." && sudo systemctl restart nfs-kernel-server'

alias nfs-export='sudo exportfs -ra; sudo service portmap restart; sudo service nfs-kernel-server restart'
alias nfs-restart='nfs-export'
alias restart-nfs='nfs-export'
alias export-nfs='nfs-export'
