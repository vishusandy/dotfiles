#!/usr/bin/env bash

# shellcheck disable=SC2154

# Write out the "bash tips and tricks.txt" file and eixt
echo "---- BASH TIPS & TRICKS ----"
cat "$HOME/Documents/linux/bash/bash/bash tips and tricks.txt"
# cat "$HOME/Documents/linux/shell scripting/bash/bash tips and tricks.txt"

echo -e "\n---- BASH SNIPPETS ----"
cat "/config/bin/bash_snippets.sh"

exit


# Write a message to stderr instead of stdout
#   Modifed from https://stackoverflow.com/a/2990533 and https://stackoverflow.com/a/43814587
echoerr() { echo "$@" 1>&2; }
# --OR--
echoerr() { [ "$DEBUG_MODE" = true ] && printf '%b' "$*" >&2; }
  # Note: outputs all arguments passed to it.




#@@ HERESTRINGS
# source: https://tldp.org/LDP/abs/html/x17837.html
ArrayVar=( element0 element1 element2 {A..D} )
while read element ; do
  echo "$element" 1>&2
done <<< "$(echo ${ArrayVar[*]})"

# --or--

while read -r URL; do echo "$URL"; done <<< "$URLS"



#@@ HEREDOC
#?? source: https://tldp.org/LDP/abs/html/here-docs.html
#?? examples: https://tldp.org/LDP/abs/html/here-docs.html#EX71
#??           https://tldp.org/LDP/abs/html/here-docs.html#EX71A
#
# Multi-line Message Using Cat
# https://tldp.org/LDP/abs/html/here-docs.html#EX71
cat << EOT
(?<=…) is positive lookbehind assertion
(?<!…) is negative lookbehind assertion
(?=…) is positive lookahead assertion
(?!…) is negative lookahead assertion
EOT
# Multi-line Message with Tabs Suppressed
# https://tldp.org/LDP/abs/html/here-docs.html#EX71A
cat <<-ENDOFMESSAGE
	 This is line 1 of the message.
	This is line 2 of the message.
	This is line 3 of the message.
	  This is line 4 of the message.
	        This is the last line of the message.
ENDOFMESSAGE

  # element0 element1 element2 A B C D
# 


##@@@ Heredoc Examples with Read

# source: https://stackoverflow.com/a/1655389
read -r -d '' VAR <<'EOF'
abc'asdf"
$(dont-execute-this)
foo"bar"''
EOF
echo "$VAR"
# 
# To use tabs for readability purposes but strip beginning whitespace from heredoc text:
read -r -d '' VAR <<-'EOF'
    abc'asdf"
    $(dont-execute-this)
    foo"bar"''
EOF
echo "$VAR"
# 
# Preserve tabs in the resulting variable
IFS='' read -r -d '' VAR <<'EOF'
    abc'asdf"
    $(dont-execute-this)
    foo"bar"''
EOF
echo "$VAR"


#@@ Bash Regex - Using Negative-lookaheads To Find URLs
echo -e $'https://docs.min.io/docs/minio-deployment-quickstart\ guide.html      \nhttps://docs.min.io/docs/deploy-minio-on-kubernetes.html\t\tTHIS-IS-NO\t\nhttps://helm.sh/\nhttps://github.com/helm/charts/tree/master/stable/minio  NOPE\nhttps://github.com/minio/operator/blob/master/README.md\\\tthis-works-yea\n' | grep -P -o 'https://([^\s]|(?<=\\)\s)*' \
| grep -P -o '(https?)://([^\s]|(?<=\\)\s)*'


##@@@ Iterate URLs in string

# Iterate lines in a variable
while read -r URL; do echo "$URL"; done <<< "$URLS"

# Specify text to search, find all URLs, and iterate over each URL
while read -r URL; do echo "$URL"; done <<< "$(echo -e $'https://docs.min.io/docs/minio-deployment-quickstart\ guide.html      \nhttps://docs.min.io/docs/deploy-minio-on-kubernetes.html\t\tTHIS-IS-NO\t\nhttps://helm.sh/\nhttps://github.com/helm/charts/tree/master/stable/minio  NOPE\nhttps://github.com/minio/operator/blob/master/README.md\\\tthis-works-yea\n' | grep -P -o 'https://([^\s]|(?<=\\)\s)*')"

# Find all URLs in a string variable then iterate through the URLs
while read -r URL; do echo "$URL"; done <<< "$(echo -e "$TEXT" | grep -P -o 'https://([^\s]|(?<=\\)\s)*')"

  # Same as above but on multiple lines
  while read -r URL; do
    echo "$URL" # or use: xdg-open "$URL"
  done <<< "$(echo -e "$TEXT" | grep -P -o 'https://([^\s]|(?<=\\)\s)*')"
  
  # Same as above but opens the URL with the default web browser
  while read -r URL; do
    xdg-open "$URL"
  done <<< "$(echo -e "$TEXT" | grep -P -o 'https://([^\s]|(?<=\\)\s)*')"





#@@ Bash Regex Matching & Matches Array
#   source: https://riptutorial.com/bash/example/19469/regex-matching
#     more:
#       https://www.linuxjournal.com/content/bash-regular-expressions
#   For regex documentation see:
#     https://tldp.org/LDP/Bash-Beginners-Guide/html/sect_04_01.html
#     man 'regex(7)'
#     `info test` and scroll past expr to: 16.4.1 String expressions
#   For pattern matching see:
#     https://www.gnu.org/software/bash/manual/html_node/Pattern-Matching.html#Pattern-Matching
pat='[^0-9]+([0-9]+)'
s='I am a string with some digits 1024'
[[ $s =~ $pat ]] # $pat must be unquoted
echo "${BASH_REMATCH[0]}"
echo "${BASH_REMATCH[1]}"
  # Explanation:
  #   The [[ $s =~ $pat ]] construct performs the regex matching
  #   The captured groups i.e the match results are available in an array named
  #   BASH_REMATCH
  #   The 0th index in the BASH_REMATCH array is the total match
  #   The i'th index in the BASH_REMATCH array is the i'th captured group, where i = 1,
  #   2, 3 ...

# Instead of assigning the regex to a variable ( $pat ) we could also do:
[[ $s =~ [^0-9]+([0-9]+) ]]




#@@ BASH REGEX CAPTURE GROUPS ONLY
#  source: https://franklingu.github.io/programming/2016/11/19/grep-and-show-capture-group-only/
echo "foo 'bar'" | grep -Po "(?<=')[^']+(?=')"


  # Print out all uuid's (length of 36 characters including separating hyphens)
  list="$(dconf read /com/gexperts/Tilix/profiles/list)" # for tilix, echo's a list of form: ['...', '...', '...'] with at least one element
  echo "$list" | grep -Po "(?<=')[a-fA-F0-9-]{36}(?=')"




##@@@ SHOW DUPLICATE ENTRIES
# show only entries that have duplicates
sort "list.txt" | uniq -d



#@@ ARRAYS

##@@@ Check if a specified variable is an array
function check_is_array() {
  if [[ ! "$1" ]]; then return 1; fi
  # https://stackoverflow.com/a/27254437
  declare -p $1 2> /dev/null | grep -q '^declare \-a'
}

##@@@ Test if a specified variable is an array
# Modified from: https://stackoverflow.com/a/14525326
is_array() {
  str="$(declare -p $1 2>/dev/null)";if [[ "${str:0:10}" == 'declare -a' ]];then return 0; else return 1; fi
}

##@@@ Iterate array elements
#   source: https://opensource.com/article/18/5/you-dont-know-bash-intro-bash-arrays#looping-through-array-elements
for t in "${allThreads[@]}"; do
  ./pipeline --threads $t
done

##@@@ Iterate array indices
#   source: https://opensource.com/article/18/5/you-dont-know-bash-intro-bash-arrays#looping-through-array-elements
for i in "${!allThreads[@]}"; do
  ./pipeline --threads ${allThreads[$i]}
done

#@@ Iterating an array by index
#   The ! in front of the variable `foo` makes it look at the index instead of the value
# source: https://stackoverflow.com/a/6723516
for i in "${!foo[@]}"; do 
  printf "%s\t%s\n" "$i" "${foo[$i]}"
done


##@@@ Add Element to Array Without Specifying the Index
SOME_ARRAY=( a b c d e )
SOME_ARRAY+=(f)
echo "${SOME_ARRAY[@]}"

# Display Length/Number of Elements in an Array
echo "${#SOME_ARRAY[*]}"
# --or--
echo "${#SOME_ARRAY[@]}"
  # Difference betwee [@] and [*]
  #   "$@" expand each element as a separate argument
  #   "$*" expand to the arguments merged into one argument.
  #   source: http://www.masteringunixshell.net/qa35/bash-how-to-print-array.html

##@@@ Print array index and element value for each array element
#   source: https://stackoverflow.com/a/6723516
for i in "${!foo[@]}"; do 
  printf "%s\t%s\n" "$i" "${foo[$i]}"
done

##@@@ Iterate lines in a variable
#   source: https://superuser.com/a/284226
while IFS= read -r line; do
    echo "... $line ..."
done <<< "$list"

  # Iterate tilix IDs
  TID_LIST=()
  list="$(dconf read /com/gexperts/Tilix/profiles/list)" # for tilix, echo's a list of form: ['...', '...', '...'] with at least one element
  IDS=$(echo "$list" | grep -Po "(?<=')[a-fA-F0-9-]{36}(?=')")
  #   basically assigning the matches to IDS, with the original command being:
  #     echo "$list" | grep -Po "(?<=')[a-fA-F0-9-]{36}(?=')"
  IDARRAY=( $IDS )
  # --or--
  while IFS= read -r line; do TID_LIST+=("$line"); done <<< "$IDLIST"

##@@@ Test if variable is array
#   https://stackoverflow.com/questions/14525296/how-do-i-check-if-variable-is-an-array
#   https://stackoverflow.com/a/14525326
declare -p variable-name 2> /dev/null | grep -q '^declare \-a'

  # Note/quirk: Array must be used first
  #   https://stackoverflow.com/questions/14525296/how-do-i-check-if-variable-is-an-array#comment85353213_14525326
  # I found that if I do declare -A x ; declare -p x I'm told bash: declare: x: not found. I have to actually use the array before it's recognised as such: declare -A x ; x[_]= ; unset x[_] ; declare -p x returns declare -A x='()'. I don't know if this is expected behaviour, but thought it worth mentioning! (This is only for uninitialised arrays, by the way. If I initialise it to empty - declare -A x='()' - it works as expected.) 




#@@ Test If Variable Exists - not just empty or not
# # https://unix.stackexchange.com/a/212192
[[ -v name_of_var ]]
[[ -v something ]] && echo "exists"
#?? From help test:
#??   -v VAR, True if the shell variable VAR is set
  # https://unix.stackexchange.com/a/381524
  # To test if the variable is set, [ -n "$var" ] works similarly, so there's not much use for ${var:+value}. 
  # On the other hand, ${var+value} (without the colon) is useful to tell the difference between an empty and an unset variable:
  # 
  # unset a
  # b=
  # [ "${a+x}" = "x" ] && echo a is set
  # [ "${b+x}" = "x" ] && echo b is set



#@@ Command Exists
if command -v powerline-daemon &> /dev/null; then echo "powerline is installed"; fi

#@@ Show Bash Function Definition
# https://stackoverflow.com/questions/6916856/can-bash-show-a-functions-definition
# https://stackoverflow.com/a/6916952
# 
# Show the variable type and definition of a function
type foobar
# Just show the funciton definition, not its name or that it is a funciton
type foobar | sed '1,3d;$d'

#@@ Check if a function has been declared and exists
# source:
# https://stackoverflow.com/questions/85880/determine-if-a-function-exists-in-bash
#   appended double quote is an ugly trick to make sure we do get a string -- if $1 is not a known command, type does not output anything
# https://stackoverflow.com/a/9002012
fn_exists() {
  # shellcheck disable=SC2046,SC2086
  [ x$(type -t $1) = xfunction ];
}




#@@ Get the name of the script that is executing
#   Note: when included with . or source, the return value
#   will not be `common.sh`, it will be the script that was
#   executed by the user on the command line.
function script_name() {
  echo $(basename "$0")
}




#@@ DO NOT RUN WITH SUDO / AS ROOT
must_be_root () {
  if [[ $EUID -ne 0 ]]; then
      echo "This script must NOT run as root" 
      exit 1
  fi
}



#@@ FILES & DIRECTORIES

##@@@ DIRECTORY RECURSION
sudo find "$search_dir" -print0 | while IFS= read -rd '' f; do 
  echo "$f"
done


##@@@ GET DIRECTORY PATH WITHOUT FILENAME (opposite of basename)
dirname "$TERM_LOGFILE"

##@@@ GET FILENAME FROM PATH
# https://www.cyberciti.biz/faq/bash-get-filename-from-given-path-on-linux-or-unix/
echo "${TERM_LOGFILE##*/}"  # Finds the longest match from beginning, so longest match of */ means everything until and including the last /
#**--or--**#
basename "$TERM_LOGFILE"
# https://www.cyberciti.biz/faq/bash-get-basename-of-filename-or-directory-name/
FILE="/home/vivek/lighttpd.tar.gz"
echo ${FILE##*/}
## another example ##
url="https://www.cyberciti.biz/files/mastering-vi-vim.pdf"
echo "${url##*/}"
#**--or--**#
# https://stackoverflow.com/questions/3362920/get-just-the-filename-from-a-path-in-a-bash-script
a=/tmp/file.txt
b=$(basename $a)
echo $b
file.txt






#@@ MANPAGE

##@@ show only entries that have duplicates
sort "list.txt" | uniq -d
  # example searches for manpage entries containing the word "set" and shows names of pages that exist in multiple sections (e.g. man)
  man -k "$1" | awk '{print $1;}' | sort | uniq -d
    # this example goes one further than the above example and displays the pages that exist in 
    man -k "" | awk '{print $1;}' | sort | uniq -d | xargs -I % man -f %
      # add newline after each page, separating the sections more visibly
      man -k "" | awk '{print $1;}' | sort | uniq -d | xargs -I % bash -c "man -f '%'; echo -e ''"
    # doesn't work: man -k "" | awk '{print $1;}' | sort | uniq -d | echo | echo | xargs -I % echo -e "$(man -f %)\n"
  # echo with % replaced by the stdout line - useful full building commands
  man -k "" | awk '{print $1;}' | sort | uniq -d | xargs -I % echo "%"
  man -k "" | awk '{print $1;}' | sort | uniq -d | xargs -I % echo "$(echo %)" # works :D
    man -k "" | awk '{print $1;}' | sort | uniq -d | xargs -I % echo "$(echo "__%__")" # surround lines with __

##@@@ Jump to manpage section
man --pager='less -p ^\ *ExecStart=' systemd.service
man --pager='less -p ^COMMAND LINES' systemd.service















#@@ From /config/archive/denver/shell_common.sh @@# ----------------------------

set_dotglob() {
  # TODO: take a second argument to `set_dotglob()` that is an array of options to set.  This would be used to set `myresult` and the last line of the function that enables those specific extensions
  if [ -z "$1" ]; then echo "No variable passed.  A variable must be specified to record the old value in."; return 1; fi
  if [[ $1 == "--help" || $1 == "-h" || $1 == "help" ]]; then echo -e "Make sure to pass in an unused/uninitialized variable name (aka an unquoted string [in bash])\n\$ ${FUNCNAME[0]} prev_dotglob\n#now dotglob is set\n\$prev_dotglob\n#now dotglob is returned to its previous value"; fi
  # Uses the techniques for returning values from a function specified in:
  #   https://www.linuxjournal.com/content/return-values-bash-functions
  local  __resultvar=$1
  local  myresult
  myresult=$(shopt -p dotglob globstar nullglob)
  eval $__resultvar="'$myresult'"
  shopt -s dotglob globstar nullglob
}
# set_dotglob PREV_DOTGLOB
# # ... # some code here that requires dotglob
# $PREV_DOTGLOB




# Get the name of the script that is executing
#   Note: when included with . or source, the return value
#   will not be `common.sh`, it will be the script that was
#   executed by the user on the command line.
function script_name() {
  echo $(basename "$0")
}

# Modified from: https://stackoverflow.com/a/14525326
is_array() {
  str="`declare -p $1 2>/dev/null`";if [[ "${str:0:10}" == 'declare -a' ]];then return 0; else return 1; fi
}

# Write a message to stderr instead of stdout
#   Modifed from https://stackoverflow.com/a/2990533 and https://stackoverflow.com/a/43814587
echoerr() { echo "$@" 1>&2; }
# --OR--
echoerr() { [ "$DEBUG_MODE" = true ] && printf '%b' "$*" >&2; }
  # Note: outputs all arguments passed to it.

# Check if a command exists
if command -v powerline-daemon &> /dev/null; then echo "powerline is installed"; fi

# DO NOT RUN WITH SUDO / AS ROOT
do_not_run_as_root () {
  if [[ $EUID -eq 0 ]]; then
      echo "This script must NOT run as root" 
      exit 1
  fi
}

# DO NOT RUN WITH SUDO / AS ROOT
must_be_root () {
  if [[ $EUID -ne 0 ]]; then
      echo "This script must NOT run as root" 
      exit 1
  fi
}

# FROM bash_functions.old.bash
function echo_stderr() {
  [[ -z "$1" ]] || echo -e "$1" >&2
}
function curdatetime() {
  date +"%F_%H-%M-%S"
}
function curdate() {
  date +"%F"
}
function curtime() {
  date +"%H-%M-%S"
}
function textdate() {
  date +"%A, %B %d, %Y"
  # Example:
  #   Sunday January 24 2021
}


# Check if a function has been declared and exists
# source:
# https://stackoverflow.com/questions/85880/determine-if-a-function-exists-in-bash
#   appended double quote is an ugly trick to make sure we do get a string -- if $1 is not a known command, type does not output anything
# https://stackoverflow.com/a/9002012
fn_exists() {
  # shellcheck disable=SC2046,SC2086
  [ x$(type -t $1) = xfunction ];
}

random_key () {
  if [[ -n "$1"  && "$1" == "-h"  || "$1" == "--help" ]]; then
    echo "Produce random string for use as a key/salt base."
    echo "  Note: length should be a multiple of 3 (or else will be padded)"
    echo "  Note: output will be GREATER than specified length, length only specifies number of bytes of output to produce, then it is Base64 encoded, which will add length (about 4 characters of output for every 3 bytes of length, assuming length is a multiple of 3 (which means no padding - extra characters will be added for padding if length is not multiple of 3)"
  fi
  local LENGTH
  if [ -z "$1" ]; then
    LENGTH=30
  fi
    printf -v LENGTH '%d' "$1" 2>/dev/null
    if [ "$LENGTH" -eq "0" ]; then
      echo "Incorrect length was specified.  Length must be 3 or greater." >&2
      return 2;
    fi
    if [ $(( LENGTH < 3 )) ]; then
      echo "The specified key length is not long enough." >&2
      return 3;
    fi
    #if [ "$LENGTH" -ne "0" ] && [ $(( $LENGTH >  )) ]; then
      #LENGTH=`shuf -i28-36 -n1`;
      openssl rand -base64 "$LENGTH"
    #fi
  
}

soft-kill () {
  if [ -n "$1" ]; then
    local pname=$1
    kill -SIGTERM "$(list-pids "$pname")"
  else
    echo "No process name specified"
  fi
}
hard-kill () {
  if [ -n "$1" ]; then
    local pname=$1
    kill -SIGKILL "$(list-pids "$pname")"
  else
    echo "No process name specified"
  fi
}

backup-apt () {
    local DATE
      DATE=$(date +%F)
    local DATE_FOLDER
      # DATE_FOLDER=~/backups/apt-clone/$DATE
      DATE_FOLDER="$MY_APT_BACKUP_DIR/$DATE"
    if [[ -d "$DATE_FOLDER" ]]; then 
      echo "Could not backup - folder already exists: $DATE_FOLDER"
      return
    fi
    mkdir -p "$DATE_FOLDER"
    sudo apt-clone clone "$DATE_FOLDER" --with-dpkg-repack --with-dpkg-status
}

# Copy only directory structure while preserving permissions/attributes
# source:
#   https://stackoverflow.com/a/9242883
#     http://psung.blogspot.com/2008/05/copying-directory-trees-with-rsync.html
#   also read:
#     https://www.cyberciti.biz/faq/unix-linux-bsdosx-copying-directory-structures-trees-rsync/
# 
# Parameters
#   $1  source, copy all directories within the specified source directory
#   $2  destination, copies directory structure from $1 into specified directory
# Usage
#   cp-dirs $source $destination
cp-dirs() {
  if [[ ! "$1" || ! -d "$1" ]]; then return 1; fi
  if [[ ! "$2" || ! -d "$2" ]]; then return 2; fi
  if [[ "$1" = "--help" || "$1" = "-h" || "$1" = "help" ]]; then
    echo "Uses rsync to copy directory structure within a specified directory (\$1) into another directory (\$2)"
    echo -e "\nUsage:"
    echo -e "\tcp-dirs $source $destination"
    return 0
  fi
  local SOURCE="$1"
  local DESTINATION="$2"
  rsync -a -f"+ */" -f"- *" source/ destination/
}
# Add some aliases for cp-dirs
alias copy-structure='cp-dirs'
alias copy-dirs='cp-dirs'


local-ips() {
  # Lakewood
  #   wlp4s0 for wireless
  #   enp5s0 for ethernet
  #   lo for loopback
  local INTERFACE="${1:-enp5s0}"
  if [[ "$INTERFACE" = "wifi" && "$HOSTNAME" = "lakewood" ]]; then
    INTERFACE="wlp4s0"
  elif [[ "$INTERFACE" = "wired" || "$INTERFACE" = "ethernet" || "$INTERFACE" = "eth" ]] && [[ "$HOSTNAME" = "lakewood" ]]; then
    INTERFACE="enp5s0"
  fi
  ifconfig "$INTERFACE" | grep "inet\|inet6" | awk -F' ' '{print $2}' | awk '{print $1}'
}

apt-list-installed () {
  if [ -n "$1" ]; then
    apt list -a --installed "*$1*"
  fi
}


list-pids () {
  if [ -n "$1" ]; then pgrep "$1" | tr '\n' ' '; echo ""; fi
}


mkcd () {
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


#>>>  man --pager='less -p ^COMMAND LINES' systemd.service
#   To allow spaces at the beginning use something like:
#     # open manpage on systemd services to the section describing the ExecStart option.  Without the "^\ *" it would just find the first mention of ExecStart= instead of the line where it is defined
#>>>  man --pager='less -p ^\ *ExecStart=' systemd.service
#->>    this will open up a manpage to the specified section
open_manpage_section() {
  if [[ ! "$1" ]]; then echoerr "No manpage specified"; return 1; fi
  if [[ ! "$2" ]]; then echoerr "No section specified"; return 2; fi
  local section="$1"
  local manpage="$2"
  local pager_regex="^\s*$1"
  man --pager="less -p '$pager_regex'" $2
}
open_manpage_keyword() {
  if [[ ! "$1" ]]; then echoerr "No manpage specified"; return 1; fi
  if [[ ! "$2" ]]; then echoerr "No section specified"; return 2; fi
  local section="$1"
  local manpage="$2"
  local pager_regex="$1"
  man --pager="less -p '$pager_regex'" $2
}


