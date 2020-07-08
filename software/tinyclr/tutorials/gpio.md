# General Purpose Input Output (GPIO)
---
Microcontrollers include pins that can be controlled through software. They can be inputs or outputs, hence the name "general purpose input/output," or GPIO for short.

> [!Tip]
> GPIO is found in the GHIElectronics.TinyCLR.Devices.Gpio NuGet package and pin definitions are found in the  GHIElectronics.TinyCLR.Pins package.

## Digital Outputs
A digital output pin can be set to either high or low. There are different ways of describing these two states. High can also be called "true" or "one;" low can be called "false" or "zero".
If the processor is powered from 3.3V, then the state high means that there is 3.3V on the output pin. It is not going to be exactly 3.3V but very close. When the pin is set to low, it's voltage will be very close to zero.

### Maximum Output Current

Each SITCore GPIO pin can sink and source up to 8 mA of current, and up to 20 mA with relaxed output voltage ratings.

For example, the maximum output low voltage is 0.4 volts when the I/O current is +8 mA, but could be as high as 1.3 volts when the I/O current is +20 mA.

The minimum output high voltage is Vdd - 0.4 volts (2.9 volts with 3.3 volt supply) when the I/O current is -8 mA, but could be as low as Vdd - 1.3 (2.0 volts with 3.3 volt supply) volts when the I/O current is -20 mA.

The total output current sunk or sourced by the sum of all I/Os and control pins must not exceed 140 mA.

> [!Warning]
> Never connect two output pins together. If they are connected and one is high and the other is low, the entire processor can be damaged.

> [!Warning]
> Digital pins on microcontrollers are weak. They can only be used to control small LEDs or transistors. Those transistors can, in turn, control devices with high power needs like a motor.


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

## Digital Inputs
Digital inputs sense the state of an input pin based on its voltage. The pin can be high or low. Every pin has a maximum and minimum supported voltage. For example, the typical minimum voltage on most pins is 0 volts; a negative voltage may damage the pin or the processor. Also, the maximum that can be applied to most pins must be less than or equal to the processor's power supply voltage. Since most processors run on 3.3V, the highest voltage a pin should see is 3.3V. However, some processors that are powered by 3.3V are 5V tolerant -- they can withstand up to 5V on their inputs. The SITCore is 5V tolerant.

> [!Warning] 
> 5V tolerant doesn't mean the processor can be powered by 5V, only that the input pins can tolerate 5V.

The logic low threshold is 0.4\*Vdd-0.-1.  With a 3.3v power supply this means 1.22v.   
The logic high threshold is 0.47\*Vdd+0.25.  With a 3.3v power supply this means 1.801v.  

Unconnected input pins are called "floating." They are in a high impedance state and are susceptible to surrounding noise which can make the pin read high or low. A resistor can be added to pull the pin high or low. Modern processors include internal pull-up and pull-down resistors that are controlled by software. Note that a pull-up resistor doesn't necessarily make a pin high -- something connected to the pin can still pull it low.

In this example, a button is connected between ground and an input pin. We will enable the pull-up resistor making that pin high when the button is not pressed.  When the button is pressed, it will overpower the pull-up and make the input low. We will read the status of the button and pass its state to an LED. 

> [!Tip]
> Never use an infinite loop without giving the system time to think. Add a short sleep to the loop, or use events instead.

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

## Digital Input Events

In the previous example the program loops forever.  The input attached to the button is checked during each iteration of the loop. The pin may be checked millions of times before the button is pressed! This method of checking inputs is called "polled input."

Using events to check an input instead of polling the input is often preferred. Once an event is set up it will automatically check the input on its own, freeing up the program to do other things. Also, it is possible to miss a change in input if you don't check (or poll) the input often enough. Events use interrupts to check inputs so you don't have to worry about missing anything.

When an event occurs, the program stops what it is doing and control is transferred to an event handler. An event handler is code you write that responds to the event. 

Let's use event driven programming to respond to a button and turn an LED on and off. We will raise an event when the value on the button's input pin changes because the button is pressed or released.

You will see a reference to a "falling edge" in the following code. A falling edge occurs when the state of a pin goes from high to low. A rising edge is just the opposite -- it occurs when a pin goes from low to high.

The following code demonstrates a GPIO pin event (interrupt) on the SCM20260D Dev board. This example works exactly the same as the example above, but uses events instead of polling.

```cs
private static void Main() {
    var gpio = GpioController.GetDefault();

    var button = gpio.OpenPin(SC20260.GpioPin.PD7);
    button.SetDriveMode(GpioPinDriveMode.InputPullUp);
    button.ValueChanged += Button_ValueChanged;

    //Do other tasks here ...
    Thread.Sleep(-1);
}

private static void Button_ValueChanged(GpioPin sender, GpioPinValueChangedEventArgs e) {
    if (e.Edge == GpioPinEdge.FallingEdge) {
        // Pin went low
    } else {
        // Pin went high
    }
}
```

> [!Tip] 
> Once you type += after the event, hit the tab key and Visual Studio will automatically create the event for you.

### Pin Interrupts
Input events use interrupts (IRQs). Interrupts are only available on 16 pins at any given time. Of those 16 pins, the pin number must be unique. For
example: PA1 and PB1 cannot both be used as interrupts at the same time. However, PA1 and PB2, or even PA1 and PA2, can be used simultaneously with interrupts.

It is also important to consider what interrupt pins are used by the system's internal functions, such as WiFi and touch screen interrupt pins. These interrupts invalidate interrupts with the same pin number on any GPIO port. 

If your product design relies on interrupts, be very careful when allocating GPIO pins to make sure interrupts are available on all needed pins.
