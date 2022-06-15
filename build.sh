#!/bin/bash -ex
mkdir -p /opt/source
export PATH=/opt/source/bcf-zephyr/zephyr/scripts:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$HOME/.local/bin

echo "Installing zephyr"
cd /opt/source/
echo "west init -m <repo> --mr <tag> bcf-zephyr"
west init -m git@github.com:harshilbhatt2001/zephyr-jadonk.git --mr f1aa25c58c27392b20a3a8a8eb2f4e245abf04a4 bcf-zephyr

cd /opt/source/bcf-zephyr/
echo "west update"
west update
echo "west zephyr-export"
west zephyr-export
echo "pip3 install -r zephyr/scripts/requirements-base.txt"
pip3 install -r zephyr/scripts/requirements-base.txt

export ZEPHYR_TOOLCHAIN_VAIRANT=cross-compile
export CROSS_COMPILE=/usr/bin/arm-none-eabi-
export ZEPHYR_BASE=/opt/source/bcf-zephyr/zephyr
export BOARD=beagleconnect_freedom

# Build a demo here
west build -d build/blinky zephyr/samples/basic/blinky
