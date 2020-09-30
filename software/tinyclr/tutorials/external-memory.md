# External Memory
---
External memory is typically not secure as it can be probed by hackers. However, external memory provides the large amount of storage required by some applications.

## External RAM
Devices with external RAM have the option of utilizing this memory as [Unmanaged Heap](unmanaged-heap.md). Unmanaged heap is great for storing large amounts of data, but it is not considered secure. Bitmaps and large buffers are automatically stored in unmanaged heap.

Developers also have the option of extending core managed heap into unsecure external memory, in which case there is no longer any unmanaged heap space. This feature is a trade off between security and convenience -- it provides a large amount of managed heap space, but data is stored outside of the microcontroller chip where it's less secure. Please see the [IP Protection](ip-protection.md) page for more information.

[TinyCLR Config](../tinyclr-config.md) can be used to extend the heap into external SDRAM, as well as the following method:
```cs
GHIElectronics.TinyCLR.Native.Memory.ExtendHeap()
```

## External Flash
Devices with external flash have the option of using up to 8 MBytes of this memory for deployment. This is done by using [TinyCLR Config](../tinyclr-config.md) to enable external flash, or by using the following method:
```cs
GHIElectronics.TinyCLR.Native.Flash.EnableExternalFlash()
```
On SITCore devices that include external flash, there is another 8 MBytes we are reserving for future use.

As external memory chips can possibly be probed, enabling external flash has important security implications. See the [IP Protection](ip-protection.md) page for more information.



