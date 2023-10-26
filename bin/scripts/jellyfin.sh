#!/usr/bin/env bash

podman run \
    --detach \
    --label "io.containers.autoupdate=registry" \
    --name jelly \
    --publish 8096:8096/tcp \
    --user $(id -u):$(id -g) \
    --userns keep-id \
    --volume /ares/apps/jellyfin/cache:/cache:Z \
    --volume /ares/apps/jellyfin/config:/config:Z \
    --mount type=bind,source=/ares/media/tv,destination=/media/tv,ro=true,relabel=shared \
    --mount type=bind,source=/ares/media/movies,destination=/media/movies,ro=true,relabel=shared \
    --mount type=bind,source=/ares/photos,destination=/media/photos,ro=true,relabel=shared \
    --mount type=bind,source=/ares/media/music/library,destination=/media/music,ro=true,relabel=shared \
    --mount type=bind,source=/ares/books,destination=/media/books,ro=true,relabel=shared \
    docker.io/jellyfin/jellyfin:latest
