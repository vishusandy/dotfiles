#!/usr/bin/env bash

plex.sh >/dev/null 2>&1 || podman start plex
