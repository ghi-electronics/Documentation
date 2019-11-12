# I2C
---
I2C (pronounced eye-squared-sea, or eye-two-sea) was originally developed by Phillips as a protocol for synchronous serial communication between integrated circuits. It has a master and one or more slaves sharing the same data bus. Instead of selecting the slaves by using a dedicated chip select signal like SPI, I2C uses an addressing mechanism to communicate with the selected device. This addressing method saves one I/O pin per slave.

Before data is transferred, the master transmits the 7-bit address of the slave device it wants to communicate with. It also sends one bit indicating whether it wants to send data to the slave or receive data from the slave. When a slave sees its address on the bus, it will acknowledge its presence. At this point, the master can send or receive data. The master will start data transfers with a "start condition" before sending an address or data. The master ends the data transfer with a "stop condition."

The two wires for I2C communication are called the SDA and SCL lines. SDA stands for Serial Data, and SCL is Serial Clock.

This is a partial demo showing the use of I2C.

```csharp
using GHIElectronics.TinyCLR.Devices.I2c;
using GHIElectronics.TinyCLR.Pins;

class Program {
    private static void Main() {
        var settings = new I2cConnectionSettings(0x1C);     //The slave's address.
        settings.BusSpeed = I2cBusSpeed.FastMode;

        var controller = I2cController.FromName(FEZ.I2cBus.I2c1);
        var device = controller.GetDevice(settings);

        device.Write(new byte[] { 1, 2 });  //Write something
        device.WriteRead(...);              //This is good for reading registers.
    }
}

```

## Software I2C

The I2C bus is relatively simple and can be "bit banged" using software. The advantage is that any two GPIO pins can be used. However, software I2C requires more system resources and runs slower.

This example initializes a software I2C driver. Once initialized, it's used the same as hardware I2C.

```csharp
using GHIElectronics.TinyCLR.Devices.I2c;
using GHIElectronics.TinyCLR.Devices.I2c.Provider;
using GHIElectronics.TinyCLR.Pins;

class Program {
    private static void Main() {
        var provider = new I2cControllerSoftwareProvider(FEZ.GpioPin.A0, FEZ.GpioPin.A1, false);
        var controller = I2cController.FromProvider(provider);
        var device = controller.GetDevice(new I2cConnectionSettings(0x1C) { AddressFormat = I2cAddressFormat.SevenBit, BusSpeed = I2cBusSpeed.StandardMode }); //Device address
    }
}

```