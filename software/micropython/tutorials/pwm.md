# PWM

---

Pulse Width Modulation is used to generate frequencies on a pin, or to control the level of power given to a pin.

Current implementation prides PWM through `Timer`.

This example will sweep through frequency:

```py
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

```py
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
