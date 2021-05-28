# Analog In

---

Unlike digital input pins, which can only read high or low, analog pins can read a range of voltage levels.  Microcontrollers based on 3.3V can typically read voltages anywhere between zero and 3.3V. Analog inputs connect internally to an Analog to Digital Converter (ADC) that converts the analog voltage level on the pin to a digital value.

```py
import machine
adc = machine.ADC(machine.Pin('PA5')) 
adc.read_u16()
```