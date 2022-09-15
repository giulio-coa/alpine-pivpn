FROM alpine:latest

# OpenRC pre-requisites
VOLUME [ "/sys/fs/cgroup" ]

RUN mkdir -p /run/openrc \
	&& touch /run/openrc/softlevel

# Update the repositories and the packages
RUN apk -q update; \
	apk -q upgrade --prune

# Install pre-requisites
RUN apk -q --no-cache add bash busybox-initscripts curl sudo; \
	echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel \
	&& chown root:root /etc/sudoers.d/wheel

# Install Pi-VPN
RUN curl -L https://install.pivpn.io \
	| bash

EXPOSE 1194/udp

CMD ["/bin/bash"]
