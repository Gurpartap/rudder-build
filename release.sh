#!/bin/bash
# Usage: ./release [TAG]

set +e

echo " ---> Building..."
sh ./script/build.sh

echo " ---> Pushing gurpartap/rudder:${1:-latest}..."
sh ./script/push.sh $1

echo " ---> Cleaning up..."
sh ./script/clean.sh

echo " ---> Done."
