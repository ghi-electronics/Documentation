# PPP
---
Point to Point protocol started in the phone line dial-up Internet days and it is still in use today through cellular modems. While using PPP can be optional for small IoT systems, having a secure connection requires PPP.

This example uses the xxxx click module on our dev boards to establish a connection and read a web page.

```
```

## Security Clarification
Most embedded systems that connect to mobile networks assume they are secure but they are surely not. Typically, a serial connection with AT commands are used to communicate with the Internet. While the data offer the air is secure, all the data going over the serial wire is raw unencrypted data that can be easily scoped. This is not the case on TinyCLR OS.

Operating systems like TinyCLR that utilizes PPP for communication are secure due to the fact that the serial data between the device and the modem is encrypted. All data handling is done internally inside the core processor, which is extremely difficult to hack into.
