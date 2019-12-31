# Limitations
---
TinyCLR OS is made to run on small, secure, IoT devices. TinyCLR was built from the ground up with security first and foremost. Performance is also excellent, but we did have to limit some of the less important features to achieve this performance while maximizing application memory. Here is a list of limitations and possible workarounds:

1.	There is no support for multidimensional arrays, use jagged arrays instead. Simply use [1][1] instead of [1,1].
2.	Each assembly is limited to 64KB. If you have gigantic code, just split your solution into multiple assemblies. This approach improves code maintainability as well. Resource files are not subject to this limitation, so if you are adding large lookup tables or binary objects, include them as a resource.
3.	TinyCLR does not support generics. While this is less of a limitation on an embedded device than on the desktop, we understand that professional .NET developers will miss this feature. However, on small embedded systems implementing generics can reduce performance.
4.	the async/await pattern is not supported.
5.	All libraries, networking sockets for example, are tweaked to be a subset of the full .NET framework that will perform well on embedded devices. These tweaks have allowed us to support essential IoT features like CAN and USB.

