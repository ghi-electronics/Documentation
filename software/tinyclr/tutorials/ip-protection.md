# IP Protection
---
Designed with security as a top priority, TinyCLR OS provides protection for both user's code and user's data.

## Securing Code
By default, user's code is stored securely on the internal flash memory. It can only be reached by the USB or serial debug interfaces, which can be disabled using the [TinyCLR Config](../tinyclr-config.md) utility program or using `GHIElectronics.TinyCLR.Update.Application.Lock()`. This `Lock` can only be undone by a complete system Erase All, from TinyCLR Config. The current active debug interface can be read through `GHIElectronics.TinyCLR.Native.DeviceInformation.DebugInterface`.

The system supports extending the deployment region, where user's code/assemblies are stored, into external unsecured flash memory. To keep important data secure, the system supports `Secure Assemblies`. Those assemblies are loaded into the internal secure flash. To tag an assembly as secure, users must edit the `AssemblyInfo.cs` file in the `Properties` folder within the project's folder. Change the line `[assembly: AssemblyConfiguration("")]` to `[assembly: AssemblyConfiguration("secure")]` (the word "secure" is not case sensitive).  During deployment Visual Studio will display an allocation table showing both the secure and unsecure assemblies and their address, a quick way to verify secure assemblies. This is found in the `TinyCLR Device Deployment` Visual Studio output window.

The [In-Field Update](in-field-update.md) page covers the details on updating a locked system.

---

## Securing Data
The entire system, including user's keys, cryptography, and everything else are stored on the internal RAM, accessible only by the system itself and the user's application. When external RAM is utilized, it is only there for the graphics engine. Having images stored in unsecure memory has very little security concerns, unless for example, a key is shown on one of the images. There is also a special `LargeBuffer` feature that allocates memory from the external RAM, where the user is aware and is in control of what to do with this unsecure buffer.

If desired, designs that require large heaps of RAM for the entire application have the option to extend the heap to fully encapsulate the external memory, making the system data unsecure. However, external RAM (SDRAM) isn't probed easily like external flash (QSPI) even if used for extended heap, not secure in this case but more challenging to probe.

Refer to the [External Memory](external-memory.md) page for more info.



