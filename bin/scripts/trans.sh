#!/usr/bin/env bash

sudo podman run --cap-add=NET_ADMIN -d \
    --name trans \
    -h transmission \
    -v /ares/apps/transmission/data:/data:Z \
    -v /ares/media/completed:/data/completed:Z \
    -v /ares/media/movies:/data/movies:Z \
    -v /ares/media/tv:/data/tv:Z \
    -v /ares/media/in-progress:/data/in-progress:Z \
    -v /ares/apps/transmission/config:/config:Z \
    -e CREATE_TUN_DEVICE=false \
    --device=/dev/net/tun:/dev/net/tun \
    -e OPENVPN_PROVIDER=PIA \
    -e OPENVPN_CONFIG=ca_ontario \
    --env-file /home/andrew/bin/env/pia.env \
    -e LOCAL_NETWORK=192.168.1.0/24 \
    -e TRANSMISSION_SPEED_LIMIT_DOWN=40000 \
    -e TRANSMISSION_SPEED_LIMIT_DOWN_ENABLED=true \
    -e TRANSMISSION_SPEED_LIMIT_UP=10000 \
    -e TRANSMISSION_SPEED_LIMIT_UP_ENABLED=true \
    -e TRANSMISSION_DOWNLOAD_QUEUE_SIZE=7 \
    -e TRANSMISSION_INCOMPLETE_DIR_ENABLED=true \
    -e TRANSMISSION_DOWNLOAD_DIR=/data/completed \
    -e TRANSMISSION_INCOMPLETE_DIR=/data/in-progress \
    -e TRANSMISSION_RATIO_LIMIT_ENABLED=true \
    -e TRANSMISSION_RATIO_LIMIT=20 \
    -e PUID=1000 \
    -e PGID=1000 \
    --log-driver json-file \
    --log-opt max-size=10m \
    -p 9091:9091 \
    docker.io/haugene/transmission-openvpn:latest
# localhost/transmission-custom

# -e TRANSMISSION_WEB_UI=combustion \
