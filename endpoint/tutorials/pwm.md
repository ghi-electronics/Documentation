# PWM
---
Pulse Width Modulation (PWM) is a very useful feature found on most microcontrollers. PWM is a method of generating a square wave signal of uniform frequency with variable duty cycle. PWM is often used to generate analog voltages, but has many other uses such as generating digital pulses for driving servo motors or driving infrared LEDs for communication. The ratio of the pulse width to it's period is called the duty cycle. Through software, you can control both the PWM frequency and duty cycle.

## Playing sound

```cs
using System.Device.Pwm;
using GHIElectronics.Endpoint.Core;

EPM815.Pwm.Initialize(EPM815.Pwm.Pin.PF9);

PwmChannel pwm = PwmChannel.Create(EPM815.Pwm.GetChipId(EPM815.Pwm.Pin.PF9), EPM815.Pwm.GetChannelId(EPM815.Pwm.Pin.PF9));
pwm.DutyCycle = 0.25;
pwm.Frequency = 1000;
pwm.Start();
Thread.Sleep(1000);
pwm.Stop();
```
---

