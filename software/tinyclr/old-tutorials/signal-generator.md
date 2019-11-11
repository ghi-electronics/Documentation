# Signal Generator
---
SignalGenerator is a digital waveform generator. SignalGenerator works by comparing an internal counter to an array of time values, one by one. When the value of the argument matches the counter, the output pin is changed. The time values are in microseconds.

SignalGenerator can also be used to generate PWM. Unlike the PWM class, SignalGenerator can be used to generate PWM on any available output pin. It does use processor time -- the higher the frequency the more processor time it uses.

At this time, SignalGenerator only operates in blocking mode. While SingnalGenerator is running it will not yield any processor time to other code.

The following sample code will blink LED1 on the FEZ four times (for one second each time) every five seconds.

```csharp
using GHIElectronics.TinyCLR.Devices.Gpio;
using GHIElectronics.TinyCLR.Devices.Signals;
using GHIElectronics.TinyCLR.Pins;
using System;
using System.Threading;

public static class Program {
    public static void Main() {
        var gen = new SignalGenerator(FEZ.GpioPin.Led1);
        var buffer = new[] {
            TimeSpan.FromSeconds(1),
            TimeSpan.FromSeconds(1),
            TimeSpan.FromSeconds(1),
            TimeSpan.FromSeconds(1),
            TimeSpan.FromSeconds(1),
            TimeSpan.FromSeconds(1),
            TimeSpan.FromSeconds(1),
            TimeSpan.FromSeconds(1),
        };

        gen.DisableInterrupts = false;
        gen.IdleValue = GpioPinValue.Low;

        while (true) {
            gen.Write(buffer);

            Thread.Sleep(5000);
        }
    }
}
```