## I2C

- **I2cBytes(address, writeCount, readCount)** -  Reads and/or writes up to 4 bytes to/from I2C bus. Data is transfered from variables A, B, C, D. The return values (if any) are also stored in the same variables.<br>
**writeCount:** The number of bytes to write<br>
**readCount:** The number of bytes to write

```basic
# Send 0x55 byte to slave address 0x3D
a = 0x55
I2cBytes(0x3D, 1, 0)

# Read 2 bytes from slave address 0x2C
I2cBytes(0x2C, 0, 2)
Print(a)
Print(b)

# Write 1 byte and read 2 bytes from salve address 0x30
# Note how variable "a" is used for write and then read
a = 0x55
I2cBytes(0x3D, 1, 2)
Print(a)
Print(b)
```

> [!NOTE] 
> Streams are not coded directly using DUE Script, see [Streams](../streams.md)

- **I2cStream(address, writeCount, readCount)** -  <br>
**address:** address of the I2C device <br>
**writeCount:** <br>
**readCount:** <br>
**Stream size:** The stream starts with PC sending "writeCount" of bytes and then the PC must read the "readCount". If either count is zero then that step can be skipped.


> [!NOTE] 
> On SC13 devices only: The I2C pins are different on BrainPad Pulse vs FEZ boards. PB15 is used to determine how I2C should work. Pay attention to the state of PB15 on power up, Pulse has it pulled up through 10k resistor.

---