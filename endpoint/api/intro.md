# Libraries
---
## Microsoft standard .NET libraries

Endpoint uses the standard .NET libraries when available. A good example of this is the .NET GPIO library.

```cs
using System.Device.Gpio;
using System.Device.Gpio.Drivers;
using static GHIElectronics.Endpoint.Core.EPM815;

var port = EPM815.Gpio.Pin.PD14 /16;
var pin = EPM815.Gpio.Pin.PD14 % 16;

var gpioDriver = new LibGpiodDriver((int)port);
var gpioController = new GpioController(PinNumberingScheme.Logical, gpioDriver);

gpioController.OpenPin(pin);
gpioController.SetPinMode(pin, PinMode.Output);

while (true) {
    gpioController.Write(pin, PinValue.High);
    Thread.Sleep(100);
    gpioController.Write(pin, PinValue.Low);
    Thread.Sleep(100);
}
```
---

## Endpoint Libraries
When a library doesn't existing inside the .NET API relating to embedded hardware we create one to fill in the missing gaps. A good example of this is the Endpoint ADC library. 

```cs
using GHIElectronics.Endpoint.Core;
using GHIElectronics.Endpoint.Devices.Adc;

var adcController = new AdcController(EPM815.Adc.Pin.ANA1); 

while (true){
    var v = adcController.Read();
    var v1 = (v * 3.3 / 65535);
    Console.WriteLine(v1.ToString());
    Thread.Sleep(1000);
}
```


<!--- Use this link when testing locally-->

[**Complete Endpoint API**](http://localhost:8080/endpoint/api/GHIElectronics.Endpoint.html)


<!--- Use this link when building and deploying-->

<!---
[**Complete Endpoint API**](http://https://docs.ghielectronics.com/endpoint/api/GHIElectronics.Endpoint.html)
-->


---

You can also visit our main website at [**main website**](http://www.ghielectronics.com) and our  [**community forum**](https://forums.ghielectronics.com/).
