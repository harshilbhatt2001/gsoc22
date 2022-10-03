---
layout: post
title:  "Native POSIX execution with Greybus"
date:   2022-09-26 16:58:14 +0530
categories: jekyll update
---
In this post, we discuss native POSIX execution of Greybus sample applications.
We use the UART transport for Greybus message exchange. 

## Build and Run the native POSIX application

Build the Greybus sample in `samples/subsys/greybus/uart` directory. 

``` 
$ west build -b native_posix -d build/greybus/uart modules/lib/greybus/samples/subsys/greybus/uart
```

The application can be run as

```
$ ./build/greybus/uart/zephyr/zephyr.exe
```

## Greybus Message Transactions

### Manual

The POSIX application creates a pseudo-terminal which is the transport for Greybus messages. We can use the pseudo-terminal to communicate with the POSIX application in the following way.

```python
>>> import serial
>>> packet = bytearray([8,0,0,0,0,0,0,0])
>>> ser = serial.Serial('/dev/pts/0', 115200)
>>> print("writing greybus dummy ping packet")
writing greybus dummy ping packet
>>> ser.write(packet)
8
>>> print(packet)
bytearray(b'\x08\x00\x00\x00\x00\x00\x00\x00')
>>> print("check ping response")
check ping response
>>> resp = ser.read(8)
>>> print(resp)
b'\x08\x00\x00\x00\x80\x00\x00\x00'
>>> print("greybus response ping success ^")
greybus response ping success ^
>>> 
```

### Gbridge

Another way is to use `gbridge` in order to communicate with the POSIX application

1. Build `gbridge` with uart 
```bash
cd gbridge
autoconf
automake --add-missing
./configure --enable-netlink --enable-tcpip --enable-uart
make
```

2. Pass the pseudo-terminal created by the POSIX application to gbridge via the cli
```bash
./gbridge -p /dev/pts/X
```


## Native POSIX PWM

This driver is currently under development [here](https://git.beagleboard.org/gsoc/greybus/zephyr/-/tree/pwm_posix_wip).
This will take a `phandle-array` of gpios and add pwm output capabilities to them.  
At the moment, build errors need to be fixed due to faulty initialization of the posix board.
