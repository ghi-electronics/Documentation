# SPI

- **Spi.Write(arrayWrite, indexWrite, writeCount, chipselect)** Write data array to device <br>
**arrayWrite:** Array to send<br>
**indexWrite:** Index of data in the array (optional) <br>
**writeCount:** The number of bytes to write (optional) <br>
**chipselect:** Chip select pin (optional) <br>

- **Spi.Read(arrayRead, indexRead, readCount, chipselect)** Write data array to device <br>
**arrayRead:** Array to read<br>
**indexRead:** Index of data in the array (optional)<br>
**readCount:** The number of bytes to read (optional) <br>
**chipselect:** Chip select pin (optional) <br>

- **Spi.WriteRead(arrayWrite, indexWrite, writeCount, arrayRead, indexRead, readCount, chipselect)** Write data array to device <br>
**arrayWrite:** Array to send<br>
**indexWrite:** Index of data in the array<br>
**writeCount:** The number of bytes to write <br>
**arrayRead:** Array to read<br>
**indexRead:** Index of data in the array <br>
**readCount:** The number of bytes to read <br>
**chipselect:** Chip select pin (optional)  <br>


### [Python](#tab/py)
```py
arrayWrite = [ 0xAA, 0x55, 0xAA, 0x55 ]
arrayRead = [0] * 4
chipselect = 2

duelink.Spi.Write(arrayWrite)
duelink.Spi.Write(arrayWrite, 0, 2, chipselect)

duelink.Spi.Read(arrayRead)
duelink.Spi.Read(arrayRead, 0, 2, chipselect)

duelink.Spi.WriteRead(arrayWrite, 0, arrayWrite.Length, arrayRead, 0, arrayRead.Length, chipselect)
```

### [JavaScript](#tab/js)
```js
let arrayWrite = [ 0xAA, 0x55, 0xAA, 0x55 ]
let arrayRead = new Uint8Array(4)
let chipselect = 2;

await duelink.Spi.Write(arrayWrite)
await duelink.Spi.Write(arrayWrite, 0, 2, chipselect)

await duelink.Spi.Read(arrayRead)
await duelink.Spi.Read(arrayRead, 0, 2, chipselect)

await duelink.Spi.WriteRead(arrayWrite, 0, arrayWrite.Length, arrayRead, 0, arrayRead.Length, chipselect)
```

### [.NET](#tab/net)
```cs
var arrayWrite = new byte[4] { 0xAA, 0x55, 0xAA, 0x55 };
var arrayRead = new byte[4];
var chipselect = 2;

duelink.Spi.Write(arrayWrite); 
duelink.Spi.Write(arrayWrite, 0, 2, chipselect);

duelink.Spi.Read(arrayRead);
duelink.Spi.Read(arrayRead, 0, 2, chipselect);

duelink.Spi.WriteRead(arrayWrite, 0, arrayWrite.Length, arrayRead, 0, arrayRead.Length, chipselect);

```

### [DUE Script](#tab/due)
- **SpiByte(byte)** - sends a byte <br>
**byte:** - value 0 to 255 <br>
**Return:**  Read byte value

- **SpiCfg(mode,frequency)** <br>
**mode:** - 0 to 3 <br>
**frequency:** - 200 to 20000 (200KHz to 20MHz)

```
# Send 0x55 and read the returned byte into x
x = SpiByte(0x55)
```

> [!NOTE] 
> Streams are not coded directly using DUE Script, see [Streams](../streams.md)

- **SpiStream(writeCount, readCount, cs)** - Streams data directly to the SPI device <br>
**writeCount:** The number of bytes to write<br>
**readCount:** The number of bytes to read<br>
**cs:** Chip select pin. Set to -1 if not needed

The command is followed by the data [stream](../streams.md). The stream starts with host sending "writeCount" of bytes and then the host must read the "readCount". If either count is zero then that step can be skipped. This is a full-duplex transaction, meaning a byte is written while a byte is read. If write count is less than read count, the device will send zeros internally to keep reading the requested read count.

---