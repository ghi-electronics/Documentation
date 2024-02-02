# File System

---

.NET includes everything needed to access files and directories. Developers will only need to mount the device. Endpoint support USB mass storage, SD cards and on-board eMMC (if available).

## Boot Media
Endpoint can boot from eMMC or SD cards. This media device is automatically mounted and used as the destination for deployed applications.

There are multiple partitions found on boot devices. The recommended partition is `\.epdata\`. This partition is used to hold the deployed application. Note that `Erase Application` option in Endpoint Config tool will format this partition.

## USB Mass Storage
This allows file access on USB devices with MSC class, such as USB memory sticks. See the [USB](usb.md) page.

## SD Card

The Endpoint system supports 2 SD interfaces. Note that if a device boots from SD then that boot SD is treated differently, as explained above.

```cs
using GHIElectronics.Endpoint.Devices.Mmc;
//...

var sdcard = new SdmmcController(SdmmcType.SdCard2);
sdcard.OnConnectionChangedEvent += Sdcard_OnConnectionChangedEvent;
sdcard.Enable();

void Sdcard_OnConnectionChangedEvent(SdmmcController sender, DeviceConnectionEventArgs e)
{
    Console.WriteLine("Detect SDCard connection changed on" + e.DeviceName + ", status: " + e.DeviceStatus + ", id = " + e.DeviceId);
}
```