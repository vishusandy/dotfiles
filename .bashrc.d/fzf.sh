#!/usr/bin/env bash

# https://github.com/junegunn/fzf#installation
# https://github.com/junegunn/fzf/wiki
# https://github.com/junegunn/fzf/wiki/examples
# https://opensource.com/article/20/10/shell-history-loki-fzf
# https://medium.com/@ankurloriya/fzf-command-make-your-history-command-smarter-3294dfd1272f
# https://nickjanetakis.com/blog/fuzzy-search-your-bash-history-in-style-with-fzf

if shopt -q login_shell; then # In a login shell, so return/exit
    return
elif [[ ! $- == *i* ]]; then # In a non-interactive shell, so return/exit
    return
fi

# shellcheck source=/home/andrew/.fzf.bash
if [ -f ~/.fzf.bash ]; then
    . /usr/share/fzf/shell/key-bindings.bash
    source ~/.fzf.bash
fi

