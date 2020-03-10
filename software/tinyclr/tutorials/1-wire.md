# 1-Wire
---
1-Wire is a communication protocol designed by Dallas Semiconductor. 1-Wire is similar to I2C, but with lower data rates, longer range, and the ability to power remote sensors over the two bus lines (data and ground).

The following sample code is written for the SC20100S Dev Board with one or more DS18B20 temperature sensors. The temperature sensors are powered directly from the dev board with the data line connected to pin PA1.

> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Core, GHIElectronics.TinyCLR.Devices.Onewire, GHIElectronics.TinyCLR.Native, and GHIElectronics.TinyCLR.Pins.

```cs
class program {
    private static void Main() {
        var oneWireBus = new GHIElectronics.TinyCLR.Devices.Onewire.OneWireController
            (GHIElectronics.TinyCLR.Pins.SC20100.GpioPin.PA1);
        
        oneWireBus.TouchReset();

        var oneWireDevices = oneWireBus.FindAllDevices();

        System.Diagnostics.Debug.WriteLine("Number of sensors found = " +
            oneWireDevices.Count.ToString());

        foreach (byte[] serialNumber in oneWireDevices) {
            oneWireBus.TouchReset();
            oneWireBus.WriteByte(0x55); //Match ROM command.

            for (int i = 0; i < serialNumber.Length; i++) {
                oneWireBus.WriteByte(serialNumber[i]); //Send serial number of device.
            }

            oneWireBus.WriteByte(0x44); //Convert temperature.

            while (oneWireBus.ReadByte() == 0) { // Wait for conversion to finish.
            }

            oneWireBus.TouchReset();
            oneWireBus.WriteByte(0x55); //Match ROM command.

            for (int i = 0; i < serialNumber.Length; i++) {
                oneWireBus.WriteByte(serialNumber[i]); //Send serial number of device.
            }

            oneWireBus.WriteByte(0xBE); //Read scratchpad command.

            System.Diagnostics.Debug.WriteLine("Temperature: " +
                ((float)(oneWireBus.ReadByte() +
                (oneWireBus.ReadByte() << 8)) / 16.0).ToString());

            System.Diagnostics.Debug.WriteLine("Remaining 7 bytes of scratch pad:");

            for (int i = 0; i < 7; i++) {
                System.Diagnostics.Debug.WriteLine(oneWireBus.ReadByte().ToString());
            }

            System.Diagnostics.Debug.WriteLine("--------");
        }

        System.Threading.Thread.Sleep(-1);
    }
}
```

Sample output:
```
Number of sensors found = 3
Temperature: 21.125
Remaining 7 bytes of scratch pad:
75
70
127
255
14
16
255
--------
Temperature: 21
Remaining 7 bytes of scratch pad:
75
70
127
255
16
16
73
--------
Temperature: 21.1875
Remaining 7 bytes of scratch pad:
75
70
127
255
13
16
233
--------
```





