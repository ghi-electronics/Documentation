# Debugging
---
TinyCLR OS allows developers to debug tiny IoT device just like you would debug an application on a full PC, right from  within Visual Studio, over USB or Serial. Set breakpoints, step through code, and examine variables without the need for specialized hardware or software.

> [!TIP]
> APP and MOD become inactive when the debug interface is set to none. See [IP Protection](ip-protection.md) for details.

On power up, the system checks the MOD pin to determine the debug interface, USB or Serial.

You can also detect which debug interface is being used in your code as shown below, see [Device Info](device-info.md).

Information on using the Visual Studio debugger can be found in Microsoft's documentation [here](https://docs.microsoft.com/en-us/visualstudio/debugger/debugger-feature-tour?view=vs-2019).
