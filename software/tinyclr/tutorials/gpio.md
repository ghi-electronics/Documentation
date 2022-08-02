# General Purpose Input Output (GPIO)
---
Microcontrollers include pins that can be controlled through software. They can be logical inputs or outputs, hence the name "general purpose input/output".

> [!Tip]
> GPIO is found in the GHIElectronics.TinyCLR.Devices.Gpio NuGet package and pin definitions are found in the  GHIElectronics.TinyCLR.Pins package.

## Digital Outputs
A digital output pin can be set to either high or low.  High means that there is approx. 3.3V on the output pin. When the pin is set to low, it's voltage will be very close to zero.

> [!Warning]
> Never connect two output pins together. If they are connected and one is high and the other is low, the entire processor can be damaged.

> [!Tip]
> Digital pins on microcontrollers are weak. They can only be used to control small LEDs or drive transistors. Those transistors can, in turn, control devices with high power needs like a motor.

```cs
var led = GpioController.GetDefault().OpenPin(SC20260.GpioPin.PH6);
led.SetDriveMode(GpioPinDriveMode.Output);

while (true) {
    led.Write(GpioPinValue.High);
    Thread.Sleep(100);

    led.Write(GpioPinValue.Low);
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
var gpio = GpioController.GetDefault();
var button = gpio.OpenPin(SC20260.GpioPin.PD7);
button.SetDriveMode(GpioPinDriveMode.InputPullUp);

while (true) {
    if (button.Read() == GpioPinValue.Low) {
        //Button is pressed.
    } 

    Thread.Sleep(10);   //Always give the system time to think!
}
```
---

## Digital Input Events

Using events to check an input instead of polling the input (using a loop) is often preferred. The following code demonstrates a GPIO pin event (interrupt) on the SCM20260D Dev board.

You will see a reference to a "falling edge" in the following code. A falling edge occurs when the state of a pin goes from high to low. A rising edge is just the opposite -- it occurs when a pin goes from low to high. 

```cs
var gpio = GpioController.GetDefault();

var button = gpio.OpenPin(SC20260.GpioPin.PD7);
button.SetDriveMode(GpioPinDriveMode.InputPullUp);
button.ValueChangedEdge = GpioPinEdge.FallingEdge | GpioPinEdge.RisingEdge;
button.ValueChanged += Button_ValueChanged;

//Do other tasks here ...
Thread.Sleep(Timeout.Infinite);

void Button_ValueChanged(GpioPin sender, GpioPinValueChangedEventArgs e) {
    if (e.Edge == GpioPinEdge.FallingEdge) {
        // Pin went low
    } else {
        // Pin went high
    }
}
```

When a mechanical button is pressed it generates multiple edges that are caused by the contact physically bouncing. The built in debounce feature filters out any edges coming in faster than a specific time, which is set to 20ms be default. The debounce value can be changed using software.

```cs
pin.DebounceTimeout = TimeSpan.FromMilliseconds(10);
```

## SITCore Interrupt limitation

Digital input events rely on internal GPIO interrupts to work. On SITCore, these interrupts are only available on 16 pins at any given time, the pin number must be unique, over all of the available ports. For example: PA1 and PB1 cannot both be used as interrupts at the same time. However, PA1 and PB2, or even PA1 and PA2, can be used simultaneously.

Consider other internal system functions that need interrupts, such as WiFi. Those also reserve one of the 16 available interrupts.

## LowLevel Access
**For advanced users only** 

> [!Warning]
> This advanced feature does not check what alternate functions are valid. 
> This advanced feature does not reserve the destination pin.

This example will move MOSI2 pin from PB2 to PC7, assuming AF6 (AF6 mean Alternate Function 6)

```cs
// start by creating SPI2 to initialize the feature on PB2
// now transfer...
var settings = new Settings {​​​​​​​
    mode = PortMode.AlternateFunction,
    speed = OutputSpeed.VeryHigh,
    driveDirection = PullDirection.None,
    alternate = AlternateFunction.AF6,
    type  = OutputType.PushPull
}​​​​​​​;
LowLevelController.TransferFeature(SC20100.GpioPin.PB2, SC20100.GpioPin.PC7, settings);

// SC20100.GpioPin.PB2: Becomes default state (input)
// SC20100.GpioPin.PC7: Becomes AF6

```

This advanced feature needs to be called right before Enable() (or Open() if Uart, Start() if PWM etc... - depends on peripherals) for working properly.




