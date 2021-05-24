# GPIO

---

Microcontrollers include pins that can be controlled through software. They can be logical inputs or outputs, hence the name "general purpose input/output".

The `Pin` class is uses to access GPIOs, located in the `machine` library.

```
from machine import Pin
```

## Digital Outputs

A digital output pin can be set to either high or low. High means that there is approx. 3.3V on the output pin. When the pin is set to low, it's voltage will be very close to zero.

```
led=Pin("PA8",Pin.OUT_PP)
led.high()
```

## Digital Inputs

Digital inputs sense the state of a pin based on its voltage. Minimum voltage on most pins is 0 volts; a negative voltage may damage the pin or the processor. Most processors run on 3.3V, the highest voltage a pin should see is 3.3V. However, some processors that are powered by 3.3V are 5V tolerant -- they can withstand up to 5V on their inputs. SITCore is 5V tolerant.

> [!Warning] 
> 5V tolerant doesn't mean the processor can be powered by 5V, only that the input pins can tolerate 5V.

Unconnected input pins are called "floating." A resistor can be added to pull the pin high or low. Modern processors include internal pull-up and pull-down resistors that are controlled by software.

The code sample below uses an internal pull-up resistor to set the button high. When the button is pressed the `GpioPinValue` goes low. 

```
button = Pin("PB7", Pin.IN, Pin.PULL_UP)
button.value()
```

## Digital Input Interrupts

Instead of polling a pin to determine it state, a function can be called when a pin is changed.

```
def ButtonHandler(p)
	print("Pressed", p)

button = Pin("PB7", Pin.IN, Pin.PULL_UP)
button.irq(trigger=Pin.IRQ_FALLING, handler=ButtonHandler)
```

Whenever the button is pressed (Falling Edge), the `print` will show "Button" flowed by the pin that caused the event. In this case it will show:

```
Button Pin(Pin.cpu.B7, mode=Pin.IN, pull=Pin.PULL_UP)
```

For further clarification, try `print(button)` and observe the output `Pin(Pin.cpu.B7, mode=Pin.IN, pull=Pin.PULL_UP)`.

