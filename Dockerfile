FROM google/golang

RUN cd /usr/local/src && git clone http://github.com/coreos/rudder.git && \
    cd /usr/local/src/rudder && ./build

ADD ./busybox-rudder/Dockerfile /usr/local/src/rudder/Dockerfile

RUN docker build --rm --force-rm -t gurpartap/rudder /usr/local/src/rudder/

ADD ./script/ ./script/

CMD ["./script/release.sh"]
