### Build and package rudder with busybox using Docker

Builds a [google/golang](https://registry.hub.docker.com/u/google/golang/) based image which builds [rudder](https://github.com/coreos/rudder) from source and then packages the built binary with [busybox](https://registry.hub.docker.com/_/busybox) base image.

Also serves as an example for docker within docker usage and shipping binaries with a minimal base image (busybox) after compiling in an intermediary image.

The busybox based rudder repo is available at https://registry.hub.docker.com/u/gurpartap/rudder.

##### Building and releasing

```
$ cat ./script/build.sh
docker build --rm --force-rm -t gurpartap/rudder-build .
docker run -v /var/run/docker.sock:/var/run/docker.sock \
           -v $(which docker):/usr/local/bin/docker \
           -ti --name rudder-build gurpartap/rudder-build
```

```
$ cat ./script/push.sh
docker push gurpartap/rudder:latest
```

```
$ cat ./script/clean.sh
docker rm -f rudder-build
docker rmi -f gurpartap/rudder-build
docker rmi -f gurpartap/rudder
```

```
$ ./release.sh # will run them all.
```

##### Running with docker

```
docker run gurpartap/rudder
```

##### Copying the binary

```
# Mount host's /usr/local/bin directory in the container and copy rudder over.
docker run --rm -v /usr/local/bin:/volumes/host/bin gurpartap/rudder \
  cp /usr/local/bin/rudder /volumes/host/bin/rudder
```

##### Provision rudder on CoreOS, etc. using Vagrant

```
config.vm.provision :docker do |docker|
  docker.run "gurpartap/rudder",
    args: "--rm -v /usr/local/bin:/volumes/host/bin \
           cp /usr/local/bin/rudder /volumes/host/bin/rudder",
    auto_assign_name: false, daemonize: false
end
```

If you have any feedback, please [contact me](http://gurpartap.com/).
