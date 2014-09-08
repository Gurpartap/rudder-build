#!/bin/sh
docker build --rm --force-rm -t gurpartap/rudder-build .
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
                -v $(which docker):/usr/local/bin/docker \
                -ti --name rudder-build gurpartap/rudder-build
