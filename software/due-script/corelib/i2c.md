# I2C



### [Python](#tab/py)

- **I2c.Write(address, data, index, count)** Write an array of data to an I2C slave.
**address:** I2C slave address<br>
**arrayWrite:** Array to send<br>
**index:** Index of data in the array (optional).<br>
**count:** Array to send<br>

- **I2c.Read(address, data, count)** Write an array of data to an I2C slave.
**address:** I2C slave address<br>
**arrayWrite:** Array to send<br>

- **I2c.WriteRead(address, data)** Write an array of data to an I2C slave.
**address:** I2C slave address<br>
**arrayWrite:** Array to send<br>

```py
# Write 11 and 22 to a slave at address 0x2C
I2c.Write(0x2C, [11,22])
# Read data from address 0x2C
I2C.Read(0x2C, ....)
```

### [.NET](#tab/net)
- **I2c.Write(address, data, index = 0, len = -1)** Write an array of data to an I2C slave.
**address:** I2C slave address<br>
**arrayWrite:** Array to send<br>
**index:** Index of data in the array. Optional argument.<br>
**arrayWrite:** Array to send<br>

- **I2c.Read(address, data, count)** Write an array of data to an I2C slave.
**address:** I2C slave address<br>
**arrayWrite:** Array to send<br>

- **I2c.WriteRead(address, data)** Write an array of data to an I2C slave.
**address:** I2C slave address<br>
**arrayWrite:** Array to send<br>

```cs
example
```

### [JavaScript](#tab/js)
- **I2c.Write(address, data, index = 0, len = -1)** Write an array of data to an I2C slave.
**address:** I2C slave address<br>
**arrayWrite:** Array to send<br>
**index:** Index of data in the array. Optional argument.<br>
**arrayWrite:** Array to send<br>

- **I2c.Read(address, data, count)** Write an array of data to an I2C slave.
**address:** I2C slave address<br>
**arrayWrite:** Array to send<br>

- **I2c.WriteRead(address, data)** Write an array of data to an I2C slave.
**address:** I2C slave address<br>
**arrayWrite:** Array to send<br>

```js
example
```

### [DUE Script](#tab/due)

DUE Scrip uses a different fuction to access I2C.

- **I2cBytes(address, arrayWrite, writeCount, arrayRead, readCount)**  Reads and/or writes up to 4 bytes to/from I2C bus. Data is transfered from variables A, B, C, D. The return values (if any) are also stored in the same variables. <br>
**address:** I2C slave address<br>
**arrayWrite:** Array to send<br>
**writeCount:** The number of bytes to write<br>
**arrayRead:** Array to read<br>
**readCount:** The number of bytes to read

```basic
# Write 1 byte, read 6 bytes
dim a[1]
a[0] = 1
dim b[6]
i2cbytes(0x1c, a, 1, b, 6) 
```

---

- **I2cStream(address, writeCount, readCount)** -  <br>
**address:** address of the I2C device <br>
**writeCount:** <br>
**readCount:**

The command is followed by the data [stream](../streams.md). The stream starts with the host sending "writeCount" of bytes and then the host must read the "readCount". If either count is zero then that step can be skipped.

> [!NOTE] 
> On SC13 devices only: The I2C pins are different on BrainPad Pulse vs FEZ boards. PB15 is used to determine how I2C should work. Pay attention to the state of PB15 on power up, Pulse has it pulled up through 10k resistor.

---