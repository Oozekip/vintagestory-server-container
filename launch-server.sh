#!/bin/bash

cleanup() {
  echo "Container stopping, performing cleanup..."
  ./server.sh stop
  echo "Done"
}

trap cleanup EXIT

./server.sh start

sleep infinity &
wait
