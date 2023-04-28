## Digital

These functions provide access to digital pins.

**Digital Read**

- **DRead(pin, pull)** - Read a digital pin output <br>
**pin:** pin number <br> 
**pull:** Sets the internal pull resistors to -> 0=none, 1=up, 2=down <br>
**Returns:** 1 = high or  0 = low 

> [!NOTE]
> Pin numbers can also be **'a'** or **'b'** when reading the on-board buttons. Using 'a', 'A', or 97 yields the same results.

```basic
x = DRead(2,1)
If x = 0
    Print("low")
Else
    Print("high")
End
```

**Digital Write**
- **DWrite(pin, state)**  - Sets a pins digital output <br>
**pin:** pin number <br> **state:** 1 = high or 0 = low

> [!NOTE]
> Pin numbers can also be **'l'** when writing the on-board LED. Using 'l', 'L', or 108 yields the same results.

```basic
for x = 1 to 10
    DWrite('L',1)
    Wait(200)
    DWrite('L',0)
    Wait(200)
next
```


> [!NOTE]
> All DUE enabled hardware's on-board
LED is found on pin 100.


---