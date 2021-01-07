# External Memory
---
External memory is typically not secure as it can be probed by hackers. However, external memory provides the large amount of storage required by some applications.

## External RAM
Devices with external RAM have the option of utilizing this memory as [Unmanaged Heap](unmanaged-heap.md). Unmanaged heap is great for storing large amounts of data, but it is not considered secure. Bitmaps and `UnmanagedBuffer` are automatically stored in unmanaged heap.

Developers also have the option of extending core managed heap into unsecure external memory, in which case, it removes unmanaged heap space. This feature is a trade off between security and convenience -- it provides a large amount of managed heap space, but data is stored outside of the microcontroller chip where it's less secure. Please see the [IP Protection](ip-protection.md) page for more information.

[TinyCLR Config](../tinyclr-config.md) can be used to extend the heap into external SDRAM, as well as the following method, you'll also have to follow with software reset method:
```cs
GHIElectronics.TinyCLR.Native.Memory.ExtendHeap()
GHIElectronics.TinyCLR.Native.Power.Reset();
```
---

## External Flash
An optional 16MB QSPI external flash can be used to increase the available flash memory. In fact, most SITCore SoMs/boards already include this 16MB external flash.

The top 6MB of the optional external flash can be used to extend the deployment region, which holds the application and its resources. This is done by using [TinyCLR Config](../tinyclr-config.md) or through code:

```cs
GHIElectronics.TinyCLR.Native.Flash.EnableExtendDeployment()
GHIElectronics.TinyCLR.Native.Power.Reset();
```

Since external memory chips can be probed, TinyCLR supports `Secure Assemblies`. See the [IP Protection](ip-protection.md) page for more information.

> [!TIP]
> [TinyCLR Config](../tinyclr-config.md) can be used to display the internal `Deployment Map`.

The entire 16MB of flash, or 10MB when deployment is extended, can be used directly by reading/writing raw sectors or using [Tiny File System](file-system.md).

