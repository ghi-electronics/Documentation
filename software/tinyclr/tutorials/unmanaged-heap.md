# Unmanaged Heap
---
The built in [memory management](memory-management.md) system takes care of everything in an internal secure memory; however, TinyCLR OS also supports external unsecure memories through a special unmanaged heap. This memory is used in 2 different ways, in Large Buffer and for the Graphics system.

## Unsecure Large Buffers (what is it called in code?)

This is an easy way to create buffers that resides in external memories, which is typically much larger than internal memory.

```
// example code
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

