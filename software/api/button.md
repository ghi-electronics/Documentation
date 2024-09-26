# Buttons

The button feature makes it easier to work with buttons, when compared to reading a digital pin for example.

> [!TIP] 
> The timeout for `Button Down` and `Button Up` are fixed to two seconds. Calling after two seconds from last press or release returns 0.

- **Button.Enable(pin, enable)** - Activates a pin to be used as a button<br>
**pin:** pin number<br>
**enable:** true = enable, false = disabled  <br>

- **Button.JustReleased(pin)** <br>
**pin:** pin number<br>
**Returns:** bool - true after release first time called. If called again returns false<br>

- **bool Button.JustPressed(pin)** Checks if a button was pressed<br>
**pin:** pin number<br>
**Returns:** true if button was pressed recently and continues to return 1 until the button is released

This example checks button 'a'.

### [Python](#tab/py)

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
---

This feature is not available on all pins; however, [Digital Read](digital.md) can be used instead, which is available on all pins.

