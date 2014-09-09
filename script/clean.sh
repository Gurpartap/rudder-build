#!/bin/sh
# Usage: ./clean.sh

docker rm -f rudder-build 2> /dev/null
docker rmi -f gurpartap/rudder-build
docker rmi -f gurpartap/rudder
