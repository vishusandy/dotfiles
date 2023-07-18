#!/usr/bin/env bash

plex_create.sh >/dev/null 2>&1 || podman start plex
