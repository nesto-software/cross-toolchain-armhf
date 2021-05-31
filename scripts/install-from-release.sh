#!/bin/bash
set -e

TOOLCHAIN=arm-unknown-linux-gnueabi
TOOLCHAIN_PATH=/opt/crosstool-ng/x-tools/${TOOLCHAIN}/bin
DOWNLOAD_LOCATION=/tmp/crosstool-ng-armhf.tar.xz

# only prepare, download and install if not already available
if [ ! -d "/opt/crosstool-ng/x-tools/${TOOLCHAIN}" ]; then

    sudo apt-get -qq install -y curl wget xz-utils tar > /dev/null

    sudo mkdir -p /opt/crosstool-ng/x-tools/

    curl -s https://api.github.com/repos/nesto-software/cross-toolchain-armhf/releases/latest \
        | grep "/crosstool-ng-armhf.tar.xz" \
        | cut -d : -f 2,3 \
        | tr -d \" \
        | wget -qi - -O "$DOWNLOAD_LOCATION"

    sudo tar xf "$DOWNLOAD_LOCATION" -C /opt/crosstool-ng/x-tools/
fi

# let the caller source the toolchain
echo "export TOOLCHAIN=${TOOLCHAIN};export TOOLCHAIN_PATH=${TOOLCHAIN_PATH};export PATH=${TOOLCHAIN_PATH}:${PATH}"