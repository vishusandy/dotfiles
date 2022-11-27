#!/usr/bin/env bash

#.bashrc

# Be explicit about what is enabled and disabled
# disabled options:
shopt -u assoc_expand_once cdable_vars checkhash checkjobs compat31 compat32 compat40 compat41 compat42 compat43 compat44 direxpand execfail extdebug failglob gnu_errfmt histreedit histverify hostcomplete huponexit inherit_errexit lastpipe localvar_inherit localvar_unset login_shell mailwarn no_empty_cmd_completion nocasematch restricted_shell shift_verbose
# enabled options:
shopt -s autocd cdspell checkwinsize cmdhist complete_fullquote dirspell dotglob expand_aliases extglob extquote force_fignore globasciiranges globstar histappend interactive_comments lithist nocaseglob nullglob progcomp progcomp_alias promptvars sourcepath xpg_echo

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
#shellcheck disable=2076  #not checking against a regular expression so this is fine
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    # Include variables first so they can be used in other includes
    if [ -d ~/.bashrc.d/vars ]; then
        for rc in ~/.bashrc.d/vars/*.sh; do
            if [ -f "$rc" ]; then
                # shellcheck disable=SC1090
                . "$rc"
            fi
        done
        unset rc
    fi

    # General includes
    for rc in ~/.bashrc.d/*.sh; do
        if [ -f "$rc" ]; then
            #shellcheck disable=SC1090
            . "$rc"
        fi
    done
    unset rc
fi

# ------------------------------------------------------------------------------
# The rest of this file should only be used in an interactive terminal
# ------------------------------------------------------------------------------
# if ! shopt -q login_shell ; then # We're not a login shell
if shopt -q login_shell; then # In a login shell, so return/exit
    # echo 'Login shell, exiting .bashrc'
    return
elif [[ ! $- == *i* ]]; then # In a non-interactive shell, so return/exit
    # echo 'Non-interactive shell, exiting .bashrc'
    return
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
    #shellcheck disable=2015  #not my code, was from an ubuntu .bashrc
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# Cargo
#if [[ -f "$HOME/.cargo/env" ]]; then
#    . "$HOME/.cargo/env"
#fi

# eval "$(starship init bash)"

# . /usr/share/fzf/shell/key-bindings.bash

