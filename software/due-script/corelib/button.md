## Buttons

Buttons as a function are only available using pin 0,1,2,A,or B. Alternatively, `DRead()` can be used with any pin.

- **BtnEnable(pin, enable)** - sets up a button to be used <br>
**pin:** pin number, 'a', or 'b' <br>
**enable:** 1 = enable, 0 = disabled  <br>

- **BtnUp(pin)**  <br>
**pin:** pin number, 'a', or 'b' <br>
**Returns:** 1 after release first time called. If called again returns 0<br>

 - **BtnDown(pin)** Returns a value when button is pressed<br>
**pin:** pin number, 'a', or 'b' <br>
**Returns:** 1 if button was pressed and continues to return 1 until the button is released

> [!NOTE] 
> **'a'** is ASCII a or 97, **'b'** is ASCII b or 98. Using 'a', 'A', or 97 yields the same results.

> [!TIP] 
> The timeout for **BtnDown()** or **BtnUp()** is fixed to two seconds. Calling after two seconds from last press or release returns 0. If the button is not enabled also returns 0

```basic
BtnEnable('a',1)
@Loop
x=BtnDown('a')
If x=1
    PrintLn("Button A")
End
Goto Loop
```
---


