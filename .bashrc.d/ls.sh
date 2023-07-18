#!/usr/bin/env bash

alias ls="ls --color=auto --group-directories-first -A"

# Shell Builtins
alias lsa="ls -lA"
alias ls-by-size="ls --color=auto --group-directories-first -SAh"
alias ls-size="ls --color=auto --group-directories-first -SAh"
alias ls-by-size-si="ls --color=auto --group-directories-first -SA --si"
alias ls-size-si="ls --color=auto --group-directories-first -SA --si"
alias ls-by-time="ls --color=auto --group-directories-first -tA"
alias ls-by-access="ls --color=auto --group-directories-first -uA"
alias ls-by-ext="ls --color=auto --group-directories-first -XA"
alias ls-by-type="ls --color=auto --group-directories-first -XA"
alias ls-natural="ls --color=auto --group-directories-first -vA"
alias ls-classify="ls --color=auto --group-directories-first -AF"
alias ls-dirs-only="ls --color=auto --group-directories-first -dA"
alias ls-options-help="echo -e '-A\tAll files except . and ..\n-B\tIgnore backups\n-d\tList directories themselves not their contents\n--group-directories-first\tGroup directories before files\n--Color=auto\tcolorizes output\n-r\tReverse\n-R\tRecursive\n-h\tHuman readable sizes using powers of 1024\n--si\tHuman readable sizes using powers of 1000 not 1024\n-F\tClassify - append symbol (see ls-help-classify)\n-p\tClassify directories using / character\n--file-type\tClassify regular files, except links (no * applied for links)\n-I\tDo not list implied entries matching shell PATTERN\n--hide=PATTERN\tHides matching shell pattern (-a or -A overrides this)\n-m\tUse comma separated list of entries, CSV output\n-i\tPrint the inode number of each file\n-n\tNumeric user and group IDs (use numbers for UID/GID)\n-Q\tQuote entry names in double quotes\n-b\tPrint C-style escapes for nongraphic characters\n-s\tPrint allocated size of file in blocks\n-S\tSort by file size, largest first\n-U\tDo not sort - list entries in directory order\n-t\tSort by modiciation time, newest first\n-u\tSort by access time, newest first\n-c\tSort by ctime (last modification of file status information)\n\n-1\tList one entry per line\n-l\tLong list\n-o\tLike -l but do not show group\n-g\tLike -l but do not show owner\n--full-time\tLike -l but shows full time\n-C\tList entries by columns\n--author\tWith -l print the author of each file\n-C\tList entries by columns (fill first vertical column, then next one, etc - files are sorted down the columns instead of across the lines)\n-x\tList entries by lines instead of columns (fill first line, then next, etc - files sorted across the lines instead of down the columns)'"
alias ls-help-classify="echo -e \"-F classifies entries by appending a symbol:\n\t*\tRegular file that is executable\n\t/\tDirectories\n\t@\tSymbolic links\n\t|\tFIFOs\n\t=\tSockets\n\t>\tDoors\n\tNothing indicates regular file\""

# changes directory and immediately lists directory contents
# use -s as a second argument to indicate simple format (do not use -l [long listing format])
# otherwise if -s is not the second argument then long listing format will be used
#
# any other characters after the directory (or after -s if present) will be passed to ls
# if you wish to have multiple seperate arguments passed to ls quote it as a string
# examples:
#   cdl ~/some/dir       # use default format (long)
#   cdl ~/some/dir -r    # use default format and pass -r flag (reverse listing) to ls
#   cdl ~/some/dir -s    # use simple format
#   cdl ~/some/dir -s -r # use simple format and pass -r flag (reverse listing) to ls
#   cdl ~/some/dir -s "-r --author" # use simple format and pass multiple flags to ls
#   cdl ~/some/dir "-w 80 -t 2" # use default format and pass arguments with values to ls
#   cdl ~/some/dir -s "-w 80 -t 2"  # use simple format and pass arguments with values to ls
cdl() {
    # no existing directory specified
    if [ -z "$1" ] && [ -d "$1" ]; then
        echo "No existing directory specified"
        return
    # handling for simple listings and extra args
    elif [ -n "$2" ]; then
        cd "$1" || return
        # simple without extra args
        if [ "$2" = "-s" ] && [ -z "$3" ]; then
            ls -A "$2"
            # simple with extra args
        elif [ "$2" = "-s" ] && [ -n "$3" ]; then
            ls "$3"
            # not simple, with extra args
        else
            ls -lA "$3"
        fi
    # only an existing directory was passed in
    else
        cd "$1" || return
        # ls -lA
        ls
    fi
}

# Create a directory and immediately change into the directory
#
# mkcd DIR ["ARGS"]
#  note: cd has limited options for arguments
#
# mkcd newdir         create a new dir and change to the directory
#
# pass args to cd:
# mkcd newdir -P      this will not follow symbolic links; resolves symlinks in DIR before processing instances of '..'
mkcd() {
    # no existing directory specified
    if [ -z "$1" ] && [ ! -e "$1" ]; then
        echo "No directory specified, or it already exists"
        return
    # handling for simple listings and extra args
    elif [[ -n "$2" ]]; then
        mkdir "$1" && cd "$2" "$1" || return
    else
        mkdir "$1" && cd "$1" || return
    fi
}

# https://www.linuxjournal.com/content/boost-productivity-bash-tips-and-tricks
# shellcheck disable=SC2164
mkcd-alt() { mkdir -vp "$@" && cd "$@"; }
