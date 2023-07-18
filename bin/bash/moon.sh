#!/usr/bin/env bash

find_moon_phase() {
    local MOON_SOURCE="https://wttr.in/Chicago?format=%m"
    local MOON
    MOON="$(curl -s "$MOON_SOURCE")"
    if [[ "$MOON" ]]; then
        echo -n "$MOON"
    fi
}

#@@ Moon Phase
#   Find what phase the moon is currently in
#   The $MOON and $MOON_PHASE variables will be used to store the results.
function moon_phase_description() {
    local PHASE=""
    if [[ ! "$1" ]]; then return 1; fi

    if [[ "$1" = "🌑" ]]; then
        PHASE="new moon"
    elif [[ "$1" = "🌒" ]]; then
        PHASE="waxing crescent moon"
    elif [[ "$1" = "🌓" ]]; then
        PHASE="first quarter moon"
    elif [[ "$1" = "🌔" ]]; then
        PHASE="waxing gibbous moon"
    elif [[ "$1" = "🌕" ]]; then
        PHASE="full moon"
    elif [[ "$1" = "🌖" ]]; then
        PHASE="waning gibbous moon"
    elif [[ "$1" = "🌗" ]]; then
        PHASE="last quarter moon"
    elif [[ "$1" = "🌘" ]]; then
        PHASE="waning crescent moon"
    elif [[ "$1" = "🌙" ]]; then
        PHASE="crescent moon"
    #** Note: the following emojis aren't used by wttr.in however they are still useful to document here
    #** elif [[ "$MOON" = "🌚" ]]; then PHASE="new moon face";
    #** elif [[ "$MOON" = "🌛" ]]; then PHASE="first quarter moon face";
    #** elif [[ "$MOON" = "🌜" ]]; then PHASE="last quarter moon face";
    else
        PHASE=""
        return 2
    fi
    echo -n "$PHASE"
}
