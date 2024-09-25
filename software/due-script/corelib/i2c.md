# I2C

I2C is one of protocol that used widely in most sensors.

### [Python](#tab/py)
- **I2c.Write(address, arrayWrite, indexWrite, writeCount)** Write an array of data to an I2C slave<br>
**address:** I2C slave address<br>
**arrayWrite:** Array to send<br>
**indexWrite:** Index of data in the array (optional).<br>
**writeCount:** The number of bytes to write (optional) <br>

- **I2c.Read(address, arrayRead, indexRead, readCount)** Write an array of data to an I2C slave<br>
**address:** I2C slave address<br>
**arrayRead:** Array to read<br>
**indexRead:** Index of data in the array (optional)<br>
**readCount:** The number of bytes to read (optional) <br>

- **I2c.WriteRead(address, arrayWrite, indexWrite, writeCount, arrayRead, indexRead, readCount)** Write an array of data to an I2C slave <br>
**address:** I2C slave address<br>
**arrayWrite:** Array to send<br>
**indexWrite:** Index of data in the array<br>
**writeCount:** The number of bytes to write <br>
**arrayRead:** Array to read<br>
**indexRead:** Index of data in the array <br>
**readCount:** The number of bytes to read <br>

```py
# Write 11 and 22 to a slave at address 0x2C
dataWrite = [11,22]
duelink.I2c.Write(0x2C, dataWrite)

// Read 2 bytes from address 0x2C
dataRead = [0]*2
duelink.I2c.Read(0x2C, dataRead)

# WriteRead from address 0x2C
duelink.I2c.WriteRead(0x2C, dataWrite, 0, len(dataWrite), dataRead, 0, len(dataRead))
```

### [JavaScript](#tab/js)
- **I2c.Write(address, arrayWrite, indexWrite, writeCount)** Write an array of data to an I2C slave<br>
**address:** I2C slave address<br>
**arrayWrite:** Array to send<br>
**indexWrite:** Index of data in the array (optional).<br>
**writeCount:** The number of bytes to write (optional <br>

- **I2c.Read(address, arrayRead, indexRead, readCount)** Write an array of data to an I2C slave<br>
**address:** I2C slave address<br>
**arrayRead:** Array to read<br>
**indexRead:** Index of data in the array (optional).<br>
**readCount:** The number of bytes to read (optional) <br>

- **I2c.WriteRead(address, arrayWrite, indexWrite, writeCount, arrayRead, indexRead, readCount)** Write an array of data to an I2C slave <br>
**address:** I2C slave address<br>
**arrayWrite:** Array to send<br>
**indexWrite:** Index of data in the array<br>
**writeCount:** The number of bytes to write <br>
**arrayRead:** Array to read<br>
**indexRead:** Index of data in the array <br>
**readCount:** The number of bytes to read <br>


```js
let dataWrite = [11,22]
let data = new Uint8Array(2)

// Write 11 and 22 to a slave at address 0x2C
await duelink.I2c.Write(0x2C, dataWrite)

// Read 2 bytes from address 0x2C
await duelink.I2c.Read(0x2C, dataRead)

// WriteRead from address 0x2C
await duelink.I2c.WriteRead(0x2C, dataWrite, 0, dataWrite.length, dataRead, 0, dataRead.length)
```

### [.NET](#tab/net)
- **I2c.Write(address, arrayWrite, indexWrite, writeCount)** Write an array of data to an I2C slave<br>
**address:** I2C slave address<br>
**arrayWrite:** Array to send<br>
**indexWrite:** Index of data in the array (optional)<br>
**writeCount:** The number of bytes to write (optional) <br>

- **I2c.Read(address, arrayRead, indexRead, readCount)** Write an array of data to an I2C slave<br>
**address:** I2C slave address<br>
**arrayRead:** Array to read<br>
**indexRead:** Index of data in the array (optional).<br>
**readCount:** The number of bytes to read (optional) <br>

- **I2c.WriteRead(address, arrayWrite, indexWrite, writeCount, arrayRead, indexRead, readCount)** Write an array of data to an I2C slave <br>
**address:** I2C slave address<br>
**arrayWrite:** Array to send<br>
**indexWrite:** Index of data in the array<br>
**writeCount:** The number of bytes to write <br>
**arrayRead:** Array to read<br>
**indexRead:** Index of data in the array <br>
**readCount:** The number of bytes to read <br>

```cs
var dataWrite = new byte[] {11, 22};
var dataRead = new byte[2];

// Write 11 and 22 to a slave at address 0x2C
duelink.I2c.Write(0x2C, dataWrite);

// Read 2 bytes from address 0x2C
duelink.I2c.Read(0x2C, dataRead);

// WriteRead from address 0x2C
duelink.I2c.WriteRead(0x2C, dataWrite, 0, dataWrite.Length, dataRead, 0, dataRead.Length);
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

