#!/usr/bin/env bash

# Ask the user a yes or no question.
# Returns the string "yes" or "no".  Returns a non-zero exit code if the user
# enters an invalid response.
#
# Reason for echoing either "yes" or "no" is to allow general purpose usage,
#   as a non-zero code for a "no" answer could break scripts using set -e
#
# Example Usage:
#   if [[ "$(__ask_user_yesno "Proceed?")" == "yes" ]];
#       then echo "yupp"
#   else
#       echo "nope"
#   fi
# OR
# answer=$(__ask_user_yesno "Proceed?")
#
# Source:
# https://tecadmin.net/bash-script-prompt-to-confirm-yes-no/
function __ask_user_yesno() {

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
        echo "Invalid response.  Specify either 'yes' or 'no'" >&2
        return 1
        ;;
    esac
}

# Asks the user to provide a yes or no response.
#
# Does not echo the answer like __ask_user_yesno does,
# but instead returns 0 (true) only if the user answered yes
#
# Returns:
#   input is "yes" or "y":  true (return value of zero)
#   anything else:          false (return non-zero value)
function __ask_user_confirm() {
    #>> if __ask_user_confirm ""; then echo "yes, proceed"; else echo "Denied!!"; fi
    local answer
    answer="$(__ask_user_yesno "$@")"
    case $answer in
    yes) return 0 ;;
    no) return 1 ;;
    *) return 2 ;;
    esac
}

# Does not echo the answer like __ask_user_yesno does,
# but instead returns 0 (true) only if the user answered no
#
# Returns:
#   input is "no" or "n":   true (return value of zero)
#   anything else:          false (return non-zero value)
#
# Example Usage
# if __ask_user_deny ""; then echo "Denied =)"; else echo "not denied :/"; fi
function __ask_user_deny() {
    local answer
    answer="$(__ask_user_yesno "$@")"
    case $answer in
    no) return 0 ;;
    yes) return 1 ;;
    *) return 2 ;;
    esac
}
