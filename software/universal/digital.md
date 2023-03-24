## Digital

These functions provide access to digital pins.

**Digital Write**
- **DWrite(pin, state)**  - Sets a pins digital output <br>
**pin:** pin number <br> **state:** 1 = high or 0 = low

```basic
for x = 1 to 10
    DWrite(0,1)
    Wait(200)
    DWrite(0,0)
    Wait(200)
next
```

##### Digital Read

- **DRead(pin, pull)** - Read a digital pin output <br>
**pin:** 0-9 <br> 
**pull:** Sets the internal pull resistors to -> 0=none, 1=up, 2=down <br>
**Returns:** 1 = high or  0 = low 

```basic
x = DRead(2,1)
if x = 0
    Print("low")
else
    Print("high")
end
```
---