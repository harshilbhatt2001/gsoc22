---
layout: post
title:  "Pulse Width Modulation on Greybus"
date:   2022-09-24 13:58:14 +0530
categories: jekyll update
---
In this post, we take a look at how you can use PWM over Greybus. 

The following operations are supported by greybus

* gb_pwm_protocol_version
  
  This function is called when PWM operates initialize in Greybus kernel
  
* gb_pwm_protocol_count
  
  This function calls PWM controller driver to get the number of generator
  supported and then fill into response buffer of operation pointer.

* gb_pwm_protocol_activate
  
  This function will parse the gb_pwm_activate_request to get specific
  generator number then calls PWM controller driver to activate it.

* gb_pwm_protocol_deactivate
  
  This function will parse the device_pwm_deactivate to get specific
  generator number then calls PWM controller driver to deactivate it.

* gb_pwm_protocol_config
  
  This function will parse the gb_pwm_config_request to get specific generator
  number, duty and period, and then calls PWM controller driver to configure
  the specific generator by this particular duty and period.

* gb_pwm_protocol_polarity
  
  This function will parse the gb_pwm_polarity_request to get specific
  generator number and polarity setting, and then calls PWM controller driver
  to configure the specific generator by this particular polarity.

* gb_pwm_protocol_enable
  
  This function will parse the gb_pwm_enable_request to get specific generator
  number, and then calls PWM controller driver to start pulse toggling by duty, 
  period and polarity that previous configured in the specific generator.

* gb_pwm_protocol_disable
  
  This function will parse the gb_pwm_enable_request to get specific generator
  number, and then calls PWM controller driver to stop the specific generator
  of pulse toggling.
