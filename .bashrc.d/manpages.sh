#!/usr/bin/env bash

alias man-search='man -k'
alias man-full-search='_alias_man_full_search'
alias man-where='man -w'
alias man-pages='man -f'
alias man-duplicates='_alias_ambiguous_man_sections'

_alias_man_full_search() {
    man -w -K "$1"
}

_alias_ambiguous_man_sections() {
    man -k "$1" | awk '{print $1;}' | sort | uniq -d
}

# Uses ^ to make the search start at the beginning of a string.
# Example Usage:
#   Open up manpage on systemd services to the COMMAND LINES section, which describes parsing the values of ExecStart and related commands
#>>>  man --pager='less -p ^COMMAND LINES' systemd.service
#   To allow spaces at the beginning use something like:
#     # open manpage on systemd services to the section describing the ExecStart option.  Without the "^\ *" it would just find the first mention of ExecStart= instead of the line where it is defined
#>>>  man --pager='less -p ^\ *ExecStart=' systemd.service
#->>    this will open up a manpage to the specified section
open_manpage_section() {
    if [[ ! "$1" ]]; then
        echoerr "No manpage specified"
        return 1
    fi
    if [[ ! "$2" ]]; then
        echoerr "No section specified"
        return 2
    fi
    # local section="$1"
    # local manpage="$2"
    # local pager="^ \ *$1" # or:    "^\s*$1"   --or--   original: "^ \ *$1"
    local pager_regex="^\s*$1" # or:    "^\s*$1"   --or--   original: "^ \ *$1"

    # man --pager='less -p $1' $2
    man --pager="less -p '$pager_regex'" "$2"
    #???  The following line of code uses extra variables but is more clear when reading than the above version, however the above avoids the creation and use of unnecessary variables
    #???    man --pager='less -p ^$SECTION' $MANPAGE
    #???
    #???  To allow spaces at beginning:
    #???    man --pager='less -p ^\ *'$section $manpage
}

open_manpage_keyword() {
    if [[ ! "$1" ]]; then
        echoerr "No manpage specified"
        return 1
    fi
    if [[ ! "$2" ]]; then
        echoerr "No section specified"
        return 2
    fi
    # local section
    # section="$1"
    # local manpage
    # manpage="$2"
    local pager_regex
    pager_regex="$1"

    man --pager="less -p '$pager_regex'" "$2"
}
