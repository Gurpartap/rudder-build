#!/bin/bash
# Usage: ./release [TAG]

set +e

echo "--------> Building..." && ./script/build.sh
echo "--------> Pushing gurpartap/rudder:${1:-latest}..." && ./script/push.sh $1
echo "--------> Cleaning up..." && ./script/clean.sh
echo "--------> Done."
