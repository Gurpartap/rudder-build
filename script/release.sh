#!/bin/bash
# Usage: ./release.sh [TAG]

set +e

echo " ---> Building..."
sh ./build.sh

echo " ---> Pushing gurpartap/rudder:${1:-latest}..."
sh ./push.sh $1

echo " ---> Cleaning up..."
sh ./clean.sh

echo " ---> Done."
