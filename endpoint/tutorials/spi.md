# SPI

---

SPI uses three or four wires for transferring data. A SPI bus consists of a single master and one or more slaves. The master will send the clock signal to the slaves over the SCK (Serial Clock) pin. It will also send data over MOSI (Master Out Slave In) pin, while reading incoming data on the MISO (Master In Slave Out) pin. The SCK line is used to determine how fast the data is moved. If you know electronics, this is simply a shift register.

The master selects which slave it will swap the data with using the SSEL (Slave SeLect) pin, sometimes called CS (Chip Select).

In its simplest terms, the master will swap data between itself and the slave. You cannot write data without reading data at the same time. However, often you want to write data and don't care about the incoming data. To do this you can use the Write method. Keep in mind that the Write method is discarding whatever data the slave is sending back.

> [!Tip]
> Note that an Endpoint device is always the SPI master, not the slave.

> [!Tip]
> Some SPI devices (slaves) can have more than one select pin, like the VS1053 MP3 decoder chip that uses one select pin for data and the other for commands. Both share the three data transfer pins (SCK, MOSI, MISO).

First, the desired appropriate pins needs to be set to use the SPI function `EPM815.Spi.Initialize(EPM815.Spi.Spi4);` and then SPI is a standard .NET IoT feature.

```cs
// Map pins to use SPI
EPM815.Spi.Initialize(EPM815.Spi.Spi4);
// Get settings ready
var setting = new SpiConnectionSettings(EPM815.Spi.Spi4)
{
    ClockFrequency = 4_000_000,
    Mode = SpiMode.Mode0,
};
// Create the SPI device
var spiDev = SpiDevice.Create(setting);

// read and write SPI
var writebuff = new byte[2];
var readbuff = new byte[10];
spiDev.TransferFullDuplex(writebuff, readbuff);
```
