# Stream Class
---
Provides a generic view of a sequence of bytes. This is an abstract class.

>[!TIP]
>Need NuGets: GHIElectronics.TinyCLR.Core

## FileStream

```cs
var fileStream = new FileStream(@"A:\filename.tca", FileMode.Open);

// Allocate a buffer with size fileStream.Length
var buffer = new byte[fileStream.Length];

// Read data
fileStream.Read(buffer, 0, buffer.Length);
```

## MemoryStream

```cs
var bufferIn = new byte[3] { 1, 2, 3 };

var memoryStream = new System.IO.MemoryStream();

memoryStream.Seek(0, System.IO.SeekOrigin.Begin);
memoryStream.Write(bufferIn, 0, bufferIn.Length);

var bufferOut = memoryStream.ToArray();

// bufferIn and bufferOut match

```
## NetworkStream

```cs
var myNetworkStream = new NetworkStream(networkSocket);
```









