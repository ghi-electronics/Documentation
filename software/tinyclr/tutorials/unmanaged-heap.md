# Unmanaged Heap
---
TinyCLR's [memory management](memory-management.md) system takes care of everything in internal secure memory; however, TinyCLR OS also supports external unsecure memory through a special unmanaged heap. This memory is used in two different ways, for Large Buffers and for the Graphics system, and is only available on boards with that include external SDRAM memory. Our SCM20260D Dev Board has 32 MBytes of external SDRAM, but our SC20100S Dev Board has none.

To ensure that unmanaged resources get disposed of properly, it is necessary to dispose of the buffer pointing to unmanaged heap manually, as shown in the sample code below.

## Unmanaged Buffers

This is an easy way to create buffers that reside in external memory, which typically provides much more storage than internal memory. The following example creates an array uTable[] in unmanaged heap space on the SCM20260D Dev Board and then disposes of it.

> [!Tip]
> Needed Nuget: GHIElectronics.TinyCLR.Native
> 
> Needed Namespace: GHIElectronics.TinyCLR.Native

```cs
//Allocate space for 100,000 byte array in unmanaged heap.
UnmanagedBuffer uBuffer = new UnmanagedBuffer(100000);

var uTable = uBuffer.Bytes;
//uTable is now available as a byte array with 100,000 elements.

// Properly release the objects. This is unmanaged so it is mandatory!
uTable = null;
uBuffer.Dispose();

```

## Graphical Memory
When the [graphics](graphics.md) engine detects available external memory, it automatically uses it. Also, garbage collection will dispose of unmanaged graphics buffers automatically. You do not have to dispose of unmanaged graphics buffers like you do for unmanaged non-graphic buffers.

## Helper Methods

```cs
//Print number of available bytes in unmanaged memory.
System.Diagnostics.Debug.WriteLine(Memory.UnmanagedMemory.FreeBytes.ToString());

//Print the number of bytes being used in unmanaged memory.
System.Diagnostics.Debug.WriteLine(Memory.UnmanagedMemory.UsedBytes.ToString());
```


