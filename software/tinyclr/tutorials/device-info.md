# Device Information
---

## CPU usage statistic

```cs
while (true)
{                
	
	Thread.Sleep(100);	

	// Check CPU every one second
	if ((DateTime.Now - last).TotalMilliseconds >= 1000)
	{
		var cpuUsage = DeviceInformation.GetCpuUsageStatistic();
		
		Debug.WriteLine("Cpu usage = " + cpuUsage + " %");
		
		last = DateTime.Now;
		
	}


}
```

## Debug Interface

MOD pin is normally used to select the debug interface as explained in the [Debugging](debugging.md) tutorial. However, the MOD pin feature can be disabled and the debug interface can be forced to a specific interface.

```cs
DeviceInformation.SetDebugInterface(DebugInterface.Usb);
DeviceInformation.SetDebugInterface(DebugInterface.Serial);
```
The debug interface can be completely disabled for the managed application's [IP Protection](ip-protection.md) `DeviceInformation.SetDebugInterface(DebugInterface.Disable);`

The current debug interface can be determined as follows:

```cs
if (DeviceInformation.DebugInterface == DebugInterface.Usb)
   Debug.WriteLine("Debug is in USB mode");
```

The return results from `DeviceInformation.DebugInterface` only states the current interface but it does not know if that is due to MOD pin being set in that mode or the interface was forced to that specific interface. The `DeviceInformation.IsModePinDisabled` can be used to determine if MOD was used.

As an alternate option, users can change the debug interface using [TinyCLR Config](/tutorials/tinclr-config.md) tool.

> [!NOTE]
> Once the debug interfaces changed or disabled, it may not be possible to communicate with the device anymore. However, changing or disabling the interface does not affect the [bootloader](/tutorials/bootloader.md). Users can always enter the bootloader, which will be in serial or USB depending on MOD pin. From there a `Erase All` can be issues, manually or though the TinyCLR Config tool.

## APP Pin

The [Special Pin](../special-pins.md) APP's feature can be disabled using:

```cs
DeviceInformation.AppPinDisable();
var appDisPin = DeviceInformation.IsAppPinDisabled();
```

[TinyCLR Config](../tinyclr-config.md) tool can also be used to disable APP feature.

## Unique ID

Returns devices `UniqueId`
```cs
var deviceId = DeviceInformation.GetUniqueId();
```

## Firmware Info

Returns devices firmware `Version`.
```cs
var major = (ushort)((DeviceInformation.Version >> 48) & 0xFFFF);
var minor = (ushort)((DeviceInformation.Version >> 32) & 0xFFFF);
var build = (ushort)((DeviceInformation.Version >> 16) & 0xFFFF);
var revision = (ushort)((DeviceInformation.Version >> 0) & 0xFFFF);
Debug.WriteLine(major +"."+ minor +"."+ build +"."+ revision);
```

## Manufacture Name

Returns `ManufacturerName` information.  
```cs
Debug.WriteLine(DeviceInformation.ManufacturerName);
```

## Device Name

Devices have a default name that they ship with. This can be read using `DeviceInformation.DeviceName`. This name also shows on the USB debug interface. The name can changed only once through `DeviceInformation.SetDeviceName("New Device Name")`. Once set, a complete device erase is required before changing the name again.

> [!TIP]
> Since Windows caches the name when loading the driver, Windows `Device Manager` will still show the old name. Simply right-click on the device and uninstall the driver. The next time it installs the drivers it will update with the new name.
