#!/bin/sh
docker build --rm --force-rm -t gurpartap/rudder-build .
docker run -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):$(which docker) -ti --name rudder-build gurpartap/rudder-build
