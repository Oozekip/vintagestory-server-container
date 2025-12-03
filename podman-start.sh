#!/bin/sh

podman run \
  -d \
  --replace \
  -p 42420:42420 \
  --name vintagestory-server-container \
  --userns=keep-id:uid=1001,gid=1001 \
  --volume /mnt/vintagestory/data:/var/vintagestory/data:Z \
  --stop-timeout=20 \
  --restart=always \
  oozekip/vintagestory-server:1.21.5
