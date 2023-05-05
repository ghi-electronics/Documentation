## Analog

These functions provide access to analog pins. 

##### Analog Write

- **AWrite(pin, dutyCycle)**  - Writes to pin using PWM <br>
**pin:** pin number<br>
**dutyCycle:** 0 to 1000

> [!NOTE] 
> Frequency is fixed to 50hz.

```basic
@Loop
For i=0 to 1000 Step 100
    AWrite("L",i)
    Wait(100)
next
For i=1000 to 0 Step -100
    AWrite("L",i) 
    Wait(100)
Next
Goto Loop

```

##### Analog Read

- **ARead(pin)**  - Read an analog output <br>
**pin:** pin number <br>
**Returns:** The analog value of the pin

Not all pins support `ARead()`. The hardware docs will show what pins support analog, typically labeled ADC. Pins that do not support `ARead()` will return 0.

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