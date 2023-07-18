#!/usr/bin/env bash

# limit to first match with: grep -m 1 

if [[ ! "$1" || ! -f "$1" ]]; then
  exit 1
fi



while read -r URL; do
  xdg-open "$URL"
done <<< "$(grep -P -m 1 -o 'https://([^\s]|(?<=\\)\s)*' "$1")"


