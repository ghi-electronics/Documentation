# Debugging
---
TinyCLR OS allows developers to debug tiny IoT devices just like you would debug an application on a full PC, right from  within Visual Studio, over USB or Serial. Set breakpoints, step through code, and examine variables without the need for specialized hardware or software.

By default, the system checks the [MOD pin](../special-pins.md) to determine the debug interface, USB or Serial. The user has the option to disable MOD pin feature and force (or disable) the debug interface. See [Device Info](device-info.md) for details.

When serial debugging is selected, it defaults to UART0 on SC13 and to UART5 on SC20.

> [!TIP]
> Information on using the Visual Studio debugger can be found in Microsoft's documentation [here](https://docs.microsoft.com/en-us/visualstudio/debugger/debugger-feature-tour?view=vs-2019).
