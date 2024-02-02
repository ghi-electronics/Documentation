# Analog In
---
Unlike digital input pins, which can only read high or low, analog pins can read a range of voltage levels.  Microcontrollers based on 3.3V can typically read voltages anywhere between zero and 3.3V. Analog inputs connect internally to an Analog to Digital Converter (ADC) that converts the analog voltage level on the pin to a digital value.

> [!Tip]
> Note that the analog channel number is not the pin number. You need to determine the channel number of a specific pin using your system's documentation.

The resolution of the ADC determines its accuracy. An 8bit ADC has 256 steps to work with, 3.3V/256=0.013V. This means an increase of 0.013V will increase the ADC value by one. In other words, a voltage change of less than 0.013V has no effect.

The example below uses a rotary module on the ```ANA1``` pin

```cs
var adcController = new AdcController(EPM815.Adc.Pin.ANA1);
int loop = 10;
while (true) {
    var v = adcController.Read();
    var v1 = (v * 3.3 / 65535);
    Console.WriteLine(v1.ToString());
    Thread.Sleep(1000);
    loop--;
}
```
