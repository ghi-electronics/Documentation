# ADC
---
Unlike digital input pins, which can only read high or low, analog pins can read a range of voltage levels.  Microcontrollers based on 3.3V can typically read voltages anywhere between zero and 3.3V. Analog inputs connect internally to an Analog to Digital Converter (ADC) that converts the analog voltage level on the pin to a digital value.

The resolution of the ADC determines its accuracy. An 8bit ADC has 256 steps to work with, 3.3V/256=0.013V. This means an increase of 0.013V will increase the value by one. In other words, a voltage change of less than 0.013V has no effect. The ADC on FEZ is 12bit and should fit most needs.

> [!Tip]
> Note that the analog channel number is not the pin number. We have these easily enumerated for FEZ, but you need to determine the channel number on a specific pin using your system's documentation.

This example will read the ratio, that is 0 to 1, of an analog input. After running the program, connect a wire from the analog pin to ground and you should see a zero or something really close to zero. Connect to 3.3V and you will see 1 or something close, like 0.99.

```csharp
using System.Diagnostics;
using System.Threading;
using GHIElectronics.TinyCLR.Devices.Adc;
using GHIElectronics.TinyCLR.Pins;

class Program {
    private static void Main() {
        var adc = AdcController.GetDefault();
        var analog = adc.OpenChannel(FEZ.AdcChannel.A0);
        while (true) {
            double d = analog.ReadRatio();
            Debug.WriteLine("An-> " + d.ToString("N2"));
            Thread.Sleep(100);
        }
    }
}
 
```
