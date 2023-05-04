## Beep

Beep uses any pin to generate a tone. 

- **Beep(pin, frequency, duration)** - creates a tone for a specified duration on any pin <br>
**pin:** pin number <br>
**frequency:** The frequency in Hz, max value is 10KHz <br>
**duration:** The duration of the beep in milliseconds, max value is 1000ms <br>

> [!TIP] 
> This function does not support the on-board buzzer on BrainPad pulse, use [Sound](sound.md) function instead. 

```basic
Beep(0,256,1000)
```
---
> [!NOTE] 
> This feature is blocking, so the rest of your code will stop until `Beep()` is completed. 