#!/usr/bin/env bash

alias aes-encrypt="aes_encrypt"
alias aes-decrypt="aes_decrypt"

function aes_encrypt() {
    printf '%s\n' "$1" | openssl aes-256-cbc -a -e -pbkdf2
}
function aes_decrypt() {
    printf '%s\n' "$1" | openssl aes-256-cbc -a -d -pbkdf2
}

alias aes-b64="aes256base64"
alias aes-binary="aes256"
alias aes-text="aes256base64"

# Use md5sum but remove the tailing - that indicates the source as stdin
hash_md5() {
    if [ -n "$1" ]; then
        local str=$1
        echo -n "$str" | md5sum | cut -d' ' -f1
    else
        echo "No input string specified"
    fi
}

# Use sha256sum but remove the tailing - that indicates the source as stdin
hash_sha256() {
    if [ -n "$1" ]; then
        local str=$1
        echo -n "$str" | sha256sum | cut -d' ' -f1
    else
        echo "No input string specified"
    fi
}

# Use sha512sum but remove the tailing - that indicates the source as stdin
hash_sha512() {
    if [ -n "$1" ]; then
        local str=$1
        echo -n "$str" | sha512sum | cut -d' ' -f1
    else
        echo "No input string specified"
    fi
}

# Use b2sum but remove the tailing - that indicates the source as stdin
hash_blake() {
    if [ -n "$1" ]; then
        local str=$1
        echo -n "$str" | b2sum | cut -d' ' -f1
    else
        echo "No input string specified"
    fi
}

# use aes256base64 for AES encryption/decryption using base64 to encode the binary input/output
#
# mode is set to encrypt by default, use -d to decrypt
aes256base64() {
    local decodeMe=""
    local isPipe
    isPipe="$([ ! -t 0 ] && echo \"true\" || echo \"false\")"

    if [ "$1" = '-d' ] || [ "$1" = '--decode' ]; then
        decodeMe="-d"
        shift
    fi

    if [ "$isPipe" = "true" ]; then
        read -r input
        printf '%s\n' "$input" | openssl aes-256-cbc -a $decodeMe
        exitCode="$?"
    else
        openssl aes-256-cbc -a $decodeMe -in "$*"
        exitCode="$?"
    fi

    unset isPipe decodeMe input
    return "$exitCode"
}

# aes256 encrypts/decrypts producing binary output
#
# mode is set to encrypt by default, use -d to decrypt
aes256() {
    local decodeMe=""
    local isPipe
    isPipe="$([ ! -t 0 ] && echo \"true\" || echo \"false\")"

    if [ "$1" = '-d' ] || [ "$1" = '--decode' ]; then
        decodeMe="-d"
        shift
    fi

    if [ "$isPipe" = "true" ]; then
        read -r input
        printf '%s\n' "$input" | openssl aes-256-cbc $decodeMe
        exitCode="$?"
    else
        openssl aes-256-cbc $decodeMe -in "$*"
        exitCode="$?"
    fi

    unset isPipe decodeMe input
    return "$exitCode"
}

# random_key BYTES_TO_PRODUCE
random_key_bytes() {
    if [[ -n "$1" && "$1" == "-h" || "$1" == "--help" ]]; then
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
        return 2
    fi
    if [ $((LENGTH < 3)) ]; then
        echo "The specified key length is not long enough." >&2
        return 3
    fi
    #if [ "$LENGTH" -ne "0" ] && [ $(( $LENGTH >  )) ]; then
    #LENGTH=`shuf -i28-36 -n1`;
    openssl rand -base64 "$LENGTH"
    #fi

}
