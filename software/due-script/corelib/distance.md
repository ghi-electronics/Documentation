## Distance Sensor

This function is used when using a distance sensors. 

- **ReadDistance(trigger, echo)** - uses ultrasonic sonic sensor to read distance.<br>
**trigger:** The pin number that is connected to trigger (pulse) signal<br>
**echo:**  The pin number that is connected to echo signal<br>
**Returns:**  Distance in centimeters

> [!TIP]
> most sensors need 5V to work.

```basic
@Loop
x = Distance(0,1) 
if x>0 
    PrintLn(x)
end
Wait(100)
goto Loop
```
---

