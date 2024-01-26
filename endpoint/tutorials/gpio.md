# General Purpose Input Output (GPIO)
---
Microcontrollers include pins that can be controlled through software. They can be logical inputs or outputs, hence the name "general purpose input/output".

> [!Tip]
> GPIO is found in the System.Device.Gpio and System.Device.Gpio.Drivers of the standard .NET API. These libraries are automatically imported when installing NuGet package GHIElectronics.Endpoint.Core 

## Digital Outputs
A digital output pin can be set to either high or low.  High means that there is approx. 3.3V on the output pin. When the pin is set to low, it's voltage will be very close to zero.

> [!Warning]
> Never connect two output pins together. If they are connected and one is high and the other is low, the entire processor can be damaged.

> [!Tip]
> Digital pins on microcontrollers are weak. They can only be used to control small LEDs or drive transistors. Those transistors can, in turn, control devices with high power needs like a motor.

```cs
using System.Device.Gpio;
using System.Device.Gpio.Drivers;
using GHIElectronics.Endpoint.Core;

var port = EPM815.Gpio.Pin.PC0 / 16;
var pin = EPM815.Gpio.Pin.PC0 % 16;

var gpioDriver = new LibGpiodDriver((int)port);
var gpioController = new GpioController(PinNumberingScheme.
    Logical, gpioDriver);

gpioController.OpenPin(pin);
gpioController.SetPinMode(pin, PinMode.Output);

while (true){
    gpioController.Write(pin, PinValue.High);
    Thread.Sleep(100);
    gpioController.Write(pin, PinValue.Low);
    Thread.Sleep(100);
}
```
---

## Digital Inputs
Digital inputs sense the state of a pin based on its voltage. Minimum voltage on most pins is 0 volts; a negative voltage may damage the pin or the processor. Most processors run on 3.3V, the highest voltage a pin should see is 3.3V. However, some processors that are powered by 3.3V are 5V tolerant -- they can withstand up to 5V on their inputs. SITCore is 5V tolerant.

> [!Warning] 
> 5V tolerant doesn't mean the processor can be powered by 5V, only that the input pins can tolerate 5V.

Unconnected input pins are called "floating." A resistor can be added to pull the pin high or low. Modern processors include internal pull-up and pull-down resistors that are controlled by software.

The code sample below uses an internal pull-up resistor to set the button high. When the button is pressed the `GpioPinValue` goes low. 

```cs
using System.Device.Gpio;
using System.Device.Gpio.Drivers;
using GHIElectronics.Endpoint.Core;

var port = EPM815.Gpio.Pin.PF3 / 16;
var pin = EPM815.Gpio.Pin.PF3 % 16;

var gpioDriver = new LibGpiodDriver((int)port);
var button = new GpioController(PinNumberingScheme.Logical, gpioDriver);
button.OpenPin(pin, PinMode.InputPullUp);

while (true){
    if (button.Read(pin) == PinValue.Low){
        //Button is pressed.
    }
    Thread.Sleep(10);  
}
```
---

## Digital Input Events

Using events to check an input instead of polling the input (using a loop) is often preferred. The following code demonstrates a GPIO pin event (interrupt) using the F1 user button on Endpoint Domino

You will see a reference to a ```PinEventTypes.Falling``` in the following code. A falling occurs when the state of a pin goes from high to low. A rising is just the opposite -- it occurs when a pin goes from low to high. 

```cs
using System.Device.Gpio;
using System.Device.Gpio.Drivers;
using GHIElectronics.Endpoint.Core;

var port = EPM815.Gpio.Pin.PF3 / 16;
var pin = EPM815.Gpio.Pin.PF3 % 16;

var gpioDriver = new LibGpiodDriver((int)port);
var button = new GpioController(PinNumberingScheme.Logical, gpioDriver);

button.OpenPin(pin, PinMode.InputPullUp);

button.RegisterCallbackForPinValueChangedEvent(
    pin,
    PinEventTypes.Falling | PinEventTypes.Rising,
    OnPinEvent);

//Do other tasks here
await Task.Delay(Timeout.Infinite);

static void OnPinEvent(object sender, PinValueChangedEventArgs args){
    Console.WriteLine("Button Pressed");

}
```

When a mechanical button is pressed it generates multiple edges that are caused by the contact physically bouncing. If debounce is an issue use the [GpioButton Class](https://learn.microsoft.com/en-us/dotnet/api/iot.device.button.gpiobutton?view=iot-dotnet-latest).


## Endpoint Interrupt limitation

Digital input events rely on internal GPIO interrupts to work. On Endpoint, these interrupts are only available on 16 pins at any given time, the pin number must be unique, over all of the available ports. For example: PA1 and PB1 cannot both be used as interrupts at the same time. However, PA1 and PB2, or even PA1 and PA2, can be used simultaneously.




