# SPI
---

SPI uses three, sometimes four, wires for transferring data. The bus on SPI consists of one master and one or more slaves. The master will send clock to the salves along with data and will read back using the same clock. This clock is used to determine how fast the data is moved. If you know electronics, this is a shift register.

So, the master will transmit a clock on a SCK (serial clock) pin and will simultaneously transmit the data on MOSI (Master Out Slave In) pin. The slave will read the clock on SCK pin and simultaneously read the data from MOSI pin. So far, this is a one way communication. While data is transmitted in one direction using MOSI another set of data is sent back on MISO (Master In Slave Out) pin. Other data sizes are possible but bytes are most common. NETMF supports 8-bit (byte) and 16-bit (short) data transfers.

Because of this master/slave scheme, we can add multiple slaves on the same bus where the master selects which slave it will swap the data with. Note I am using the word swap because you can never send or receive but you always send and receive (swap) data. The master selects one of the slaves using SSEL (Slave Select) pin. This pin can be called CS (Chip Select) as well. In theory, the master can have unlimited slaves but it can only select one of them at any given time. The master will only need 3 wires (SCK, MISO, MOSI) to connect to all slaves on the bus but then it needs a separate SSEL pin for each one of the slaves.

Some SPI devices (slaves) can have more than one select pin, like VS1053 MP3 decoder chip that uses one pin for data and one pin for commands but both share the 3 data transfer pins (SCK, MOSI, MISO).

SPI needs more wires than other similar buses but it can transfer data very fast. A 50Mhz clock is possible on SPI, that is 50 million bits in one second. Note that NETMF devices are always SPI masters, not slaves.

Before creating a SPI object, we would need a SPI configuration object. The configuration object is used to set the states of the SPI pins and some timing parameters. In most cases, you need the clock to be idle low (false) with clocking on rising edge (true) and with zero for select setup and hold time. The only thing you would need to set is the clock frequency. Some devices may accept high frequencies but others do not. Setting the clock to 1000Khz (1Mhz) should be okay for a starter

## Getting Started

This example is sending/receiving 10 bytes of data on SPI channel 1.

Note: NETMF start numbering SPI channels (module) from 1, but on processors the channels start from 0 typically. So, using SPI1 in code is actually using SPI0 on the processor.

```cs
using System.Threading;
using Microsoft.SPOT.Hardware;

public class Program
{
    public static void Main()
    {
        SPI.Configuration MyConfig =
             new SPI.Configuration(Cpu.Pin.GPIO_Pin1,
             false, 0, 0, false, true, 1000, SPI.SPI_module.SPI1);
        SPI MySPI = new SPI(MyConfig);

        byte[] tx_data = new byte[10];
        byte[] rx_data = new byte[10];

        MySPI.WriteRead(tx_data, rx_data);

        Thread.Sleep(100);
    }
}
```

## Accessing Multiple Devices

The SPI object on NETMF is a representation of the "bus" and not the "device", so you can't construct multiple SPI objects, unless it uses a different SPI bus. To access multiple SPI devices you need to have multiple configurations and then when accessing device "A" we need to use configuration "A" and when accessing device "B" we need to use configuration "B".

```cs
using Microsoft.SPOT.Hardware;

public class Program
{
    public static void Main()
    {
        SPI.Configuration ConfigDeviceA =
             new SPI.Configuration(Cpu.Pin.GPIO_Pin1,
             false, 0, 0, false, true, 1000, SPI.SPI_module.SPI1);
        SPI.Configuration ConfigDeviceB =
             new SPI.Configuration(Cpu.Pin.GPIO_Pin4,
             false, 0, 0, false, true, 1000, SPI.SPI_module.SPI1);
        SPI MySPI = new SPI(ConfigDeviceA);

        byte[] tx_data = new byte[10];
        byte[] rx_data = new byte[10];
        // accessing device A
        MySPI.Config = ConfigDeviceA;
        MySPI.WriteRead(tx_data, rx_data);

        // accessing device B
        MySPI.Config = ConfigDeviceB;
        MySPI.WriteRead(tx_data, rx_data);
    }
}
```
