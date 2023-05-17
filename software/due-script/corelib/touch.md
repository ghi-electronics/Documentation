## Touch

This feature allows sensing of a finger or human touch to a pin. This requires an external 100pf capacitor between the pin and GND. The caps are already found on BrainPad boards pads 0, 1, and 2.

- **TouchRead(pin)** - Initializes the pin for touch   <br>
**pin:** pin number<br>
**Returns:** 0 = not touch or 1 = touched

```basic
@Loop
a=TouchRead(0):b=TouchRead(1):c=TouchRead(2)
If a>0:PrintLn("pin 0"):End 
If b>0:PrintLn("pin 1"):End
If c>0:PrintLn("pin 2"):End 
Wait(100)
Goto Loop
```
---