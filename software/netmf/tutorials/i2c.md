# I2C
---

I2C (pronounced eye-squared-sea, or eye-two-sea) was originally developed by Phillips to allow multiple chipsets to communicate on a 2-wire bus in home consumer devices. It has a master and one or more slaves sharing the same data bus. Instead of selecting the slaves using a digital pin like SPI (consuming an additional I/O pin), I2C uses an addressing mechanism to communicate to the selected device.

Before data is transferred, the master sends out a 7-bit address address of the slave device it wants to communicate with. It also sends one bit indicating whether it wants to send data to the device or receive data from the device. When a slave sees its address on the bus, it will acknowledge its presence. At this point, the master can send or receive data. The master will start data transfers with a "start" condition before it sends any address or data and then end it with "stop" condition.

The I2C uses two wires to communicate between the I2C Master and the I2C device. These two wires are known as the SDA and SCL lines. SDA stands for Serial Data, and SCL is Serial Clock.

The I2C NETMF driver is based on transactions. If we want to read from a register on a sensor, we would first need to send it the register number we wish to read from, and then we need to read the register. Those are two transactions; a write followed by a read.

## Addressing
One very important point about I2C is that I2C devices have a 7-bit address, but 8-bits are sent on the wire in the "control byte" when communicating with the I2C bus. The 8th bit tells the device whether the operation will be a read operation (the 8th bit is a 1) or a write operation (the 8th bit is a 0). When discussing I2C you should always make sure you are clear about the 7-bit address that your device uses, rather than stating your 8-bit read or write address.

## Software I2C
When using I2C, it is highly recommended that you use the built-in hardware support for I2C. In some cases though it may be necessary to have another I2C bus or it is necessary to use specific pins that are not I2C pins. In this case, I2C can be handled completely in software, though performance will be lower.

The GHI libraries include a software I2C implementation in the GHI.Hardware assembly (GHI.IO.SoftwareI2CBus).

## An I2C Example
This example will read the value of the register on an I2C device with the 7-bit address of 0x38. As discussed above, you first have to write the register number you want to read, two in this case, and then read the value back.

```cs
using Microsoft.SPOT;
using Microsoft.SPOT.Hardware;

public class Program
{
    public static void Main()
    {
        //create I2C object
        //note that the netmf i2cdevice configuration requires a 7-bit address! It set the 8th R/W bit automatically.
        I2CDevice.Configuration con =
           new I2CDevice.Configuration(0x38, 400);
        I2CDevice MyI2C = new I2CDevice(con);

        // Create transactions
        // We need 2 in this example, we are reading from the device
        // First transaction is writing the "read command"
        // Second transaction is reading the data
        I2CDevice.I2CTransaction[] xActions =
           new I2CDevice.I2CTransaction[2];

        // create write buffer (we need one byte)
        byte[] RegisterNum = new byte[1] { 2 };
        xActions[0] = I2CDevice.CreateWriteTransaction(RegisterNum);
        // create read buffer to read the register
        byte[] RegisterValue = new byte[1];
        xActions[1] = I2CDevice.CreateReadTransaction(RegisterValue);

        // Now we access the I2C bus using a timeout of one second 
        // if the execute command returns zero, the transaction failed (this 
        // is a good check to make sure that you are communicating with the device correctly
        // and don’t have a wiring issue or other problem with the I2C device)
        if (MyI2C.Execute(xActions, 1000) == 0)
        {
            Debug.Print("Failed to perform I2C transaction");
        }
        else
        {
            Debug.Print("Register value: " + RegisterValue[0].ToString());
        }
    }
}
```

## Multiple Devices
The I2C object on NETMF is a representation of the "bus" and not the "device" so you can't construct multiple I2C objects. To access multiple I2C devices you need to have multiple configurations and then when accessing device "A" we need to use configuration "A" and when accessing device "B" we need to use configuration "B".

```cs
using Microsoft.SPOT;
using Microsoft.SPOT.Hardware;

public class Program
{
    public static void Main()
    {
        //create I2C Device object representing both devices on our bus
        I2CDevice.Configuration conDeviceA =
           new I2CDevice.Configuration(0x38, 400);
        I2CDevice.Configuration conDeviceB =
           new I2CDevice.Configuration(0x48, 400);

        //create I2C Bus object using one of the devices on the bus
        I2CDevice MyI2C = new I2CDevice(conDeviceA);
        // Note you could have chosen to create the bus using the conDeviceB parameter, which ever you choose it will be the "selected" device on the bus to start with. Here's how you would do that:
        // I2CDevice MyI2C = new I2CDevice(conDeviceB);

        //create transactions (we need 2 in this example)
        I2CDevice.I2CTransaction[] xActions =
           new I2CDevice.I2CTransaction[2];

        // create write buffer (we need one byte)
        byte[] RegisterNum = new byte[1] { 2 };
        xActions[0] = I2CDevice.CreateWriteTransaction(RegisterNum);
        // create read buffer to read the register
        byte[] RegisterValue = new byte[1];
        xActions[1] = I2CDevice.CreateReadTransaction(RegisterValue);

        // Explicitly set the I2C bus to access device A by setting the I2C Config to the Device A's config.
        MyI2C.Config = conDeviceA;
        if (MyI2C.Execute(xActions, 1000) == 0)
        {
            Debug.Print("Failed to perform I2C transaction");
        }
        else
        {
            Debug.Print("Register value: " + RegisterValue[0].ToString());
        }

        // Explicitly set the I2C bus to access device B by setting the I2C Config to the Device B's config.
        MyI2C.Config = conDeviceB;
        if (MyI2C.Execute(xActions, 1000) == 0)
        {
            Debug.Print("Failed to perform I2C transaction");
        }
        else
        {
            Debug.Print("Register value: " + RegisterValue[0].ToString());
        }
    }
}
```
