# USB
---
TinyCLR OS supports both USB Client and USB Host

## USB Client
The USB client support is mainly used for deploying and debugging applications. It can also be used to transfer data between the IoT device and a PC. See [USB CDC & WinUSB](usb-cdc-winusb.md) for details.

## USB Host
USB MSC (Mass Storage Class) allows file access on USB memory devices.

```cs
// Initialize a USB memory device.
var usbHostController = StorageController.FromName
    (@"GHIElectronics.TinyCLR.NativeApis.STM32H7.UsbHostMassStorageStorageController\0");

var usbHost = FileSystem.Mount(sd.Hdc);

```
At this point, the [file system](file-system.md) library can be used as usual.

> [!Note]
> USB Hubs are not currently supported. Special USB memory devices that have multiple interfaces or built in hubs will not work.
