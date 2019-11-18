# Garbage Collection
---
TinyCLR OS automatically disposes of objects that are no longer needed. Garbage collection eliminates the need to manage memory manually, and reduces or eliminates some types of bugs.

The act of garbage collection can temporarily reduce the responsiveness of your system, so it may be beneficial to actively manage garbage collection to improve real time response. Garbage collection should only run when there is a failed memory allocation, so by properly structuring your program you should be able to eliminate garbage collection or greatly reduce it. String operations are particularly troublesome in the creation of garbage as strings are immutable.

To reduce garbage collection, minimize the use of dynamically allocated buffers and minimize allocations in routines that get called often by preallocating or using static objects. Minimize string manipulation. As strings are immutable, manipulating a string creates a brand new string and the old string becomes garbage. Using StringBuilder to manipulate strings may help reduce garbage generation.

You can use `GC.GetTotalMemory(true)` to find out how much memory is being used. Checking free memory often during program execution will let you know if the amount of free memory is decreasing and how quickly. 

You can use `Debug.GC(true)` to force garbage collection. You might use this to ensure that garbage collection occurs during a period when responsiveness is less important.

`Debug.EnableGCMessages(true)` can be used to make sure that garbage collection messages are sent out over the debug port.

TinyCLR also supports unmanaged heaps. Unmanaged heap space can be used for large graphic buffers, for example. In unmanaged heap space, it is up to the programmer to make sure memory is correctly allocated/deallocated. Read more about unmanaged heap space [here]().

