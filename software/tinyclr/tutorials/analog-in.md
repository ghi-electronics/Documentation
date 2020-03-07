# Analog In
---
Unlike digital input pins, which can only read high or low, analog pins can read a range of voltage levels.  Microcontrollers based on 3.3V can typically read voltages anywhere between zero and 3.3V. Analog inputs connect internally to an Analog to Digital Converter (ADC) that converts the analog voltage level on the pin to a digital value.

> [!Tip]
> Note that the analog channel number is not the pin number. You need to determine the channel number of a specific pin using your system's documentation.

The resolution of the ADC determines its accuracy. An 8bit ADC has 256 steps to work with, 3.3V/256=0.013V. This means an increase of 0.013V will increase the ADC value by one. In other words, a voltage change of less than 0.013V has no effect.



> [!Tip]
> When multiple ADC are available on a system, you must select the right controller instead of using the default controller through GetDefault()

```cs
var adc = AdcController.FromName(SC20100.AdcChannel.Controller1.Id);
var analog = adc.OpenChannel(SC20100.AdcChannel.Controller1.PA0);

while (true) {
    double d = analog.ReadRatio();
    Debug.WriteLine("An-> " + d.ToString("N2"));
    Thread.Sleep(100);
}
```