#!/usr/bin/env bash

# podman run -d --rm \
podman run -d \
    --name plex \
    -p 32400:32400/tcp \
    -p 1900:1900/udp \
    -p 32410:32410/udp \
    -p 32412:32412/udp \
    -p 32413:32413/udp \
    -p 32414:32414/udp \
    -p 32469:32469/tcp \
    -e TZ="America/Chicago" \
    -e PLEX_CLAIM="claim-VgZssiFHtcBDcdF3gnze" \
    -h plex \
    -v /home/andrew/apps/containers/plex/config:/config:Z \
    -v /ares/apps/plex/transcode:/transcode:Z \
    -v /ares/media:/data:Z \
    plexinc/pms-docker:latest
