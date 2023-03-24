## Analog

These functions provide access to analog pins. 

##### Analog Write

- **AWrite(pin, dutyCycle)**  - Writes to pin using PWM <br>
**pin:** pin number<br>
**dutyCycle:** 0 to 1000

> [!NOTE] 
> Frequency is fixed to 50hz.

```basic
@loop
for i=0 to 1000 step 100
    AWrite(0,i)
    Wait(100)
next
for i=1000 to 0 step -100
    AWrite(0,i) 
    Wait(100)
next
goto loop

```

##### Analog Read

- **ARead(pin)**  - Read an analog output <br>
**pin:** pin number <br>
**Returns:** The analog value of the pin

```basic
@loop
for i=0 to 100
    x=ARead(0)
    PrintLn(x)  
    Wait(100)
next
goto loop
```

---