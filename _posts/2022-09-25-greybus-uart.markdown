---
layout: post
title:  "UART on Greybus"
date:   2022-09-24 13:58:14 +0530
categories: jekyll update
---
In this post, we take a look at how you can use UART over Greybus. 

The following operations are supported by greybus

* gb_uart_protocol_version
  
  Returns the major and minor Greybus UART protocol version number supported
  by the UART device.

* gb_uart_send_data
  
  Requests that the UART device begin transmitting characters. One or more
  bytes to be transmitted will be supplied.

* gb_uart_set_line_coding
  Sets the line settings of the UART to the specified baud rate, format,
  parity, and data bits.

* gb_uart_set_control_line_state
  
  Controls RTS and DTR line states of the UART.

* gb_uart_send_break

  Requests that the UART generate a break condition on its transmit line.

The above mentioned handlers have been ported to zephyr, and a mapping has been created between greybus and zephyr.
A `phandle` is accepted by the greybus devicetree overlay, which then connects over a new CPORT..

The UART port for greybus has been tested. Presently, `gb_uart_set_line_coding` crashes the linux host.
This occurs when the host attempts to update the `uart` configuration on the node.