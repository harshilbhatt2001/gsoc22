---
layout: post
title:  "Weekly Progress Tracker"
date:   2022-09-19 15:32:14 +0530
categories: jekyll update
---
Hi, this is a weekly blog for my GSoC 2022 project [Greybus for Zephyr Updates ](https://elinux.org/BeagleBoard/GSoC/2022_Proposal/GreybusforZephyrUpdates). My mentors for this project are Jason Kridner, Vaishnav Achath, Deepak Khatri and Tim Orling. This thread will be updated weekly.

Introductory YouTube video: [https://youtu.be/GN82Yiq_kRg ](https://youtu.be/GN82Yiq_kRg)

## Week 1

#### Accomplishments

* Build Zephyr applications for BeagleConnect nodes on the Gateway device.
* Fixes for the updated bcf-sdk [[Pull #17]](https://github.com/jadonk/zephyr/pull/17)
* Setup connection between the native POSIX target and host

#### Blockers

* [Greybus cannot bind I2C device](https://git.beagleboard.org/gsoc/greybus-for-zephyr/-/issues/2)
* https://git.beagleboard.org/gsoc/greybus-for-zephyr/-/issues/3

#### Upcoming Targets

* Finish the introduction video
* Establish a TCP connection between the native POSIX target and host


## Week 2

#### Accomplishments

* Finished the introduction slides and scripts
* Patched the issue causing stack smashing on the native_POSIX target [[Commit 9fd1f60d]](https://git.beagleboard.org/gsoc/greybus-for-zephyr/-/commit/9fd1f60da38f0f3476428232cf90043b96abd64e)
* Setup a greybus application on the native_POSIX target communicating via UART [[Commit 34fdf305]](https://git.beagleboard.org/gsoc/greybus-for-zephyr/-/commit/34fdf30596ed7325dd53aedea7f8e11fd03645e5)

#### Blockers

* [Greybus cannot bind I2C device](https://git.beagleboard.org/gsoc/greybus-for-zephyr/-/issues/2)
* [A kernel panic happens if a network interface connected to the POSIX target is setup.](https://git.beagleboard.org/gsoc/greybus-for-zephyr/-/issues/3)

#### Upcoming Targets

* Interface PWM with zephyr from nuttx sources
* Establish a TCP connection between the native POSIX target and host


## Week 3

#### Accomplishments

* Finished the introduction video [YouTube](https://youtu.be/GN82Yiq_kRg)
* Fix for demo in BeagleConnect documentation [[PR #93]](https://github.com/jadonk/beagleconnect/pull/93)
* Fix CI to build an test greybus applications [[Commit 775e85db]](https://gsoc.beagleboard.io/greybus-for-zephyr/)
* Interface PWM from nuttx sources [[Branch pwm-wip]](https://git.beagleboard.org/gsoc/greybus-for-zephyr/-/tree/pwm-wip)

#### Blockers

* [Greybus cannot bind I2C device](https://git.beagleboard.org/gsoc/greybus-for-zephyr/-/issues/2)
* [A kernel panic happens if a network interface connected to the POSIX target is setup.](https://git.beagleboard.org/gsoc/greybus-for-zephyr/-/issues/3)
* [Cannot build greybus on CI](https://git.beagleboard.org/gsoc/greybus-for-zephyr/-/pipelines/370)

#### Upcoming Targets

* Test PWM over greybus
* Improve the testbench
* Interface PWM with zephyr from nuttx sources


## Week 4

#### Accomplishments

* Reorganize the code so it's easier to track.
* Started developing a host side testbench to generate greybus message instead of gbridge
* Interface UART from nuttx sources [[Branch uart-wip]](https://git.beagleboard.org/gsoc/greybus/greybus-for-zephyr/-/tree/uart-wip)

#### Blockers

* Inconsistent behaviour by the greybus-pwm firmware (crashes the host sometimes)
* Zephyr does not have api to generate UART break

#### Upcoming Targets

* Test PWM and UART over greybus
* Improve the testbench
* Interface GPIO IRQ with zephyr from nuttx sources


## Week 5

#### Accomplishments

* Fix CI, again...
* Started developing a host side testbench to generate greybus message instead of gbridge
* Complete port of UART from nuttx sources [[Branch uart-wip]](https://git.beagleboard.org/gsoc/greybus/greybus-for-zephyr/-/tree/uart-wip)

#### Blockers

* [ UART and PWM firmware cause USAGE FAULTS on zephyr and occasionally hang the host](https://git.beagleboard.org/gsoc/greybus-for-zephyr/-/issues/5)
* The "userspace gbridge" does not connect to the POSIX target

#### Upcoming Targets

* Test PWM and UART peripherals over greybus
* Connect to the POSIX target with a userspace testbench


## Week 6

#### Accomplishments

* Completed beagleconnect documentation for docs.beagleboard.io [[Merge #14]](https://git.beagleboard.org/docs/docs.beagleboard.io/-/merge_requests/14)
* I thought an incorrect devicetree overlay was causing [ Issue #5](https://git.beagleboard.org/gsoc/greybus-for-zephyr/-/issues/5), as the error is caused by passing a pointer to a non-static local variable to a state machine which changed the value at that memory location later on. However, this does not seem to fix the issue.
* Greybus core messages are being sent to the POSIX target

#### Blockers

* [ This issue now shows up even when PWM or UART are not configured.](https://git.beagleboard.org/gsoc/greybus-for-zephyr/-/issues/5) I am a little lost on how to debug this issue.
* POSIX target does not receive the messages over the pseudo-terminal. I am unsure about how the interfaces in gbridge work, upon figuring them out, I should be able to write greybus messages to a pseudo-terminal

#### Upcoming Targets

* Move the PWM and UART devices into the gb_bundle's private data
* Get core greybus messages working on the testbench

## Week 7

#### Accomplishments

* Narrowed down the cause of the major blocker [[Issue #5]](https://git.beagleboard.org/gsoc/greybus-for-zephyr/-/issues/5)

#### Blockers

* [ This issue now shows up even when PWM or UART are not configured.](https://git.beagleboard.org/gsoc/greybus-for-zephyr/-/issues/5) This seems to have risen from the recent rebase of zephyr to version 3.1.0. My understanding so far is that the zephyr target crashes when gbridge is run on the host. The kernel panic on the host probably occurs because of the errors on the zephyr side of things. The doubly-linked list seems to cause an imprecise bus error when initialized. This leads me to some sort of regression in the transport-tcpip.c.
* POSIX target does not receive the messages over the pseudo-terminal. I am unsure about how the interfaces in gbridge work, upon figuring them out, I should be able to write greybus messages to a pseudo-terminal

#### Upcoming Targets

* Thoroughly debug the transport-tcpip to figure out what has regressed
* Get core greybus messages working on the testbench

## Week 8

#### Accomplishments

* Updated zephyr to the latest version in hopes of fixing [ [Issue #5]](https://git.beagleboard.org/gsoc/greybus-for-zephyr/-/issues/5)
* Setup control and svc operations for the testbench

#### Blockers

* This issue still persists [[Issue #5]](https://git.beagleboard.org/gsoc/greybus-for-zephyr/-/issues/5). This has been reported earlier, and I applied their patches, but it hasn't solved my problem yet.
* Reading from the pty results in permission errors for the testbench

#### Upcoming Targets

* Thoroughly debug the transport-tcpip to figure out what has regressed
* Fix the uart-transport for the testbench
* Add peripheral support to the testbench

## Week 9

#### Accomplishments

* The latest zephyr update seemed to cause more issues than it fixed, so it was rolled back.
* Debugging the bcf target resulted in more information. The sendMessage function in the transport-tcpip does not return correctly.

#### Blockers

* This issue still persists [[Issue #5]](https://git.beagleboard.org/gsoc/greybus-for-zephyr/-/issues/5).
* Greybus message headers are read incorrectly on the testbench.

#### Upcoming Targets

* Figure out why sendMessage does not return correctly.
* Fix greybus message handling on the testbench.
* Add peripheral support to the testbench.

## Week 10

#### Accomplishments

* Built a minimal example for the bcf target using tcp, which did not show errors I have been facing.
* Build a simple application to read and write data from the pty, which shows the same error as my testbench
* Analyze the greybus transaction between host and zephyr using tcpdump

#### Blockers

* This issue still persists [[Issue #5]](https://git.beagleboard.org/gsoc/greybus-for-zephyr/-/issues/5).
* Reading data from the pty throws errno 14

#### Upcoming Targets

* Figure out why sendMessage does not return correctly.
* Fix greybus message handling on the testbench.
* Add peripheral support to the testbench.

## Week 11

#### Accomplishments

* Resolved [[Issue #2]](https://git.beagleboard.org/gsoc/greybus-for-zephyr/-/issues/2)
* UART and PWM now do not crash zephyr
* Fixed stack corruption of the net sample for a native posix target

#### Blockers

* Zephyr does not support interrupt-driver UART for native posix
* TCP on the native posix target causes a recursive spinlock

#### Upcoming Targets

* Finish mapping greybus with zephyr API for UART and PWM.
* Fix net sample for the zephyr posix target

## Week 12

No major updates due to mid-sem exams.

## Week 13

#### Accomplishments

* Mapping for UART platform completed
* Mapping for PWM platform completed
* Improved gbridge runtime visibility

#### Blockers

* UART event loop halts for the native POSIX target on gbridge
* The devicetree for cc13xx has missing features, which prevents testing of PWM
* The host crashes when an attempt to update the UART configuration is made

#### Upcoming Targets

* Figure out cause of UART crash on bcf
* Figure out why the event loop halts on the POSIX target

## Week 14

#### Accomplishments

* Add pwm to the native POSIX board on Zephyr

#### Blockers

* Device-tree error when trying to instantiate a pwm device on the POSIX board

#### Upcoming Targets

* Complete pwm for the POSIX board
* Test greybus messages on pwm POSIX.

## Week 15

#### Accomplishments

* Documentation for PWM and UART

#### Blockers

* Device-tree error when trying to instantiate a pwm device on the POSIX board

#### Upcoming Targets

* Complete pwm for the POSIX board
* Test greybus messages on pwm POSIX.