## Frequency

This hardware-backed feature generates frequencies/signals on a pin. Since this is hardware-backed, it only works on specific pin(s) and it is very accurate. It requires no system resources to run and therefore, the function is non-blocking. This signal can be used as PWM for power level control (similar to analog out). It can also be used to control servos, generate tones...etc.

See the specific hardware's page pin-out for details on supported pin(s). 

- **Freq(pin, frequency, duration, dutyCycle)** - provides an accurate hardware generated PWM signal <br>
**pin:** hardware specific pin number or 'p' for on-board piezo buzzer <br>
**frequency:** frequency in KHz <br>
**duration:** 0 to forever <br>
**dutyCycle:** 0 to 100

```basic
@Loop
For x=1 to 1000
    Freq('p',x,200,50)
    Wait(200)
Next
For x=1000 to 1 step -1
    Freq('p',x,200,50)
    Wait(200)
Next
Goto Loop
```

Since **Freq()** is a non-blocking function, it will return immediately even if duration is set to a future time. Making a second call to **Freq()** will terminate any existing active frequency, despite the duration of previous calls argument.

In this example, 1Khz will be generated for only 2 seconds and not 5 seconds.

```basic
Freq('p',1000,5000,50)
Wait(2000)
Freq('p',0,0,0)
```

---