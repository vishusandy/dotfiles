#!/usr/bin/env bash

# Create an associative array to store the color codes
unset _color # ensure the variable is not already used, if it has been it may not create the array correctly, e.g. trying to create an indexed array (number index) instead of associative (text subscripts)
declare -A _color=([nocolor]='\033[0m' [red]='\033[0;31m' [green]='\033[0;32m' [orange]='\033[0;33m' [blue]='\033[0;34m' [purple]='\033[0;35m' [cyan]='\033[0;36m' [lightgray]='\033[0;37m' [darkgray]='\033[1;30m' [lightred]='\033[1;31m' [lightgreen]='\033[1;32m' [yellow]='\033[1;33m' [lightblue]='\033[1;34m' [lightpurple]='\033[1;35m' [lightcyan]='\033[1;36m' [white]='\033[1;37m')
export _color

# Create a copy of the above array with a shorter name
unset _c # ensure the variable is not already used, if it has been it may not create the array correctly, e.g. trying to create an indexed array (number index) instead of associative (text subscripts)
declare -A _c=([nocolor]='\033[0m' [red]='\033[0;31m' [green]='\033[0;32m' [orange]='\033[0;33m' [blue]='\033[0;34m' [purple]='\033[0;35m' [cyan]='\033[0;36m' [lightgray]='\033[0;37m' [darkgray]='\033[1;30m' [lightred]='\033[1;31m' [lightgreen]='\033[1;32m' [yellow]='\033[1;33m' [lightblue]='\033[1;34m' [lightpurple]='\033[1;35m' [lightcyan]='\033[1;36m' [white]='\033[1;37m')
export _c

#!! Test with:
#>>>  echo "This is ${_color[white]} white text ${_color[nocolor]}, and this ${_color[cyan]} is Orange"
#>>>  echo "This is ${_c[white]} white text ${_c[nocolor]}, and this ${_c[cyan]} is Orange"
