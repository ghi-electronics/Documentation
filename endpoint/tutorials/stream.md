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

## UartStream

```cs
public class UartStream : Stream {

    private UartController uart;
    public UartStream(UartController uart) => this.uart = uart;
    
    public override bool CanRead => true;
    public override bool CanSeek => false;
    public override bool CanWrite => true;

    public override long Length => throw new NotImplementedException();

    public override long Position { get => throw new NotImplementedException(); set => throw new NotImplementedException(); }

    public override void Flush() => this.uart.Flush();

    public override int Read(byte[] buffer, int offset, int count) {
        var read = 0;
        while (read < count){
            while (this.uart.BytesToRead == 0) ;

            read += this.uart.Read(buffer, offset + read, count - read);
        }

        return read;
    }

    public override long Seek(long offset, SeekOrigin origin) => throw new NotImplementedException();

    public override void SetLength(long value) => throw new NotImplementedException();

    public override void Write(byte[] buffer, int offset, int count){
        var write = 0;

        while (write < count){
            write += this.uart.Write(buffer, offset + write, count - write);
        }
    }

    public override bool DataAvailable => this.uart.BytesToRead > 0;
}
```







