# Analog In
---
Unlike digital input pins, which can only read high or low, analog pins can read a range of voltage levels.  Microcontrollers based on 3.3V can typically read voltages anywhere between zero and 3.3V. Analog inputs connect internally to an Analog to Digital Converter (ADC) that converts the analog voltage level on the pin to a digital value.

> [!Tip]
> Note that the analog channel number is not the pin number. You need to determine the channel number of a specific pin using your system's documentation.

The resolution of the ADC determines its accuracy. An 8bit ADC has 256 steps to work with, 3.3V/256=0.013V. This means an increase of 0.013V will increase the ADC value by one. In other words, a voltage change of less than 0.013V has no effect.



> [!Tip]
> When multiple ADC are available on a system, you must select the right controller instead of using the default controller through GetDefault()

```cs
var adc = AdcController.FromName(SC20100.Adc.Controller1.Id);
var analog = adc.OpenChannel(SC20100.Adc.Controller1.PA0);

while (true) {
    double d = analog.ReadRatio();
    Debug.WriteLine("An-> " + d.ToString("N2"));
    Thread.Sleep(100);
}
```

## Support Sampling timing

```cs
var adc1 = AdcController.FromName(SC20100.Adc.Controller1.Id);

var adcPC0 = adc1.OpenChannel(SC20260.Adc.Controller1.PC0);

adcPC0.SamplingTime = TimeSpan.FromTicks(1000); // 100us sampling.

```

### Sampling Time range

SamplingTime range is from 1.5 to 810.5 clock cyles, with one cyle is 15.625ns.

Only these value below are accepted:
```cs
ADC_SAMPLETIME_1.5;
ADC_SAMPLETIME_2.5;
ADC_SAMPLETIME_8.5;
ADC_SAMPLETIME_16.5;
ADC_SAMPLETIME_32.5;
ADC_SAMPLETIME_64.5;
ADC_SAMPLETIME_387.5;
ADC_SAMPLETIME_810.5;
```

If the SamplingTime is between two values above, the higher values will be picked and used.

Default is 8.5 cycles.