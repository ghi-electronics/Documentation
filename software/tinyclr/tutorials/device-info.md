# Device Information
---

Dynamically configure your system through these services that acquire `DeviceInformation`.

Returns devices `UniqueId`
```cs
var deviceId = DeviceInformation.GetUniqueId();
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

## Device Name
Devices have common name that is they ship with. This can be read using `DeviceInformation.DeviceName`. This name also shows on the USB debug interface. The name can changed only once through `DeviceInformation.SetPersistDeviceName("New Device Name")`. Once set, a complete device erase is required before changing the name again.
