# SPI
---
SPI uses three or four wires for transferring data. A SPI bus consists of a single master and one or more slaves. The master will send the clock signal to the slaves over the SCK (Serial Clock) pin. It will also send data over MOSI (Master Out Slave In) pin, while reading incoming data on the MISO (Master In Slave Out) pin. The SCK line is used to determine how fast the data is moved. If you know electronics, this is simply a shift register.

The master selects which slave it will swap the data with using the SSEL (Slave SELect) pin, sometimes called CS (Chip Select).

In its simplest terms, the master will swap data between itself and the slave. You cannot write data without reading data at the same time. However, often you want to write data and don't care about the incoming data. To do this you can use the Write method. Keep in mind that the Write method is discarding whatever data the slave is sending back.

> [!Tip]
> Note that a board running TinyCLR OS is always the SPI master, not the slave.

In TinyCLR OS, SPI transfers are dynamically sent in batches that are internally optimized to allow for maximum speed back-to-back transfers. This is helpful when sending large buffers, such as when refreshing displays.

> [!Tip]
> Some SPI devices (slaves) can have more than one select pin, like the VS1053 MP3 decoder chip that uses one select pin for data and the other for commands. Both share the three data transfer pins (SCK, MOSI, MISO).

```cs
var cs = GpioController.GetDefault().OpenPin(SC20260.GpioPin.PE4);

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

---

## SPI Clock Speed
SITCore SPI controllers support different clock ranges.   

SPI Controllers | 1, 2 & 3 | 4 & 5   | 6
----------------|----------|---------|----------
Minimum Speed   | 188 kHz  | 469 kHz | 250K
Maximum Speed   | 24 MHz   | 60 MHz  | 32MHz

> [!Note]
> Supported clock speeds are derived/divisible from the Maximum clock frequency. If the requested clock is not divisible, the next lower frequency will be used. This is to keep the clock speed as high as possible, but still at or below the requested speed. For example, on 60Mhz clock, the available options are 60Mhz, 30Mhz, 20Mhz, 15Mhz...etc. If the desired frequency is set to 29Mhz then 20Mhz will be used.

The `MinClockFrequency` and `MaxClockFrequency` fields can be used at runtime.

```cs
var controller = SpiController.FromName(SC20100.SpiBus.Spi3);
Debug.WriteLine(controller.MinClockFrequency.ToString());
Debug.WriteLine(controller.MaxClockFrequency.ToString());
```
---

## Bit Ordering

TinyCLR supports switching between sending the most significant bit first (MSb) or least significant bit first (LSb).

```cs
var spiSettings = new SpiConnectionSettings() {               
    DataFrameFormat = SpiDataFrame.MsbFirst // MSb
};

var spiSettings = new SpiConnectionSettings() {
    DataFrameFormat = SpiDataFrame.LsbFirst // LSb
};
```

---

## Software SPI
Users have the option to drive (bit bang) SPI bus in software over any of the available GPIOs.

```cs
var provider = new GHIElectronics.TinyCLR.Devices.
    Spi.Provider.SpiControllerSoftwareProvider(mosi, miso, clk);
```
> [!Tip]
> Software generated buses are slower and use more resources, but can be used on any pins.


## SPI Display Helper

When partially updating a section of the SPI display, SPI includes a `Write` method to extract and send the needed data. Partial updates are faster than updating the full screen due to sending fewer bytes over SPI bus.

```cs
var x = 10; 
var y = 20;
var width = 100;
var height = 100;
var originalWidth = 160;

spi.Write(graphicsBuffer, x, y, width, height, originalWidth, 1, 1);
```

> [!Tip]
> Software SPI doesn't support this method.

## Pixel Multiplier
This feature allows pixels to be multiplied across the screen, allowing larger displays to be used with lesser memory. For example, a 320x240 display can be used with 160x120 graphics buffer if both multipliers, the column and the row, are set to 2. The system will be able to drive the display with only 25% of the needed memory, trading off the resolution.

> [!Tip]
> The column and row multipliers are independent from each other. A 320x240 display can be driven with a 320x120 graphics when column multiplier is set to 1 and the row multiplier is set to 2.

```cs
spi.Write(buffer, x, y, width, height, originalWidth, columnMultiplier, rowMultiplier);
```

> [!Tip]
> Software SPI doesn't support this feature.










