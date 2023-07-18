#!/usr/bin/env bash

help() {
    cat <<EOD
A script to backup files

USAGE:
    backup [OPTIONS] DEST_FOLDER

OPTIONS:
    -q, --quiet     supress backup folder messages
                      this will turn off the summary (enable with -s)
    -r, --replace   transfer all files instead of only updated files
    -s, --summary   show summary (default)
    -S, --nosummary do not show summary
    -z              do not set default SELinux security context
    -Z, --selinux   set default SELinux security context
    -V, --verbose   enable verbose file copy output
    -h, --help      show this help message

ARGUMENTS:
    DEST_FOLDER      directory to store the backup in

If SELinux is enabled on your system then the -Z flag is assumed.
This can be disabled with the -z flag.  If SELinux is not enabled
then the -z flag is assumed.

By default files are copied only when newer than any existing files.
This can be overridden with -r, which will copy the file regardless.

EXAMPLE:
    # Example.sh
    # include the backup library
    . $(basename "$0")
    
    # Backup '\$HOME/.bashrc.d' to the 'home' folder in DEST_FOLDER
    backup "\$HOME" "home" .bashrc.d
    
    # Backup '/some/path' in to the 'path' folder in DEST_FOLDER
    backup "/some/path" "" important
    
    
    # Terminal
    # Run backup script and backup everything up in "/somewhere/My Backups"
    Example.sh "/somewhere/My Backups"

EOD
    exit
}

# Tricky inputs (base dirs and absolute paths)
# backup "$HOME" "home" "/ares/data/popular baby names 2005.csv"
# backup "/ares/tmp2"
# backup "/ares/tmp3/tmp3.1"
# backup "/ares/tmp/"
# backup "/ares/tmp"
# backup "/ares"
# backup "$HOME" "home" /home/andrew/Documents

if [[ "$#" -eq 0 ]]; then
    help
fi

quiet=false
update=true
verbose=false
summary=true
selinux=false

if [[ "$(getenforce 2>/dev/null)" == "Enforcing" ]]; then
    selinux=true
fi

# https://stackoverflow.com/questions/11742996/is-mixing-getopts-with-positional-parameters-possible
script_args=()
while [ $OPTIND -le "$#" ]; do
    if getopts :hqrsSVzZ-: option; then
        case $option in
        h) help ;;
        q) quiet=true ;;
        r) update=false ;;
        s) summary=true ;;
        S) summary=false ;;
        Z) selinux=true ;;
        z) selinux=false ;;
        V) verbose=true ;;
        -)
            case $OPTARG in
            help) help ;;
            quiet) quiet=true ;;
            replace) update=false ;;
            selinux) selinux=true ;;
            summary) summary=true ;;
            nosummary) summary=false ;;
            verbose) verbose=true ;;
            *)
                echo "Invalid option '$OPTARG'" >&2
                help
                ;;
            esac
            ;;
        esac
    else
        script_args+=("${!OPTIND}")
        ((OPTIND++))
    fi
done

# If not running as root ask for admin privileges
if [[ $EUID -eq 0 ]]; then
    sudo -v || exit 1
fi

num_args="${#script_args[*]}"

if [[ "$num_args" -eq 0 ]]; then
    echo "No backup destination was specified" >&2
    help
elif [[ "$num_args" -gt 1 ]]; then
    echo "Too many arguments" >&2
    help
fi

cp_opts="a"
if [[ $selinux == true ]]; then cp_opts+="Z"; fi
if [[ $update == true ]]; then cp_opts+="u"; fi
if [[ $verbose == true ]]; then cp_opts+="v"; fi

BACKUP_BASE="${script_args[0]}"

if [[ "$BACKUP_BASE" == "" || ! -d "$BACKUP_BASE" ]]; then
    echo "Invalid backup destination" >&2
    exit 1
fi

# strip trailing backslash from BACKUP_BASE
if [[ "${BACKUP_BASE: -1}" == "/" ]]; then
    BACKUP_BASE="${BACKUP_BASE%/}"
fi

successes=$((0))
failed=$((0))
warnings=$((0))

fail_inc() {
    ((failed += 1))
}

warn_inc() {
    ((warnings += 1))
}

success_inc() {
    ((successes += 1))
}

# Ensure all directory ancestors exist in the backup destination
#
# $1    local base
# $2    backup base folder
# $3    file without local base
ancestor_check() {
    in_dir=$1
    out_dir=$2
    file=$3

    basename="$(basename "$file")"

    if [[ "$file" == "$basename" ]]; then return 0; fi

    len="${#basename}"
    basepath="${file:0:-$len-1}"

    if [[ "$basepath" = "" || "$basepath" = "/" ]]; then return 0; fi

    if [[ -d "$in_dir/$basepath" ]]; then
        mkdir -p "$BACKUP_BASE/$out_dir/$basepath"
    else
        echo "Failed: ancestor check failed: the path '$in_dir/$basepath' does not exist or is not a directory" >&2
        return 20
    fi
}

# $1    local base
# $2    backup base folder
# $3    file without local base
backup() {
    in_dir=$1
    out_dir=$2
    file=$3

    # ensure local source directory exists
    if [[ ! -d "$in_dir" ]]; then
        echo "Failed: invalid source directory '$in_dir'" >&2
        fail_inc && return 11
    fi

    if [[ "$BACKUP_BASE/" == "$in_dir"* ]]; then
        echo "Failed: input dir '$in_dir' is inside of backup dir '$BACKUP_BASE'" >&2
        fail_inc && return 12
    fi

    if [ "${out_dir:0:1}" = "/" ]; then
        echo "Failed: output dir cannot be an absolute path.  Output dir: '$out_dir'" >&2
        fail_inc && return 13
    fi

    mkdir -p "$BACKUP_BASE/$out_dir"

    # shellcheck disable=SC2088
    if [ "$file" = "" ]; then
        file="/"
    elif [ "${file:0:2}" == "~/" ]; then
        file="${HOME}${file:1}"
    elif [ "${file:0:1}" != "/" ]; then
        file="/$file"
    elif [[ "$file" = "$in_dir"* ]]; then
        file="${file#"$in_dir"}"
        if [ "${file:0:1}" != "/" ]; then
            file="/$file"
        fi
    elif [ "$file" != "/" ]; then
        echo "Failed: file '$file' is outside of the parent directory '$in_dir'" >&2
        fail_inc && return 14
    fi

    if [ -d "$in_dir$file" ]; then
        cp_opts+="r"
    elif [ ! -f "$in_dir$file" ]; then
        echo "in_dir=$in_dir file=$file"
        echo "Failed: invalid target: $in_dir$file" >&2
        fail_inc && return 10
    fi

    if [[ $quiet == false ]]; then
        echo "Backing up '$in_dir$file' to '$BACKUP_BASE/$out_dir$file'"
    fi

    if ! ancestor_check "$in_dir" "$out_dir" "$file"; then
        fail_inc && return $?
    fi

    if ! cp "-$cp_opts" "$in_dir$file" "$BACKUP_BASE/$out_dir$file"; then
        fail_inc && return 1
    fi

    success_inc
}

summary() {
    if [[ $summary == false ]]; then return; fi

    echo ""
    if [[ $failed == 0 ]]; then
        if [[ $successes == 0 ]]; then
            echo "No transfers were made"
        else
            echo "$successes transfers succeeded"
        fi
    else
        echo "Processed $((successes + failed)) transfers"
        echo "transerred: $successes"
        echo "failures: $failed"
    fi

    if [[ $warnings != 0 ]]; then
        echo "warnings: $warnings"
    fi
}

interrupted() {
    echo ""
    echo "TRANSER CANCELLED BY USER" >&2
    exit 1
}

trap interrupted SIGINT

if [[ $summary == true ]]; then
    trap summary EXIT
fi
