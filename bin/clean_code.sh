#!/usr/bin/env bash

function basepath() {
    basename=$(basename "$1")
    if [[ "$basename" == "$1" ]]; then return 1; fi
    len="${#basename}"
    echo "${1:0:-$len-1}"
}

dir=$PWD

nodeclean() {
    # https://unix.stackexchange.com/a/249503
    find . -type d -name "node_modules" -exec rm -rvf {} +
}

# https://stackoverflow.com/a/41386937
pyclean() {
    find . -regex '^.*\(__pycache__\|\.py[co]\)$' -exec rm -rvf {} +
}

rustclean() {
    find . -name "Cargo.toml" -print0 |
        while IFS= read -r -d '' line; do
            base=$(basepath "$line")
            cd "${base}" || exit
            cargo clean
            cd "$dir" || exit
        done
}

rustclean
pyclean
nodeclean
