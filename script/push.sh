#!/bin/sh
# Usage: ./push.sh [TAG]

docker push gurpartap/rudder:${1:-latest}
