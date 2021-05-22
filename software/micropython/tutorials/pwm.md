# PWM

---

Pulse Width Modulation (PWM) is a very useful feature found on most microcontrollers. PWM is a method of generating a square wave signal of uniform frequency with variable duty cycle. PWM is often used to generate analog voltages, but has many other uses such as generating digital pulses for driving servo motors or driving infrared LEDs for communication. The ratio of the pulse width to it's period is called the duty cycle. Through software, you can control both the PWM frequency and duty cycle.
#PWM

---

Pulse Width Modulation is used to generate frequencies on a pin, or to control the level of power given to a pin.

This example will sweep through frequency:

```
from machine import Pin, Timer
import time

p = Pin('PA5') # PA5 has TIM2, CH1
tim = Timer(2, freq=4000)
ch = tim.channel(1, Timer.PWM, pin=p)
ch.pulse_width_percent(50)
for f in range(500, 1800):
	tim.freq(f)
	time.sleep(0.01)
```

This example will brighten up an LED, from 1% to 100%, by changing the duty cycle:

```
from machine import Pin, Timer
import time

p = Pin('PA5') # PA5 has TIM2, CH1
tim = Timer(2, freq=4000)
ch = tim.channel(1, Timer.PWM, pin=p)
ch.pulse_width_percent(50)
for d in range(100, 0.1):
	ch.pulse_width_percent(d)
	time.sleep(0.01)
```
