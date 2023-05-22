## Temperature and Humidity 

Works with the DHT line of low-cost temperature & humidity sensors. 

- **Temp(pin, type)** - Reads sensor temperature data on connected pin <br>
**pin:** pin number <br>
**type:** DHT11 = 11, DHT12 = 12, DHT22 = 22, DHT21 = 21 <br>
**Returns:** Temperature in Celsius. 

- **Humidity(pin, type)** - Reads sensor humidity data on connected pin <br>
**pin:** pin number <br>
**type:** DHT11 = 11, DHT12 = 12, DHT22 = 22, DHT21 = 21 <br>
**Returns:** Humidity level 0 to 100.

This example reads temperature and humidity, and converts celsuis to Fahrenheit and displays 

```basic
@Loop
t = Temp(0,11)
h = Humidity(0,11)

#Convert Celsius to Fahrenheit
f = (t*1.8)+32

PrintLn("Current Celsius Temperature = ", t)
PrintLn("Current Humidity is = ", h)
PrintLn("Current Fahrenheit Temperature = ", f)

Wait(200)
Goto Loop
```
---