## Distance Sensor

This function is used when using a distance sensors. 

- **ReadDistance(trigger, echo)** - uses ultrasonic sonic sensor to read distance.<br>
**trigger:** The pin number that is connected to trigger (pulse) signal<br>
**echo:**  The pin number that is connected to echo signal, use `-1` for single pin <br>
**Returns:**  Distance in centimeters

> [!TIP]
> most sensors need 5V to work.

```basic
@Loop
x = ReadDistance(0,1) 
If x>0 
    PrintLn(x)
End
Wait(100)
Goto Loop
```
---

