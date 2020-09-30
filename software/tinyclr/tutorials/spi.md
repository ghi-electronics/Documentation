# SPI
---
SPI uses three or four wires for transferring data. A SPI bus consists of a single master and one or more slaves. The master will send the clock signal to the slaves over the SCK (Serial Clock) pin. It will also send data over MOSI (Master Out Slave In) pin, while reading incoming data on the MISO (Master In Slave Out) pin. The SCK line is used to determine how fast the data is moved. If you know electronics, this is simply a shift register.

The master selects which slave it will swap the data with using the SSEL (Slave SELect) pin, sometimes called CS (Chip Select).

In its simplest terms, the master will swap data between itself and the slave. You cannot write data without reading data at the same time. However, often you want to write data and don't care about the incoming data. To do this you can use the Write method. Keep in mind that the Write method is discarding whatever data the slave is sending back.

In TinyCLR OS, SPI transfers are dynamically sent in batches that are internally optimized to allow for maximum speed back-to-back transfers. This is helpful when sending large buffers, such as when refreshing displays.

> [!Tip]
> Some SPI devices (slaves) can have more than one select pin, like the VS1053 MP3 decoder chip that uses one select pin for data and the other for commands. Both share the three data transfer pins (SCK, MOSI, MISO).

> [!Tip]
> SPI needs more wires than other similar buses, but it can transfer data very quickly. A SPI port with a clock speed of 30Mhz transfers 30 million bits in one second. 

> [!Tip]
> Note that a board running TinyCLR OS is always the SPI master, not the slave.

## SPI Clock Speed
SITCore SPI ports do not use the same clock, so different SPI ports have different minimum and maximum clock speeds:

SPI Controllers | 1, 2 & 3 | 4 & 5   | 6
----------------|----------|---------|----------
Minimum Speed   | 188 kHz  | 469 kHz | 250K
Maximum Speed   | 24 MHz   | 60 MHz  | 32MHz


The `MinClockFrequency` and `MaxClockFrequency` fields can be used to verify the range of valid clock speeds for a given SPI port:
```cs
var controller = SpiController.FromName(SC20100.SpiBus.Spi3);
Debug.WriteLine(controller.MinClockFrequency.ToString()); //Prints minimum SPI clock in Hertz.
Debug.WriteLine(controller.MaxClockFrequency.ToString()); //Prints maximum SPI clock in Hertz.
```
## Most Significant Bit (MSB) and Least Significant Bit (LSB)
SITCore supports switching between MSB and LSB.

```
var spiSettings = new SpiConnectionSettings()
{               
    DataFrameFormat = SpiDataFrame.MsbFirst // MSB
};

var spiSettings = new SpiConnectionSettings()
{
    DataFrameFormat = SpiDataFrame.LsbFirst // LSB
};

```

## Sample Code

```cs
var cs = GHIElectronics.TinyCLR.Devices.Gpio.GpioController.GetDefault().
    OpenPin(GHIElectronics.TinyCLR.Pins.SC20260.GpioPin.PE4);

var settings = new SpiConnectionSettings() {
    ChipSelectType = SpiChipSelectType.Gpio,
    ChipSelectLine = cs,
    Mode = SpiMode.Mode1,
    ClockFrequency = 4_000_000,
};

var controller = SpiController.FromName(SC20100.SpiBus.Spi4);
var device = controller.GetDevice(settings);

device.Write(new byte[] { 1, 2 }); //Write something.
device.TransferSequential(...);    //This is good for reading registers.
device.TransferFullDuplex(...);    //This is the only one that truly represents how SPI works.
```