# Analog

These functions provide access to analog pins. 

## Analog Write

This feature uses software-generated PWM to control the "Analog" level of a pin. It has a fixed frequency of 50Hz.

This example code will swing the analog output value up and down in a loop.

### [Python](#tab/py)

**Analog.Write( pin, dutyCycle)**<br>
**pin:** pin number<br>
**dutyCycle:** 0 to 100

```python
while True:
	for i in range(0, 100, 10):
		duelink.Analog.Write('L', i)
		time.sleep(0.1)

	for i in range(90, -1, -10):
		duelink.Analog.Write('L', i)
		time.sleep(0.1)
```



### [JavaScript](#tab/js)
**Analog.Write(pin, dutyCycle)**<br>
**pin:** pin number<br>
**dutyCycle:** 0 to 100

```js
while (true) {
	for (let i = 0; i < 100; i+=10) {
		await duelink.Analog.Write('L', i);
		await Util.sleep(100)
	}

	for (let i = 90; i > -1; i-=10) {
		await duelink.Analog.Write('L', i);
		await Util.sleep(100)
	}
}
```

### [.NET](#tab/net)
**Analog.Write(int pin, float dutyCycle)**<br>
**pin:** pin number<br>
**dutyCycle:** 0 to 100

```cs
while (true) {
	for (var i = 0; i < 100; i+=10) {
		duelink.Analog.Write('L', i);
		Thread.Sleep(100);
	}

	for (var i = 90; i > -1; i-=10) {
		duelink.Analog.Write('L', i);
		Thread.Sleep(100);
	}
}
```

### [DUE Script](#tab/due)
**AWrite(pin, dutyCycle)**<br>
**pin:** pin number<br>
**dutyCycle:** 0 to 100

```
@Loop
For i=0 to 100 Step 10
    AWrite('L',i)
    Wait(100)
next
For i=100 to 0 Step -10
    AWrite('L',i) 
    Wait(100)
Next
Goto Loop
```
---

This feature works on all pins.

---

## Analog Read

Use this function to read the analog level on a specific pin.

This is an example code to read the analog level on pin 0 and print out to the console 10 times per second.

### [Python](#tab/py)
**Analog.Read(pin)**<br>
**pin:** pin number <br>
**Returns:** The analog value (0-100) of the pin 

```python
while True:
	x = duelink.Analog.Read(0)
	print(x)
	time.sleep(0.1)
```

### [JavaScript](#tab/js)
**Analog.Read(pin)**<br>
**pin:** pin number <br>
**Returns:** The analog value (0-100) of the pin 

```js
while (true) {
	let x = await duelink.Analog.Read(0)
	console.log(x)
	await Util.sleep(100)

}

```

### [.NET](#tab/net)
**int Analog.Read(int pin)**<br>
**pin:** pin number <br>
**Returns:** The analog value (0-100) of the pin 

```cs
while (true) {
	var x = duelink.Analog.Read(0);
	Console.WriteLine(x);
	Thread.Sleep(100);
}
```

### [DUE Script](#tab/due)
**ARead(pin)**<br>
**pin:** pin number <br>
**Returns:** The analog value (0-100) of the pin 

```
@Loop
For i=0 to 100
    x=ARead(0)
    PrintLn(x)  
    Wait(100)
Next
Goto Loop
```
---


Some pins may not support analog read. Check the hardware page for a list of supported pins.