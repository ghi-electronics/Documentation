# Digital

These functions provide access to digital pins.

## Digital Read

Read the current value of a digital pin.

This example will read current value on pin 2.

### [Python](#tab/py)
- **Digital.Read(pin, pull)** <br>
**pin:** pin number <br> 
**pull:** Sets the internal pull resistors: 'None', 'PullUp', 'PullDown' <br>
**Returns:** True = high or  False = low 

```py
x = duelink.Digital.Read(2, 'PullUp')
print(x)
```

### [JavaScript](#tab/js)
- **Digital.Read(pin, pull)** <br>
**pin:** pin number <br> 
**pull:** Sets the internal pull resistors: 'None', 'PullUp', 'PullDown' <br>
**Returns:** True = high or  False = low 

```js
let x = await duelink.Digital.Read(2, 'PullUp')
console.log(x)
```

### [.NET](#tab/net)
- **Digital.Read(pin, pull)** <br>
**pin:** pin number <br> 
**pull:** Sets the internal pull resistors: 'None', 'PullUp', 'PullDown' <br>
**Returns:** True = high or  False = low 

```cs
var x = duelink.Digital.Read(2, InputType.PullUp);
Console.WriteLine(x);
```

### [DUE Script](#tab/due)
- **DRead(pin, pull)** <br>
**pin:** pin number <br> 
**pull:** Sets the internal pull resistors to -> 0=none, 1=up, 2=down <br>
**Returns:** 1 = high or  0 = low 

```
x = DRead(2,1)
If x = 0
    Print("low")
Else
    Print("high")
End
```

---

---

## Digital Write
Sets a pin digital output.

This example will set pin 2 to be High.

### [Python](#tab/py)
- **Digital.Write(pin, state)** <br>
**pin:** pin number <br> 
**state:** True = high or  False = low <br>

```py
duelink.Digital.Write(2, True)
```

### [JavaScript](#tab/js)
- **Digital.Write(pin, state)** <br>
**pin:** pin number <br> 
**state:** true = high or  false = low <br>

```js
duelink.Digital.Write(2, true)
```

### [.NET](#tab/net)
- **Digital.Write(int pin, bool state)** <br>
**pin:** pin number <br> 
**state:** true = high or  false = low <br>

```cs
duelink.Digital.Write(2, true);
```

### [DUE Script](#tab/due)
- **DWrite(pin, state)**  <br>
**pin:** pin number <br> 
**state:** 1 = high or 0 = low

```
DWrite(2,1)
```
---