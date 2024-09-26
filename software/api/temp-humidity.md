# Temperature and Humidity 

Works with the DHT line of low-cost temperature & humidity sensors. 

- **Temperature.Read(pin, type)** - Reads sensor temperature data on connected pin <br>
**pin:** pin number <br>
**type:** DHT11 = 11, DHT12 = 12, DHT22 = 22, DHT21 = 21 <br>
**Returns:** Temperature in Celsius. 

- **Humidity.Read(pin, type)** - Reads sensor humidity data on connected pin <br>
**pin:** pin number <br>
**type:** DHT11 = 11, DHT12 = 12, DHT22 = 22, DHT21 = 21 <br>
**Returns:** Humidity level 0 to 100.

This example reads temperature and humidity every one second, using DHT11 sensor and connected to pin 0.

### [Python](#tab/py)
```basic
while True:
    print(duelink.Humidity.Read(0, duelink.HumiditySensorType.DHT11))
    print(duelink.Temperature.Read(0, duelink.TemperatureSensorType.DHT11))

    time.sleep(1)
```

### [JavaScript](#tab/js)
```basic
while (true)
{
    console.log(await duelink.Humidity.Read(0, duelink.Humidity.DHT11))
    console.log(await duelink.Temperature.Read(0, duelink.Temperature.DHT11))

    await Util.sleep(1000)
}
```

### [.NET](#tab/net)
```basic
while (true)
{
    Console.WriteLine(duelink.Humidity.Read(0, HumiditySensorType.DHT11));
    Console.WriteLine(duelink.Temperature.Read(0, TemperatureSensorType.DHT11));

    Thread.Sleep(1000);
}
```

### [DUE Script](#tab/due)
- **Temp(pin, type)** - Reads sensor temperature data on connected pin <br>
**pin:** pin number <br>
**type:** DHT11 = 11, DHT12 = 12, DHT22 = 22, DHT21 = 21 <br>
**Returns:** Temperature in Celsius. 

- **Humidity(pin, type)** - Reads sensor humidity data on connected pin <br>
**pin:** pin number <br>
**type:** DHT11 = 11, DHT12 = 12, DHT22 = 22, DHT21 = 21 <br>
**Returns:** Humidity level 0 to 100.
```basic
@Loop
c = Temp(0,11)
h = Humidity(0,11)

#Convert Celsius to Fahrenheit
f = (c*1.8)+32

PrintLn("Current Temperature Celsius = ", c)
PrintLn("Current Temperature Fahrenheit = ", f)
PrintLn("Current Humidity is = ", h)

Wait(200)
Goto Loop
```
---