FROM ubuntu:trusty

MAINTAINER Veedubin <veedubin@comcast.net>

# Install transmission-daemon package
RUN apt-get update -y && \
    apt-get install -y transmission-daemon && \
    rm -rf /var/lib/apt/lists/*

ADD settings.json /data/transmission/settings.json

VOLUME ["/data/transmission/downloads"]
VOLUME ["/data/transmission/torrents"]
VOLUME ["/data/transmission/resume"]

RUN chown -R debian-transmission:debian-transmission /data/transmission

USER debian-transmission

EXPOSE 9091 51413/tcp 51413/udp

ENTRYPOINT ["transmission-daemon", "--foreground", "--config-dir", "/data/transmission", "--log-error"]
