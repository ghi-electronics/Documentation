# Libraries
---
## Microsoft standard .NET libraries

Endpoint uses the standard [.NET 8 API](https://learn.microsoft.com/en-gb/dotnet/api/?view=net-8.0) including the [.NET IoT API](https://learn.microsoft.com/en-gb/dotnet/api/?view=iot-dotnet-latest). A good example of this is the .NET GPIO library API.

```cs
using System.Device.Gpio;
using System.Device.Gpio.Drivers;
using GHIElectronics.Endpoint.Core;

var port = EPM815.Gpio.Pin.PC0 /16;
var pin = EPM815.Gpio.Pin.PC0 % 16;

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
Additional [**Endpoint APIs**](/endpoint/api/GHIElectronics.Endpoint.html) are implemented to cover missing hardware related features not found in the official .NET libraries.

A good example of this is the Endpoint ADC library. 

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
