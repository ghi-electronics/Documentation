# Analog Out
---
## DAC
A Digital to Analog Converter (DAC) will convert a digital input (number) to an analog output (voltage). 

The voltage of a DAC usually swings from very close to zero volts up to nearly the voltage of the microcontroller (usually 3.3 volts). This output voltage is only a weak signal and is not meant to drive a load. An op-amp or similar circuit can be added to drive a load, such as a speaker.

The param accepted by the api is from 0.0 to 1.0. This is ratio from 0V to the microcontroller's voltage source, 3.3V on SITCore.

> [!Note]
> SC20xxx and SC13xxx support 12 bit resolution.

```cs
var dac = DacController.GetDefault();
var analog = dac.OpenChannel(SC20100.Dac.PA4);

double d = 0.5;
double dd = 0.01;

while (true) {
    analog.WriteValue(d);
    d += dd;
    if (d <= 0 || d >= 1)
        dd *= -1;   //Invert
    Thread.Sleep(10);
}
```

> [!Tip]
> Do not use analog outputs to control the power of an LED or a motor. Use [PWM](pwm.md) for that.

---

## PWM
PWM can also be used to output an analog voltage. [Click here](pwm.md) for details.

---

## Audio Playback
WAV audio playback can be done using an analog output pin. See [Audio Playback](audio-playback.md).

