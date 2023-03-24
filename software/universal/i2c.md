## I2C

- **I2cBytes(address, writeCount, readCount)** -  Reads and/or writes up to 4 bytes to/from I2C bus. Data is transfered to and from variables A, B, C, D<br>
**writeCount:** The number of bytes to write<br>
**readCount:** The number of bytes to write

```basic
code sample
```

- **I2cStream(address, writeCount, readCount)** -  <br>
**address:** address of the I2C device <br>
**writeCount:** <br>
**readCount:** <br>
**Stream size:** The stream starts with PC sending "writeCount" of bytes and then the PC must read the "readCount". If either count is zero then that step can be skipped.

```basic
code sample
```

> [!NOTE] 
> On SC13 devices only: The I2C pins are different on BrainPad Pulse vs FEZ boards. PB15 is used to determine how I2C should work. Pay attention to the state of PB15 on power up, Pulse has it pulled up through 10k resistor.

---