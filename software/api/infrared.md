# Infrared

IR decoder only works on specific pin(s).

See the specific hardware's page pin-out for details on supported pin(s). 

This example will enable and read IR code from pin 2.

### [Python](#tab/py)
- **Infrared.Enable(int pin,bool enable)** - enables pin for IR signal capture <br>
**pin:** pin number <br>
**enable:** True = enable, False = disable <br>

- **Infrared.Read()** - reads the value from the IR enabled pin <br>
**Return:** Tracks the past 16 key presses and returns them. -1 if none.

```py
duelink.Infrared.Enable(2, True)

while True:
    x = duelink.Infrared.Read()
    if x >= 0:
        print (x)
        
    time.sleep(1)

```

### [JavaScript](#tab/js)
- **Infrared.Enable(pin,enable)** - enables pin for IR signal capture <br>
**pin:** pin number <br>
**enable:** true = enable, false = disable <br>

- **Infrared.Read()** - reads the value from the IR enabled pin <br>
**Return:** Tracks the past 16 key presses and returns them. -1 if none.

```js
await duelink.Infrared.Enable(2, true)

while (true)
{
    let x = await duelink.Infrared.Read()

    if (x >=0)                
        console.log(x)

     await Util.sleep(1000)
                
}
```

### [.NET](#tab/net)
- **Infrared.Enable(int pin,bool enable)** - enables pin for IR signal capture <br>
**pin:** pin number <br>
**enable:** true = enable, false = disable <br>

- **Infrared.Read()** - reads the value from the IR enabled pin <br>
**Return:** Tracks the past 16 key presses and returns them. -1 if none.

```cs
duelink.Infrared.Enable(2, true);

while (true)
{
    var x = duelink.Infrared.Read();

    if (x >=0)                
        Console.WriteLine(x);

    Thread.Sleep(1000);
                
}
```

### [DUE Script](#tab/due)
- **IrEnable(pin,enable)** - enables pin for IR signal capture <br>
**pin:** pin number <br>
**enable:** 1 = enable, 0 = disable <br>

- **IrRead()** - reads the value from the IR enabled pin <br>
**Return:** Tracks the past 16 key presses and returns them. -1 if none.

```
IrEnable(2,1)
@Loop
  x=IrRead()
  if x >=0: PrintLn(x):end
  Wait(1000)
goto Loop
```
---
