# I2C
---
I2C (pronounced eye-squared-sea, or eye-two-sea) was originally developed by Phillips as a protocol for synchronous serial communication between integrated circuits. It has a master and one or more slaves sharing the same data bus. Instead of selecting the slaves by using a dedicated chip select signal like SPI, I2C uses an addressing mechanism to communicate with the selected device. This addressing method saves one I/O pin per slave.

Before data is transferred, the master transmits the 7-bit address of the slave device it wants to communicate with. It also sends one bit indicating whether it wants to send data to the slave or receive data from the slave. When a slave sees its address on the bus, it will acknowledge its presence. At this point, the master can send or receive data. The master will start data transfers with a "start condition" before sending an address or data. The master ends the data transfer with a "stop condition."

The two wires for I2C communication are called the SDA and SCL lines. SDA stands for Serial Data, and SCL is Serial Clock.

Endpoint uses the standard .NET API for I2C (System.Device.I2c) but first we need to **Initialize** the pin for I2C. 

```cs
EPM815.I2c.Intialize(EPM815.I2c.I2c6)
```

This method also allows the user to set clock speed, which 400KHz by default. 

```cs
EPM815.I2c.Intialize(EPM815.I2c.I2c6,100_000)
```

This is a partial demo showing the use of I2C.

```cs
EPM815.I2c.Intialize(EPM815.I2c.I2c6)
var i2cConnectionSetting = new I2cConnectionSettings(EPM815.I2c.I2c6, 0x1C);
var i2cDev = I2cDevice.Create(i2cConnectionSetting);

WriteToRegister(0x2A, 1);

i2cDev.Write(new byte[] { 1, 2 }); //Write something
i2cDev.WriteRead(...); //This is good for reading register
```
