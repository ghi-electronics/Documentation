## SPI

- **SpiByte(byte)** - sends a byte <br>
**byte:** - value 0 to 255 <br>
**Return:**  Read byte value

- **SpiCfg(mode,frequency)** <br>
**mode:** - 0 to 3 <br>
**frequency:** - 200 to 20000 (200KHz to 20MHz)

```basic
# Send 0x55 and read the returned byte into x
x = SpiByte(0x55)
```

> [!NOTE] 
> Streams are not coded directly using DUE Script, see [Streams](../streams.md)

- **SpiStream(writeCount, readCount, cs)** - Streams data directly to the SPI device <br>
**writeCount:** The number of bytes to write<br>
**readCount:** The number of bytes to read<br>
**cs:** Chip select pin. Set to -1 if not needed

The command is followed by the data [stream](../streams.md). The stream starts with host sending "writeCount" of bytes and then the host must read the "readCount". If either count is zero then that step can be skipped.

---