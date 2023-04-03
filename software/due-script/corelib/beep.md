## Beep

Beep uses any pin to generate a tone. 

- **Beep(pin, frequency, duration)** - creates a tone for a specified duration on any pin <br>
**pin:** pin number <br>
**frequency:** The frequecy in Hz, max value is 10KHz <br>
**duration:** The duration of the beep in milliseconds, max value is 1000ms <br>

> [!TIP] 
> [Sound](sound.md) function can be used on device specific hardware like the BrainPad Pulse. You can also access any DUE enabled device that has an on-board buzzer by using pin 100 Beep() function arguement.


```basic
Beep(0,256,1000)
```
---
> [!NOTE] 
> This feature is blocking,so the rest of your code will stop until beep is completed. 