## Frequency

Frequency is fixed to pin 0
- **Freq(frequency, duration, dutyCycle)** - provides an accurate hardware generated PWM signal <br>
**frequency:** frequency in KHz <br>
**duration:** 0 to forever <br>
**dutyCycle:** 0 to 1000

> [!NOTE] 
> Freq() is a non-blocking function, calling Freq() a second time before the duration of the first call is over will end the function despite the duration of first calls argument.

```basic
@Loop
for x=1 to 1000
    Freq(x,500,500)
    Wait(200)
next
for x=1000 to 1 step -1
    Freq(x,500,500)
    Wait(200)
next
goto Loop
```
---