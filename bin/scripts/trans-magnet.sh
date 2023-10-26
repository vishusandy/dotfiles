#!/usr/bin/env bash

# https://gist.github.com/electrofink/f431dc78f4aa9c255044

set -euo pipefail

### Configuration ###

# Address and port of the transmission web interface
URL="http://server:9091"
# Location where to store the download
DLDIR="/storage/Downloads"


RPCURL="$URL/transmission/rpc"
TYPE="Content-Type: application/json"
SESSION=$(curl -s -I "$RPCURL" | grep "X-Transmission-Session-Id" | tr -d '\r')

curl -H "X-Requested-With: XMLHttpRequest" -H "$SESSION" -H "$TYPE" -X POST -d '{"method": "torrent-add", "arguments": {"paused":"false", "filename":"'"$1"'"}}' "$RPCURL"


