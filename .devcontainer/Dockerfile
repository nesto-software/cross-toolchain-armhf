# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.177.0/containers/debian/.devcontainer/base.Dockerfile

ARG VARIANT="buster"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}
LABEL org.opencontainers.image.source https://github.com/nesto-software/cross-toolchain-armhf

WORKDIR	/root

# Install dependencies.
RUN	apt-get update && DEBIAN_FRONTEND=noninteractive\
	apt-get install -y build-essential gperf bison flex texinfo wget gawk libtool automake libncurses5-dev help2man\
		ca-certificates unzip libtool-bin libtool-doc

# Download and compile crosstool-NG.
RUN	wget http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-1.24.0.tar.xz 2>&1 &&\
	tar xf crosstool-ng-*.tar* &&\
	cd crosstool-ng-1.24.0 &&\
	./configure && make && make install &&\
	rm -rf ../crosstool-ng*

# Internal wiring.
RUN	mkdir crosstool-NG /etc/crosstool-ng &&\
	ln -s /root/crosstool-NG/.config /etc/crosstool-ng/crosstool-ng.conf

# Install dependencies needed by linux kernel
RUN apt-get install -y git rsync

COPY	in/toolchain-build	/usr/local/bin/
COPY	in/crosstool-configure	/usr/local/bin/
COPY	in/crosstool-upgradeconfig	/usr/local/bin/
COPY	in/crosstool-ng.conf	/root/crosstool-NG/.config
COPY	in/uclibc.conf		/root/uClibc/.config
