# Extended Memory
---
External memories are typically not secures as they can be probed by hackers. However, external memories are large and required in some cases.

## External RAM
Systems with external ram have the option to utilize the memory as [Unmanaged Heap](unmanaged-heap.md) that uses in special cases only to keeps the system secure.

Developers have also the option to simply enable the external memory as a full heap. This feature is a trade off between security and convenience.

```
GHIElectronics.TinyCLR.Native.Memory.EnableExternalHeap()
```

## External Flash
High speed QSPI flash is available through the system's internal drivers. This memory is being evaluated for security and so not yet available to the user.