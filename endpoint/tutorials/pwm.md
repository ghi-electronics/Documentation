# PWM
---
Pulse Width Modulation (PWM) is a very useful feature found on most microcontrollers. PWM is a method of generating a square wave signal of uniform frequency with variable duty cycle. PWM is often used to generate (simulate) analog voltages, generate sounds, and driving servo motors. The ratio of the pulse width to it's period is called the duty cycle. Through software, you can control both the PWM frequency and duty cycle.

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

## Timers

PWM channels (pins) are grouped in specific timers. This means changing the frequency on a specific channel (pin) will cause the frequency to change on other channels that are found on the same timer. In .NET, these timers are referred to Chip ID. Endpoint method `GetChipId` is used to obtain the timer used on a specific pin. Similarly, `GetChannel` returns the channel number.

This table will help in planning the usage of timers

Pin |Timer | Channel
-- | -- | --
PA01 | TIM1 | CH3
PA01 | TIM1 | CH3
PA01 | TIM1 | CH3
PA01 | TIM1 | CH3
