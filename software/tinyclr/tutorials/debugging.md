# Debugging
---
Debug a tiny IoT device just like you would debug an application on a full PC. You can easily debug your code from within Visual Studio over USB or Serial. Set breakpoints, step through code, and examine variables without the need for specialized hardware or software.

On power up, the system checks the MOD pin to determine the debug interface, USB or Serial.

You can also detect which debug interface is being used in your code as shown below. 

```cs
if (DeviceInformation.DebugInterface == DebugInterface.Disable)
   Debug.WriteLine("Debug locked");
else if (DeviceInformation.DebugInterface == DebugInterface.Serial)
   Debug.WriteLine("Debug is in serial mode");
else if (DeviceInformation.DebugInterface == DebugInterface.Usb)
   Debug.WriteLine("Debug is in usb mode");
```

Information on using the debugger can be found in Microsoft's documentation [here](https://docs.microsoft.com/en-us/visualstudio/debugger/debugger-feature-tour?view=vs-2019).
