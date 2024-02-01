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
PA8 | TIM1 | CH1
PE11 | TIM1 | CH2
PA10 | TIM1 | CH3
PA11 | TIM1 | CH4
PA15 | TIM2 | CH1
PB3 | TIM2 | CH2
PA3 | TIM2 | CH4
PC6 | TIM3 | CH1
PB5 | TIM3 | CH2
PB0 | TIM3 | CH3
PD12 | TIM4 | CH1
PB7 | TIM4 | CH2
PD14 | TIM4 | CH3
PD15 | TIM4 | CH4
PA0 | TIM5 | CH1
PH11 | TIM5 | CH2
PH12 | TIM5 | CH3
PI0 | TIM5 | CH4
PI5 | TIM8 | CH1
PI6 | TIM8 | CH2
PI7 | TIM8 | CH3
PI2 | TIM8 | CH4
PH6 | TIM12 | CH1
PH9 | TIM12 | CH2
PA6 | TIM13 | CH1
PF9 | TIM14 | CH1
PE5 | TIM15 | CH1
PE6 | TIM15 | CH2
PB8 | TIM16 | CH1
PB9 | TIM17 | CH1



