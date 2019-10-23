# Digital Inputs
---

Digital inputs sense if the state of its pin is high or low based on the voltage. Every pin has a maximum & minimum supported voltages. For example, the typical minimum voltage on most pins is 0 volts -- a negative voltage may damage the pin or the processor. Also, the maximum that can be supplied to most pins must be less than the processor power source voltage. Since most processors run on 3.3V, the highest voltage a pin should see is 3.3V; however, some processors that are powered by 3.3V are 5V tolerant and are capable of accepting up to 5V on their inputs. Check the product's or the processor's manual for the tolerance level.
 
> [!Warning]
> 5V-tolerant doesn't mean the processor can be powered by 5V. Only the input pins can tolerate 5V.

## InputPort

An InputPort object is used to handle digital input pins. Most pins on the processor can be input or output. Unconnected input pins are "floating". When a pin is an input and is not connected, it is open for any surrounding noise, which can make the pin high or low. To take care of this issue, modern processors include internal weak pull-down or pull-up resistors, that are usually controlled by software. Enabling the pull-up resistor will pull the pin high. Note that the pull-up resistor doesn't make a pin high but it pulls it high. If nothing is connected then the pin is high by default. External resistors can be added as well.

In this example, a button is connected between ground and the input pin. We will also enable the pull-up resistor. This means that the pin will be high (pull-up) when button is not pressed and low (connected to ground) when the button is pressed. We will read the status of the button and pass its state to the LED. Note that the pin is high when the button is not pressed (pulled-high) and it is low when the button is pressed. This means the LED will turn off when the button is pressed.

The following code requires the Microsoft.SPOT.Hardware assembly. Consult the device schematics or manuals for the proper pin numbers.

```cs
using System.Threading;
using Microsoft.SPOT.Hardware;


public class Program
{
    public static void Main()
    {
        OutputPort LED;
        InputPort Button;
        LED = new OutputPort(Cpu.Pin.GPIO_Pin1, true);
        Button = new InputPort(Cpu.Pin.GPIO_Pin2, false, Port.ResistorMode.PullUp);

        while (true)
        {
            LED.Write(Button.Read());
            Thread.Sleep(10);
        }
    }
}
```

## Interrupt Port

In the previous example, the program just looped, and looped, and looped -- each time checking the status of the pin attached to the button. The pin is checked maybe a million times before/after the button is pressed!  

Interrupt ports allows us to set a method that will be executed when the button is pressed (when pin is low for example).

We can set the interrupt to fire (call the method) on many state changes on the pin: when a pin is low or maybe when it is high. The most common use is the "on change." The change from low to high or high to low creates a signal edge. The rising edge occurs when the signal rises from low to high. The falling edge happen when the signal falls from high to low. For a more in-depth understanding of the difference between the "change" interrupt versus a "level" interrupt, use wikipedia -- the two articles of relevance are found by searching for "Interrupt Port" and "edge level transition."

In the example below, we are using the low edge to detect a button press. "IntButton_OnInterrupt" will automatically run when button is pressed.

The following code requires the Microsoft.SPOT.Hardware assembly. Consult the device schematic or manual for pin numbers.

```cs
using Microsoft.SPOT;
using Microsoft.SPOT.Hardware;
using System;    
using System.Threading;

public class Program
{
    public static void Main()
    {
        InterruptPort IntButton = new InterruptPort(Cpu.Pin.GPIO_Pin1, false,
                                                    Port.ResistorMode.PullUp,
                                                    Port.InterruptMode.InterruptEdgeLow);

        IntButton.OnInterrupt += new NativeEventHandler(IntButton_OnInterrupt);
		
      	// Other code can be added here
      	// ...
      	// We are just going to sleep in this example!
        Thread.Sleep(Timeout.Infinite);
    }

    static void IntButton_OnInterrupt(uint port, uint state, DateTime time)
    {
        Debug.Print("Button Pressed");
    }
}
```

When creating the new InterruptPort object, the second argument indicates whether the glitch filter is enabled (true) or disabled (false). This is typically needed when using the interrupt feature to debounce the button. Not enabling this feature may cause the button to trigger more than one event, even though the button is pressed once.
 
> [!Tip]
> In the event handler, like the one above : ...OnInterrupt(uint port, uint state..., the state argument is the state of the Pin after the edge transition. I.e. on a low to high edge, state will be high (true); likewise for high to low transitions.

## Tristate Port
If we want a pin to be an input and output, what can we do? A pin can never be in and out simultaneously but we can make it output to set something and then make it input to read a response back. One way is to "Dispose" of the pin. We make an output port, use it and then dispose it; then we can make the pin input and read it.

NETMF supports a better option called a Tristate port. Tristate means three states -- input, output low and output high. One minor issue about tristate pins is that if a pin is set to output and then you set it to output again an exception will occur. One common work-around for this is to check the direction of the pin before changing it. The direction of the pin is in its property "Active" where false means input and true is output.

The code below requires the Microsoft.SPOT.Hardware assembly.
 
> [!Tip]
> Due to internal design, TristatePorts will only work with interrupt capable digital pins.
 
> [!Warning]
> Be careful not to have the pin connected to a switch then set the pin to output.

```cs
using System.Threading;
using Microsoft.SPOT;
using Microsoft.SPOT.Hardware;

public class Program
{
    static void MakePinOutput(TristatePort port)
    {
        if (port.Active == false)
            port.Active = true;
    }
    static void MakePinInput(TristatePort port)
    {
        if (port.Active == true)
            port.Active = false;
    }
    public static void Main()
    {

        TristatePort TriPin = new TristatePort(Cpu.Pin.GPIO_Pin6, false,
                                                   false, Port.ResistorMode.PullUp);
        MakePinOutput(TriPin);
        TriPin.Write(true);
        Debug.Print("Write to output pin completed.");
        Debug.Print("Changing to input pin");
        MakePinInput(TriPin);
        Debug.Print("The input pin state is: " + TriPin.Read().ToString());
        Thread.Sleep(Timeout.Infinite);

    }
}
```
