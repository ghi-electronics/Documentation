# Device Information
---

Dynamically configure your system through these services that acquire `DeviceInformation`.

Returns devices `UniqueId`
```cs
var deviceId = DeviceInformation.UniqueId;
```

Returns `DeviceName`.
```cs
Debug.WriteLine(DeviceInformation.DeviceName);
```

Returns devices firmware `Version`.
```cs
var major = (ushort)((DeviceInformation.Version >> 48) & 0xFFFF);
var minor = (ushort)((DeviceInformation.Version >> 32) & 0xFFFF);
var build = (ushort)((DeviceInformation.Version >> 16) & 0xFFFF);
var revision = (ushort)((DeviceInformation.Version >> 0) & 0xFFFF);
Debug.WriteLine(major +"."+ minor +"."+ build +"."+ revision);
```

Detects which `DebugInterface` is in use.
```cs
if (DeviceInformation.DebugInterface == DebugInterface.Usb)
   Debug.WriteLine("Debug is in USB mode");
```

Returns `ManufacturerName` information.  
```cs
Debug.WriteLine(DeviceInformation.ManufacturerName);
```
