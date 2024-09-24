# Buttons

The button feature makes it easier to work with buttons, when compared to reading a digital pin for example.

> [!TIP] 
> The timeout for `Button Down` and `Button Up` are fixed to two seconds. Calling after two seconds from last press or release returns 0.

This example checks button 'a'.

### [Python](#tab/py)
- **Button.Enable(pin, enable)** - Activates a pin to be used as a button<br>
**pin:** pin number<br>
**enable:** true = enable, false = disabled  <br>

- **bool Button.JustReleased(pin)** <br>
**pin:** pin number<br>
**Returns:** true after release first time called. If called again returns 0<br>

- **bool Button.JustPressed(pin)** Checks if a button was pressed<br>
**pin:** pin number<br>
**Returns:** true if button was pressed recently and continues to return 1 until the button is released
```py
duelink.Button.Enable('a', True);

while True:
    d = duelink.Button.JustPressed('a')
    u = duelink.Button.JustReleased('a')

    if (d):    
        print("Button A down")
    
    if (u):    
        print("Button A up")
    
    time.sleep(0.2);
```



### [JavaScript](#tab/js)
- **Button.Enable(pin, enable)** - Activates a pin to be used as a button<br>
**pin:** pin number<br>
**enable:** true = enable, false = disabled  <br>

- **bool Button.JustReleased(pin)** <br>
**pin:** pin number<br>
**Returns:** true after release first time called. If called again returns 0<br>

- **bool Button.JustPressed(pin)** Checks if a button was pressed<br>
**pin:** pin number<br>
**Returns:** true if button was pressed recently and continues to return 1 until the button is released

```js
await duelink.Button.Enable('a', true);

while (true) {
    let d = await duelink.Button.JustPressed('a')
    let u = await duelink.Button.JustReleased('a')

    if (d)
    {
        console.log("Button A down")
    }

    if (u)
    {
        console.log("Button A up")
    }
    await Util.sleep(200)
}
```

### [.NET](#tab/net)
- **Button.Enable(int pin, bool enable)** - Activates a pin to be used as a button<br>
**pin:** pin number<br>
**enable:** true = enable, false = disabled  <br>

- **bool Button.JustReleased(int pin)** <br>
**pin:** pin number<br>
**Returns:** true after release first time called. If called again returns 0<br>

- **bool Button.JustPressed(int pin)** Checks if a button was pressed<br>
**pin:** pin number<br>
**Returns:** true if button was pressed recently and continues to return 1 until the button is released

```cs
duelink.Button.Enable('a', true);

while (true) {
    var d = duelink.Button.JustPressed('a');
    var u = duelink.Button.JustReleased('a');

    if (d)
    {
        Console.WriteLine("Button A down");
    }

    if (u)
    {
        Console.WriteLine("Button A up");
    }
    Thread.Sleep(200);
}
```

### [DUE Script](#tab/due)
- **Button.Enable(pin, enable)** - Activates a pin to be used as a button<br>
**pin:** pin number<br>
**enable:** 1 = enable, 0 = disabled  <br>

- **Button.Up(pin)** <br>
**pin:** pin number<br>
**Returns:** 1 after release first time called. If called again returns 0<br>

- **Button.Down(pin)** Checks if a button was pressed<br>
**pin:** pin number<br>
**Returns:** 1 if button was pressed recently and continues to return 1 until the button is released
```
BtnEnable('a',1)

@Loop
d=BtnDown('a')
u=BtnUp('a')
If d=1
    PrintLn("Button A down")
If u=1
    PrintLn("Button A up")
End
Wait(200)
Goto Loop
```
---

This feature is not available on all pins; however, [Digital Read](digital.md) can be used instead, which is available on all pins.

