## Touch

- **TouchRead(pin)** - Initializes the pin for touch   <br>
**pin:** pin number

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