# Cellular
---
Any Cellular modem with PPP support should simply work with TinyCLR OS, see [PPP](ppp.md) for details.

http://new-docs.ghielectronics.com/software/tinyclr/tutorials/wifi.html
(keep what you have and add)

## Security Clarification
Most embedded systems that connect to WiFi networks assume they are secure but they are surely not. Typically, a serial connection with AT commands are used to communicate with the Internet. While the data offer the air is secure, all the data going over the serial wire is raw unencrypted data that can be easily scoped. This is not the case on TinyCLR OS.

Operating systems like TinyCLR that utilizes PPP for communication are secure due to the fact that the serial data between the device and the modem is encrypted. All data handling is done internally inside the core processor, which is extremely difficult to hack into.
