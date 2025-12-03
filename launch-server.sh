#!/bin/bash

cleanup() {
  echo "Container stopped, performing cleanup..."
  ./server.sh stop
}

# Trap SIGTERM
trap 'true' SIGTERM

# Handle Ctrl-C in case of non-detached mode
trap 'true' SIGINT

# Start the server
./server.sh start

sleep infinity &

wait
cleanup
