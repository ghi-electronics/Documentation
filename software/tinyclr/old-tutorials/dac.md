# DAC
---
A Digital to Analog Converter (DAC) will convert a digital input (number) to an analog output (voltage). The voltage of a DAC usually swings from very close to zero volts up to nearly the voltage of the microcontroller (usually 3.3 volts). This output voltage is only a weak signal and is not meant to drive a load. An op-amp or similar circuit can be added to drive a load, such as a speaker.
The analog out on a microcontroller has a given resolution which in large part determines its precision or accuracy. Check the device documentation for details. For example, an 8-bit DAC has 256 possible output voltage levels and a resolution of 3.3V/256 or 0.013 volts.

This example will generate a triangular waveform on the G120.

```csharp
using System.Threading;
using GHIElectronics.TinyCLR.Devices.Dac;
using GHIElectronics.TinyCLR.Pins;

class Program {
    private static void Main() {
        var dac = DacController.GetDefault();
        var analog = dac.OpenChannel(G120.DacChannel.P0_26);
        double d = 0.5;
        double dd = 0.01;
        while (true) {
            analog.WriteValue(d);
            d += dd;
            if (d <= 0 || d >= 1)
                dd *= -1;   //Invert
            Thread.Sleep(10);
        }
    }
}

```

> [!Tip]
> Do not use analog outputs to control the power of an LED or a motor. Use [PWM](pwm.md) for that.
