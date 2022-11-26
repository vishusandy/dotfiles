#!/usr/bin/env bash

echoerr() { [[ ! "$HIDE_ERRORS" || "$HIDE_ERRORS" = "false" ]] && printf '%b' "$*" >&2; }

import-model() {
    local prev_dir="$PWD"
    local model_folder
    if [[ -n "$1" && -d "$1" ]]; then
        model_folder="$1"
    else
        model_folder="$PWD"
    fi
    # if [[ -n "$CSS_MODELS_DIR" || ! -d "$CSS_MODELS_DIR" || -n "$CSS_MODELS_BZ2_DIR" || ! -d "$CSS_MODELS_BZ2_DIR" ]]; then
    if [[ "$CSS_MODELS_DIR" == "" || ! -d "$CSS_MODELS_DIR" ]]; then
        echoerr "No CSS_MODELS_DIR or CSS_MODELS_BZ2_DIR variable set\n"
        return
    fi
    if [[ ! -d "$model_folder/materials/models/player" || ! -d "$model_folder/models/player" ]]; then
        echoerr "Invalid directory structure for $model_folder - must have materials/models/player/ and /models/player/ folders\n"
        return
    fi
    echo "running rsync src=$model_folder dest=$CSS_MODELS_DIR"
    rsync -rv "$model_folder/" "$CSS_MODELS_DIR"
    rsync -r "$model_folder/" "$CSS_MODELS_BZ2_DIR"

    find "$CSS_MODELS_DIR" -type f -print >"$CSS_MODELS_DIR/files.txt"

    cd "$CSS_MODELS_BZ2_DIR" || return
    find . -type f ! -name "*.bz2" -print0 | xargs -0 -n1 -P4 bzip2
    find . -type f ! -name "*.bz2" -exec rm -rf {} \;
    cd "$prev_dir" || return

}
