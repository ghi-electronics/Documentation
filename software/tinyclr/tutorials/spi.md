# SPI
---
SPI uses three, sometimes four, wires for transferring data. The bus on SPI consists of a single master and one or more slaves. The master will send the clock signal to the slaves over the SCK pin. It will also send data over MOSI pin, while reading incoming data on the MISO pin. The SCK clock line is used to determine how fast the data is moved. If you know electronics, this is simply a shift register.

The master selects which slave it will swap the data with using the SSEL (Slave SELect) pin, sometimes called CS (Chip Select).

In its simplest terms, the master will swap data between itself and the slave. You cannot write data without reading data at the same time. However, often you want to write data and don't care about the incoming data. To do this you can use the Write method. Keep in mind that the Write method is also reading and discarding whatever the slave is sending.

> [!Tip]
> Some SPI devices (slaves) can have more than one select-pin, like the VS1053 MP3 decoder chip that uses one select pin for data and other for commands. Both share the three data transfer pins (SCK,  >MOSI, MISO).

> [!Tip]
> SPI needs more wires than other similar buses but it can transfer data very quickly. A 50Mhz clock is possible on SPI, that is 50 million bits in one second. 

> [!Tip]
> Note that a board running TinyCLR OS is always an SPI master, not slave.

```csharp
using GHIElectronics.TinyCLR.Devices.Spi;
using GHIElectronics.TinyCLR.Pins;

class Program {
    private static void Main() {
        var settings = new SpiConnectionSettings()
        {
            ChipSelectType = SpiChipSelectType.Gpio,
            ChipSelectLine = FEZ.GpioPin.A0,
            Mode = SpiMode.Mode1,
            ClockFrequency = 4 * 1000 * 1000,       //4Mhz
            DataBitLength = 8,
        };

        var controller = SpiController.FromName(FEZ.SpiBus.Spi1);
        var device = controller.GetDevice(settings);

        device.Write(new byte[] { 1, 2 });          //Write something.
        device.TransferSequential(...);             //This is good for reading registers.
        device.TransferFullDuplex(...);             //This is the only one that truly represents how SPI works.
    }
}
  
```