# USB
TinyCLR OS supports both USB Client and USB Host

## USB Client
The USB client support is mainly used for deploying and debugging applications. It can also be used to transfer data between the IoT device and a PC. See [USB CDC & WinUSB](usb-cdc-winusb.md) for details.

## USB Host
USB MSC (Mass Storage Class) allows file access on USB memory devices.

```
// Initialize a USB MSC device

// List files found on a USB memory device.
```

> Note 
> USB Hubs are not currently supported. Special USB memory devices that have multiple interface or built in hubs will not work.
