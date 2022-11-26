#!/usr/bin/env bash

# Ensure the echoerr function exists for functions that may use it
#== ORIGINAL: echoerr() { [ "$DEBUG_MODE" = true ] && printf '%b' "$*" >&2; }
echoerr() { [[ ! "$HIDE_ERRORS" || "$HIDE_ERRORS" = "false" ]] && printf '%b' "$*" >&2; }
# [[ -n "$HIDE_ERRORS" && "$HIDE_ERRORS" = true ]]    && echo ""

# Check if a function has been declared and exists
# source:
# https://stackoverflow.com/questions/85880/determine-if-a-function-exists-in-bash
#   appended double quote is an ugly trick to make sure we do get a string -- if $1 is not a known command, type does not output anything
# https://stackoverflow.com/a/9002012
fn_exists() {
    # shellcheck disable=SC2046,SC2086,SC2268
    [ x$(type -t $1) = xfunction ]
}
