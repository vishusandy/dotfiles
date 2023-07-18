#!/usr/bin/env bash

soft-kill() {
    if [ -n "$1" ]; then
        local pname=$1
        kill -SIGTERM "$(list-pids "$pname")"
    else
        echo "No process name specified"
    fi
}

hard-kill() {
    if [ -n "$1" ]; then
        local pname=$1
        kill -SIGKILL "$(list-pids "$pname")"
    else
        echo "No process name specified"
    fi
}

get_admin() {
    # If not running as root ask for admin privileges
    if [[ $EUID -eq 0 ]]; then
        sudo -v || return 1
    fi
}

# DO NOT RUN WITH SUDO / AS ROOT
do_not_run_as_root() {
    if [[ $EUID -eq 0 ]]; then
        echo "This script must NOT run as root"
        exit 1
    fi
}

# DO NOT RUN WITH SUDO / AS ROOT
must_be_root() {
    if [[ $EUID -ne 0 ]]; then
        echo "This script must run as root"
        exit 1
    fi
}
