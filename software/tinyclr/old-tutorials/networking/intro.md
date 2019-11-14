# Networking
---
TinyCLR OS Networking support provides socket and HTTP APIs that should be familiar to any .NET developer. Take a look at the [.NET docs](https://docs.microsoft.com/en-us/dotnet/api/system.net.sockets.socket) for samples. The implementation can be found in the `GHIElectronics.TinyCLR.Networking` and `GHIElectronics.TinyCLR.Networking.Http` libraries.

A low-level hardware-specific driver needs to be implemented.

## STMicroelectronics SPWF045x
A reference implementation is available today for STMicroelectronics SPWF04Sx secure WiFi module. See the [SPWF04Sx](spwf04sx.md) page for details.

## Espressif ESP32 and ESP8266
These low-cost WiFi modules have AT command firmware option. The SPWF045x driver can be used as a reference for developing drivers.

## Ethernet
Supporting built-in Ethernet or the use of SPI-based ENC28J60 require TinyCLR to host is own TCP/IP and TLS stacks. This is currently still in development. Another option is to use a C# TCP/IP implementation, such us [mIP](https://archive.codeplex.com/?p=mip). Or use a chip with built in TCP/IP, like [Wiznet W5500](https://www.wiznet.io/product-item/w5500/).

## Mobile Modems
Most mobile modems expose AT serial commands for an easy network access. They simply become a serial-to-mobile gateway. Some modems expose AT commands for socket handling, which can be used in an interface driver for TinyCLR networking support, similar to the SPWF045x drivers.

## Redpine RS9110
Customers coming from older NETMF designs may have utilized Redpine RS9110 WiFi modules. Redpine has discontinued this product and we do not have plans to supporting it in TinyCLR. Also, due to an NDA with Redpine, we are unable to provide an open driver for it.
