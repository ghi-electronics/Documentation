# Sound

---

`Beep()` uses any pin to generate a tone.  

This example code will generate beep on pin 0 and on-board piezo buzzer at frequency 256Hz for one second.

### [Python](#tab/py)
- **Beep(pin, frequency, duration)** - creates a tone for a specified duration on any pin <br>
**pin:** pin number, 'p' used with on-board piezo buzzer <br>
**frequency:** The frequency in Hz, max value is 10KHz <br>
**duration:** The duration of the beep in milliseconds, max value is 1000ms <br>

```py
duelink.Sound.Beep(0, 256, 1000)

duelink.Sound.Beep('p', 256, 1000)
```

### [JavaScript](#tab/js)
- **Beep(pin, frequency, duration)** - creates a tone for a specified duration on any pin <br>
**pin:** pin number, 'p' used with on-board piezo buzzer <br>
**frequency:** The frequency in Hz, max value is 10KHz <br>
**duration:** The duration of the beep in milliseconds, max value is 1000ms <br>

```js
await duelink.Sound.Beep(0, 256, 1000)

await duelink.Sound.Beep('p', 256, 1000)
```

### [.NET](#tab/net)
- **Beep(pin, frequency, duration)** - creates a tone for a specified duration on any pin <br>
**pin:** pin number, 'p' used with on-board piezo buzzer <br>
**frequency:** The frequency in Hz, max value is 10KHz <br>
**duration:** The duration of the beep in milliseconds, max value is 1000ms <br>
```cs
duelink.Sound.Beep(0, 256, 1000)

duelink.Sound.Beep('p', 256, 1000)
```

### [DUE Script](#tab/due)
- **Beep(pin, frequency, duration)** - creates a tone for a specified duration on any pin <br>
**pin:** pin number, 'p' used with on-board piezo buzzer <br>
**frequency:** The frequency in Hz, max value is 10KHz <br>
**duration:** The duration of the beep in milliseconds, max value is 1000ms <br>

```
Beep(0,256,1000)

Beep('p',256,1000)
```
---
> [!NOTE] 
> This feature is blocking, so the rest of your code will stop until `Beep()` is completed. 