# Device Info
---

## Device name
Dynamically configure your system through these services that acquire information the device, such as Unique ID, debug interface, hardware type and version.

```cs
// device unique ID
var deviceId = DeviceInformation.UniqueId;
// show the device name, such as SC20260
Debug.WriteLine(DeviceInformation.DeviceName);
// detect what debug intrface is in use
else if (DeviceInformation.DebugInterface == DebugInterface.Usb)
   Debug.WriteLine("Debug is in usb mode");
```

You can also get manufactures name with the code below. 
```cs
Debug.WriteLine(DeviceInformation.ManufacturerName);
```
