# Unmanaged Heap
---
TinyCLR's [memory management](memory-management.md) system takes care of everything in internal secure memory; however, TinyCLR OS also supports external unsecure memory through a special unmanaged heap. This memory is used in two different ways, for Large Buffers and for the Graphics system, and is only available on boards with that include external SDRAM memory. Our SCM20260D Dev Board has 32 MBytes of external SDRAM, but our SCM20100 Dev Board has none.

To ensure that unmanaged resources get disposed of properly, it is necessary to dispose of the buffer pointing to unmanaged heap manually, as shown in the sample code below.

## Unmanaged Buffers

This is an easy way to create buffers that reside in external memory, which typically provides much more storage than internal memory. The following example creates an array uTable[] in unmanaged heap space on the SCM20260D Dev Board and then disposes of it.

> [!Tip]
> Add the GHIElectronics.TinyCLR.Native NuGet package and GHIElectronics.TinyCLR.Native using statement to your application.

```
//Allocate space for 100,000 byte array in unmanaged heap.
UnmanagedBuffer uBuffer = new UnmanagedBuffer(100000);

var uTable = uBuffer.Bytes;
//uTable is now available as a byte array with 100,000 elements.

// Properly release the objects. This is unmanaged so it is mandatory!
uTable = null;
uBuffer.Dispose();


```

## Graphical Memory
When the [graphics](graphics.md) engine detects an available external memory, it automatically switches to it.

## Disposing Objects
As the name implies, this memory is unmanaged! You are responsible for disposing these any allocated objects. The garbage collector does not handle this special memory.

> !Note
> The graphics system will automatically use the unmanaged heap. Remember to manually dispose of any unneeded objects

```
// make it
// dispose
Bitmap.Dispose();
```

## Helper Methods

```
// Get free memory size
….
// Get total available memory
```

