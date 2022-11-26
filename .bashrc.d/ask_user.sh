#!/usr/bin/env bash

function __ask_user_yesno() {
    # https://tecadmin.net/bash-script-prompt-to-confirm-yes-no/
    #!! Return non-zero return status only if answer is not a yes/no response,
    #!!   otherwise echo either "yes" or "no"
    #!! Reason for echoing either "yes" or "no" is allow general purpose usage,
    #!!   as a non-zero code for a "no" answer could break scripts using set -e
    #!! Convenience scripts are provided below to easily test for specific yes or no answers
    #@@@ Example Usage:
    #>>   if [[ "$(__ask_user_yesno "Proceed?")" == "yes" ]]; then echo "yupp" ; else echo "nope" ; fi
    ## --OR--
    #>>   echo "yes" | __ask_user_yesno "Proceed?"; echo "$YES_NO"

    local YES_NO
    # read doesn't seem to like using variables for placeholder text
    #   so use conditional statements instead
    if [[ "$2" == "yes" || "$2" == "y" || "$2" == "confirm" ]]; then
        read -e -r -p "${1:-Proceed?} [y/yes/n/no]: " -i "yes" YES_NO
    elif [[ "$2" == "no" || "$2" == "n" || "$2" == "deny" ]]; then
        read -e -r -p "${1:-Proceed?} [y/yes/n/no]: " -i "no" YES_NO
    else
        read -r -p "${1:-Proceed?} [y/yes/n/no]: " YES_NO
    fi

    case $YES_NO in
    [yY][eE][sS] | [yY])
        echo "yes"
        ;;
    [nN][oO] | [nN])
        echo "no"
        ;;
    *)
        echo "Invalid response.  Specify either 'yes' or 'no'"
        return 1
        ;;
    esac
}

function __ask_user_confirm() {
    #!! Asks the user to provide a yes or no response.
    #!!   Does not echo the answer like __ask_user_yesno does,
    #!!   but instead returns 0 (true) only if the user answered yes
    #!! return values:
    #!_   "yes" or "y": true (return value of zero)
    #!_   anything else: false (return non-zero value)
    #>> if __ask_user_confirm ""; then echo "yes, proceed"; else echo "Denied!!"; fi
    local answer
    answer="$(__ask_user_yesno "$@")"
    case $answer in
    yes) return 0 ;;
    no) return 1 ;;
    *) return 2 ;;
    esac
}

function __ask_user_deny() {
    #!!   Does not echo the answer like __ask_user_yesno does,
    #!!   but instead returns 0 (true) only if the user answered no
    #!! return values:
    #!_   "no" or "n": true (return value of zero)
    #!_   anything else: false (return non-zero value)
    #@@@ Example Usage
    #>> if __ask_user_deny ""; then echo "Denied =)"; else echo "not denied :/"; fi
    local answer
    answer="$(__ask_user_yesno "$@")"
    case $answer in
    no) return 0 ;;
    yes) return 1 ;;
    *) return 2 ;;
    esac
}
