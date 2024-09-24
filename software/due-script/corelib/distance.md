# Distance Sensor

This function is used when using a distance sensors. 


> [!TIP]
> Most sensors need 5V to work.

This example will read distance, using pin 0 for trigger and pin 1 for echo pin.

### [Python](#tab/py)
- **Distance.Read(trigger, echo)** - uses ultrasonic sonic sensor to read distance.<br>
**trigger:** The pin number that is connected to trigger (pulse) signal<br>
**echo:**  The pin number that is connected to echo signal, use `-1` for single pin <br>
**Returns:**  Distance in centimeters

```py
while True:
    x = duelink.Distance.Read(0, 1)

    if x > 0:
        print(x)

    time.sleep(0.1)
}
```

### [JavaScript](#tab/js)
- **Distance.Read(trigger, echo)** - uses ultrasonic sonic sensor to read distance.<br>
**trigger:** The pin number that is connected to trigger (pulse) signal<br>
**echo:**  The pin number that is connected to echo signal, use `-1` for single pin <br>
**Returns:**  Distance in centimeters

```js
while (true) {
    let x = await duelink.Distance.Read(0, 1)

    if (x > 0)
        console.log(x)

    await Util.sleep(100)
}
```

### [.NET](#tab/net)
- **Distance.Read(trigger, echo)** - uses ultrasonic sonic sensor to read distance.<br>
**trigger:** The pin number that is connected to trigger (pulse) signal<br>
**echo:**  The pin number that is connected to echo signal, use `-1` for single pin <br>
**Returns:**  Distance in centimeters

```cs
while (true) {
    var x = duelink.Distance.Read(0, 1);

    if (x > 0)
        Console.WriteLine(x);

    Thread.Sleep(100);
}
```

### [DUE Script](#tab/due)
- **ReadDistance(trigger, echo)** - uses ultrasonic sonic sensor to read distance.<br>
**trigger:** The pin number that is connected to trigger (pulse) signal<br>
**echo:**  The pin number that is connected to echo signal, use `-1` for single pin <br>
**Returns:**  Distance in centimeters

```basic
@Loop
x = ReadDistance(0,1) 
If x>0 
    PrintLn(x)
End
Wait(100)
Goto Loop
```
---

