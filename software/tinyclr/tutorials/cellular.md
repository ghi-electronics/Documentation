# Cellular
---
Any Cellular modem with PPP support should simply work with TinyCLR OS, see [PPP](ppp.md) for details.

http://new-docs.ghielectronics.com/software/tinyclr/tutorials/wifi.html
(keep what you have and add)

## Security Clarification
Most users of embedded systems that connect to mobile networks assume they are secure, but often they are not. Typically, a serial connection with AT commands is used to communicate with the Internet. While the data over the air is secure, all data transmitted over the serial connection is raw unencrypted data that can be easily scoped. This is not the case with TinyCLR OS.

With TinyCLR OS, serial data between the device and the modem is encrypted. All data handling is done internally inside the core processor, which is extremely difficult to hack into.
