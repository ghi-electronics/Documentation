[IN PROGRESS](error.md) 
# Cellular
---
Any Cellular modem with PPP support should simply work with TinyCLR OS. Please see our [PPP tutorial](ppp.md) for more details and sample code. Other networking information and sample code can be found on our [WiFi](wifi.md) and [Ethernet](ethernet.md) tutorials.

## Security Clarification
Most users of embedded systems that connect to mobile networks assume they are secure, but often they are not. Typically, a serial connection with AT commands is used to communicate with the Internet. While the data over the air is secure, all data transmitted over the serial connection is raw unencrypted data that can be easily scoped. This is not the case with TinyCLR OS.

With TinyCLR OS, serial data between the device and the modem is encrypted. All data handling is done internally inside the core processor, which is extremely difficult to hack into.
