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
**cs:** set to -1 if not needed<br>
**Stream size:** The stream starts with PC sending "writeCount" of bytes and then the PC must read the "readCount". If either count is zero then that step can be skipped.

- **Spi4Bpp(count)** - Streams and converts data from 4BPP to 16BPP<br>
**count:** The count of bytes to be written.<br>
**Stream size:** The "count".

This special function converts 4BPP incoming data to 16BPP on-the-fly. This is added to speed up the use of SPI color displays, namely ones using ST7735 found on the very common 1.8" SPI color displays. This allows for faster updates, since each byte sent is 2 pixels.

- **Palette(index, colorValue)** - Sets the desired color for a palette.<br>
**index:** Index number of color<br>
**colorValue:** A standard HEX value of the RGB color.

This function goes hand-in-hand with **Spi4Bpp()** function to set the colors that are to be used. 

Default colors:

|Index|Color Value|Color|
|:-   |:-------|:----------|
|0    |0x000000|Black      |
|1    |0xFFFFFF|White      |
|2    |0xFF0000|Red        |
|3    |0x32CD32|Lime       |
|4    |0x0000FF|Blue       |
|5    |0xFFFF00|Yellow     |
|6    |0x00FFFF|Cyan       |
|7    |0xFF00FF|Magenta    |
|8    |0xC0C0C0|Silver     |
|9    |0x808080|Gray       |
|10   |0x800000|Maroon     |
|11   |0xBAB86C|Olive      |
|12   |0x00FF00|Green      |
|13   |0xA020F0|Purple     |
|14   |0x008080|Teal       |
|15   |0x000080|Navy       | 

---