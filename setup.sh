#!/bin/bash -e -x

# Use Robert's repo to get newer cmake
apt update
apt install -y gpg apt-utils wget
wget -c https://debian.beagle.cc/arm64/pool/main/b/bbb.io-keyring/bbb.io-keyring_1.20220421.0-0~bullseye+20220421_all.deb
dpkg -i bbb.io-keyring_1.20220421.0-0~bullseye+20220421_all.deb
echo "deb [arch=arm64 signed-by=/usr/share/keyrings/rcn-ee-archive-keyring.gpg] http://debian.beagleboard.org/arm64/ bullseye main" >> /etc/apt/sources.list

# Do setup as recommended at https://git.beagleboard.org/beagleboard/beagleconnect
apt update
apt install -y \
 beagleconnect beagleconnect-msp430 \
 git vim \
 build-essential \
 cmake ninja-build gperf \
 ccache dfu-util device-tree-compiler \
 make gcc libsdl2-dev \
 libxml2-dev libxslt-dev libssl-dev libjpeg62-turbo-dev \
 gcc-arm-none-eabi libnewlib-arm-none-eabi \
 libtool-bin pkg-config autoconf automake libusb-1.0-0-dev \
 python3-dev python3-pip python3-setuptools python3-tk python3-wheel
pip3 install -U west


