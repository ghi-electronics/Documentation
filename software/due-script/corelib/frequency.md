# Frequency

This hardware-backed feature generates frequencies/signals on a pin. Since this is hardware-backed, it only works on specific pin(s) and it is very accurate. It requires no system resources to run and therefore, the function is non-blocking. This signal can be used as PWM for power level control (similar to analog out). It can also be used to control servos, generate tones...etc.

See the specific hardware's page pin-out for details on supported pin(s). 

This example will do a loop that generates 20Hz tp 1000Hz after every 200ms.

### [Python](#tab/py)
- **Freq(pin, frequency, duration = 0, dutyCycle = 50)** - provides an accurate hardware generated PWM signal <br>
**pin:** hardware specific pin number or 'p' for on-board piezo buzzer <br>
**frequency:** frequency in Hz, min 15Hz, max 10000000Hz (10MHz) <br>
**duration:** 0 to forever <br>
**dutyCycle:** 0.0 to 100.0

```py
while True:
    for x in range(20, 1000):
        duelink.Frequency.Write('p', x, 200, 50)
        time.sleep(0.2)
    
```

### [JavaScript](#tab/js)
- **Freq(pin, frequency, duration = 0, dutyCycle = 50)** - provides an accurate hardware generated PWM signal <br>
**pin:** hardware specific pin number or 'p' for on-board piezo buzzer <br>
**frequency:** frequency in Hz, min 15Hz, max 10000000Hz (10MHz) <br>
**duration:** 0 to forever <br>
**dutyCycle:** 0.0 to 100.0

```js
while (true)
{
    for (let x = 20; x < 1000; x++)
    {
        await duelink.Frequency.Write('p', x, 200, 50);
        await Util.sleep(200)
    }

}
```

### [.NET](#tab/net)
- **Frequency.Write(int pin, int frequency, int duration = 0, float dutyCycle = 50)** - provides an accurate hardware generated PWM signal <br>
**pin:** hardware specific pin number or 'p' for on-board piezo buzzer <br>
**frequency:** frequency in Hz, min 15Hz, max 10000000Hz (10MHz) <br>
**duration:** 0 to forever <br>
**dutyCycle:** 0.0 to 100.0

```cs
while (true)
{
    for (var x = 20; x < 1000; x++)
    {
        duelink.Frequency.Write('p', x, 200, 50);
        Thread.Sleep(200);
    }

}
```

### [DUE Script](#tab/due)
- **Freq(pin, frequency, duration, dutyCycle)** - provides an accurate hardware generated PWM signal <br>
**pin:** hardware specific pin number or 'p' for on-board piezo buzzer <br>
**frequency:** frequency in Hz, min 15Hz, max 10000000Hz (10MHz) <br>
**duration:** 0 to forever <br>
**dutyCycle:** 0 to 100

```basic
@Loop
For x=20 to 1000
    Freq('p',x,200,50)
    Wait(200)
Next
Goto Loop
```

___
___

Since `Freq()` is a non-blocking function, it will return immediately even if duration is set to a future time. Making a second call to **Freq()** will terminate any existing active frequency, despite the duration of previous calls argument.

In this example, 1KHz will be generated for only 2 seconds and not 5 seconds.

### [Python](#tab/py)
```py
duelink.Frequency.Write('p', 1000, 5000, 50)
time.sleep(2)
duelink.Frequency.Write('p', 0, 0, 0)
```

### [JavaScript](#tab/js)
```js
await duelink.Frequency.Write('p', 1000, 5000, 50)
await Util.sleep(2000)
await duelink.Frequency.Write('p', 0, 0, 0)
```

### [.NET](#tab/net)
```cs
duelink.Frequency.Write('p', 1000, 5000, 50);
Thread.Sleep(2000);
duelink.Frequency.Write('p', 0, 0, 0);
```

### [DUE Engine](#tab/due)
```
Freq('p',1000,5000,50)
Wait(2000)
Freq('p',0,0,0)
```

---