# Infrared

IR decoder is fixed to pin 2 and 8

- **IrEnable(pin,enable)** - enables pin for IR signal capture <br>
**pin:** 2 or 8 <br>
**enable:** 1 = enable, 0 = disable <br>

- **IrRead()** - reads the value from the IR enabled pin <br>
**Return:** Tracks the past 16 key presses and returns them. -1 if none.

### [Python](#tab/python)
```basic
example
```

### [.NET](#tab/net)
```basic
example
```

### [JavaScript](#tab/javascript)
```basic
example
```

### [DUE Engine](#tab/dueengine)
```basic
IrEnable(2,1)
@Loop
  x=IrRead()
  if x >=0: PrintLn(x):end
  Wait(1000)
goto Loop
```
---
