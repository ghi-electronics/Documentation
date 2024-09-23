# Analog

These functions provide access to analog pins. 

## Analog Write

- **AWrite(pin, dutyCycle)**  - Writes to pin using PWM <br>
**pin:** pin number<br>
**dutyCycle:** 0 to 100

> [!NOTE] 
> Frequency is fixed to 50hz.

### [Python](#tab/pythonw)
```basic
example
```

### [.NET](#tab/netw)
```basic
example
```

### [JavaScript](#tab/javascriptw)
```basic
example
```

### [DUE Engine](#tab/dueenginew)
```basic
@Loop
For i=0 to 100 Step 10
    AWrite('L',i)
    Wait(100)
next
For i=100 to 0 Step -10
    AWrite('L',i) 
    Wait(100)
Next
Goto Loop
```

---

## Analog Read

- **ARead(pin)**  - Read an analog output <br>
**pin:** pin number <br>
**Returns:** The analog value (0-100) of the pin 

Not all pins support `ARead()`. The hardware docs will show what pins support analog, typically labeled ADC. Pins that do not support `ARead()` will return 0.

### [Python](#tab/pythonr)
```basic
example
```

### [.NET](#tab/netr)
```basic
example
```

### [JavaScript](#tab/javascriptr)
```basic
example
```

### [DUE Engine](#tab/dueenginer)
```basic
@Loop
For i=0 to 100
    x=ARead(0)
    PrintLn(x)  
    Wait(100)
Next
Goto Loop
```

---