### Build and package rudder with busybox using Docker

Builds a [google/golang](https://registry.hub.docker.com/u/google/golang/) based image which builds [rudder](https://github.com/coreos/rudder) from source and then packages the built binary with [busybox](https://registry.hub.docker.com/_/busybox) base image.

Also serves as an example for docker within docker usage and shipping binaries with a minimal base image (busybox) after compiling in an intermediary image.

##### Build

```
docker build --rm --force-rm -t gurpartap/rudder-build .
docker run -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):$(which docker) -ti --name rudder-build gurpartap/rudder-build
```

##### Push

```
docker push gurpartap/rudder:latest

##### Clean

```
docker rm -f rudder-build
docker rmi -f gurpartap/rudder-build
docker rmi -f gurpartap/rudder
```

##### Usage

```
docker run -v /opt/bin:/opt/bin --rm cp /usr/local/bin/rudder /opt/bin/rudder
```

##### Provision Vagrant VM with rudder

```
config.vm.provision :docker do |docker|
  docker.run "gurpartap/rudder",
    args: "-v /opt/bin:/opt/bin --rm cp /usr/local/bin/rudder /opt/bin/rudder",
    auto_assign_name: false, daemonize: false
end
```

The busybox based rudder repo is available at https://registry.hub.docker.com/u/gurpartap/rudder.
