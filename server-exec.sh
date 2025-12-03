#!/bin/bash

echo "$@"

podman exec vintagestory-server-container /bin/sh \
  ./server.sh "$@"
