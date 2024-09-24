# Servo Motor

- **ServoSet(pin, degree)** - Sets servo motor connected to pin to a specific position<br>
**pin:** pin number  <br>
**degree:**  0 to 180

> [!TIP] 
> Many servo motors need 5V to work.

### [Python](#tab/py)
```basic
example
```

### [.NET](#tab/net)
```basic
example
```

### [JavaScript](#tab/js)
```basic
example
```

### [DUE Script](#tab/due)
```basic
@Loop
ServoSet(0,0)
Wait(1000)
ServoSet(0,180)
Wait(1000)
Goto Loop
```
---