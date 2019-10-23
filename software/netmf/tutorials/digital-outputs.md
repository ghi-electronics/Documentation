# Digital Outputs
---

A digital output pin can be set to either high or low. There are different ways of describing these two states. High can also be called "true" or "one;" low can be called "false" or "zero".

If the processor is powered off of 3.3 V, then the state high means that there is 3.3 V on the output pin. It is not going to be exactly 3.3 V but very close. When the pin is set to low then it is voltage is very close to zero volts.
 
> [!Warning]
> Never connect two output pins together. If they are connected and one is high and the other is low, the entire processor can be damaged.
The digital pins on micro-controllers are very weak. They can not be used to drive devices that require a lot of power.
 
> [!Tip]
> All the examples shown below require the Microsoft.SPOT.Hardware assembly. Consult the device schematics or manual for specific pin numbers.

## Light Up an LED
This example turns a LED on. The initial state of the pin (true or false) must be specified when creating the OutputPort. This example makes the pin true which will cause the LED to be on by default.

```cs
using System.Threading;
using Microsoft.SPOT.Hardware;

public class Program
{
    public static void Main()
    {
        OutputPort LED;
        LED = new OutputPort(Cpu.Pin.GPIO_Pin1, true);

        Thread.Sleep(Timeout.Infinite);
    }
}
```

## Blink an LED
To blink an LED, the pin is toggled between high and low. Due to the high speed of the microcontroller (it can flash the LED millions of times per second) a delay needs to be added between ON and OFF to see the blinking.
 
```cs
using System.Threading;
using Microsoft.SPOT.Hardware;

public class Program
{
    public static void Main()
    {
        OutputPort LED;
        LED = new OutputPort(Cpu.Pin.GPIO_Pin1, true);

        while (true)
        {
            LED.Write(!LED.Read());
            Thread.Sleep(200);
        }
    }
}
```
