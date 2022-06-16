#!/bin/bash -ex
mkdir -p /opt/source
export PATH=/opt/source/bcf-zephyr/zephyr/scripts:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$HOME/.local/bin

echo "Installing zephyr"
cd /opt/source/
echo "west init -m <repo> --mr <tag> bcf-zephyr"
west init -m https://github.com/harshilbhatt2001/zephyr-jadonk.git --mr bcf-sdk-3-1-0-rebase bcf-zephyr

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
