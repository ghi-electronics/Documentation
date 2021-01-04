# Stream Class
---
Provides a generic view of a sequence of bytes. This is an abstract class.

>[!TIP]
>Need Nugets: GHIElectronics.TinyCLR.Core

# Examples

## FileStream
The following example demonstrates how to use FileStream object to load date from the file "filename.tca" into a buffer.

```cs
var fileStream = new FileStream(@"A:\filename.tca", FileMode.Open);

// Allocate a buffer with size fileStream.Length
var buffer = new byte[fileStream.Length];

// Read data
fileStream.Read(buffer, 0, buffer.Length);
```

## MemoryStream
Creates a stream whose backing store is memory
The following code example shows how to read and write data using memory as a backing store.

```cs
var bufferIn = new byte[3] { 1, 2, 3 };

var memoryStream = new System.IO.MemoryStream();

memoryStream.Seek(0, System.IO.SeekOrigin.Begin);
memoryStream.Write(bufferIn, 0, bufferIn.Length);

var bufferOut = memoryStream.ToArray();

// bufferIn and bufferOut are same exactly.

```
## NetworkStream
Provides the underlying stream of data for network access.

The following code example demonstrates how to create a NetworkStream from a connected StreamSocket

```cs
// Create the NetworkStream for communicating with the remote host.
NetworkStream myNetworkStream;

if (networkStreamOwnsSocket){
     myNetworkStream = new NetworkStream(mySocket, true);
}
else{
     myNetworkStream = new NetworkStream(mySocket);
}
```









