### Build and package rudder with busybox using Docker

Builds a [google/golang](https://registry.hub.docker.com/u/google/golang/) based image which builds [rudder](https://github.com/coreos/rudder) from source and then packages the built binary with [busybox](https://registry.hub.docker.com/_/busybox) base image.

Also serves as an example for docker within docker usage and shipping binaries with a minimal base image (busybox) after compiling in an intermediary image.

The busybox based rudder repo is available at https://registry.hub.docker.com/u/gurpartap/rudder.

##### Building and releasing

```bash
$ cat ./script/build.sh
docker build --rm --force-rm -t gurpartap/rudder-build .
docker run -v /var/run/docker.sock:/var/run/docker.sock \
           -v $(which docker):/usr/local/bin/docker \
           -ti --name rudder-build gurpartap/rudder-build
```

```bash
$ cat ./script/push.sh
docker push gurpartap/rudder:latest
```

```bash
$ cat ./script/clean.sh
docker rm -f rudder-build
docker rmi -f gurpartap/rudder-build
docker rmi -f gurpartap/rudder
```

```bash
$ ./release.sh # will run them all.
```

##### Copying the binary to host

```bash
# Mount host's /usr/local/bin directory in the container and copy rudder over.
docker run --rm -v /opt/bin:/opt/bin gurpartap/rudder
```

##### Provision rudder on CoreOS, etc. using Vagrant

```ruby
config.vm.provision :docker do |docker|
  docker.run "gurpartap/rudder",
    args: "--rm -v /opt/bin:/opt/bin",
    auto_assign_name: false, daemonize: false
end
```

If you have any feedback, please [contact me](http://gurpartap.com/).
