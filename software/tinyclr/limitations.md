# Limitations
---
TinyCLR OS is made to run small Secure IoT devices. It focuses on security first but then also reduces some less important features to keep the system small yet capable. Here is a list of limitations and possible workarounds:
1.	No multidimensional arrays, use jagged arrays. Simply use [1][1] instead of [1,1].
2.	There is a limit on each assembly size is 64KB. If you have gigantic code, just split into multiple assemblies, which is a better approach for code maintainability anyway. This limit is not for resources so if you are adding large lookup tables or binary objects then include as a resource.
3.	No Generics
4.	No async await
5.	All libraries are tweaked to be a subset .NET frameworks, like networking Sockets. And added more IoT needed features like CAN and USB.

