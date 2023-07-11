## Infrared

IR decoder is fixed to pin 2

- **IrEnable(enable)** - enables pin for IR signal capture <br>
**enable:** 1 = enable, 0 = disable <br>

- **IrRead()** - reads the value from the IR enabled pin <br>
**Return:** Tracks the past 16 key presses and returns them. -1 if none.

```basic
IrEnable(1)
@Loop
x=IrRead()
if x >=0: PrintLn(x):end
Wait(1000)
goto Loop
```
---
