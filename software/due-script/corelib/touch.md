# Touch

This feature allows sensing of a finger or human touch to a pin. This requires an external 100pf capacitor between the pin and GND. The caps are already found on BrainPad boards pads 0, 1, and 2.

When using a touch screen like found on the BrainPad Rave use 'x' or 'y' to return the x & y positions where the screen is being touched. 

- **TouchRead(pin)** - Initializes the pin for touch, or reads the x y position on a touch screen   <br>
**pin:** pin number, 'x', or 'y' <br>
**pin Returns:** 0 = pin not touch, 1 = pin touched <br>
**x or y Returns:** x position , or y position, -1 = screen not touched

```basic
@Loop
# Pin touch
a=TouchRead(0):b=TouchRead(1):c=TouchRead(2)
If a>0:PrintLn("pin 0"):End 
If b>0:PrintLn("pin 1"):End
If c>0:PrintLn("pin 2"):End 

# Prints x & y coordinates from touch screen to the Due Console Log window
x = TouchRead('x')
y = TouchRead('y')
LogLn(x)
LogLn(y)

Wait(100)
Goto Loop
```
---