## I2C

- **I2cBytes(address, arrayWrite, writeCount, arrayRead, readCount)**  Reads and/or writes up to 4 bytes to/from I2C bus. Data is transfered from variables A, B, C, D. The return values (if any) are also stored in the same variables. <br>
**address:** I2C slave address<br>
**arrayWrite:** Array to send<br>
**writeCount:** The number of bytes to write<br>
**arrayWrite:** Array to read<br>
**readCount:** The number of bytes to read

```basic
# Write 1 byte, read 6 bytes
dim a[1]
a[0] = 1
dim b[6]
i2cbytes(0x1c, a, 1, b, 6) 
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