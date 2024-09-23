# Servo Motor

- **ServoSet(pin, degree)** - Sets servo motor connected to pin to a specific position<br>
**pin:** pin number  <br>
**degree:**  0 to 180

> [!TIP] 
> Many servo motors need 5V to work.

### [Python](#tab/python)
```basic
example
```

### [.NET](#tab/net)
```basic
example
```

### [JavaScript](#tab/javascript)
```basic
example
```

### [DUE Engine](#tab/dueengine)
```basic
@Loop
ServoSet(0,0)
Wait(1000)
ServoSet(0,180)
Wait(1000)
Goto Loop
```
---