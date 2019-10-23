# Signal Generator
---

## Introduction
SignalGenerator is non-blocking digital waveform generator. SignalGenerator works by comparing an internal counter to an array of time values, one by one; when the value of the argument matches the counter, the output pin is changed. The values are in microseconds.

SignalGenerator can also be used to generate PWM; unlike the PWM class, SignalGenerator can be used to generate PWM on any available output pins; however, it uses a processor time, the higher the frequency the more processing it uses.

SignalGenerator can operate in two modes:

* non-blocking: runs in the background using system interrupts, and
* blocking: which does block (while it is running, it does not yield time to other code).  This mode has higher accuracy (used, for example, to generate carrier frequencies for infrared signals).

## Blinking LED
This example uses an array of toggle times to turn the LED on and off. 

The state of the the pin controlled by SignalGenerator will change after waiting for the durations specified in an array. Onces all the elements have been used; SignalGenerator will, optionally, start over at the beginning of the array.

```cs
using Microsoft.SPOT.Hardware;
using GHI.IO;

public class Program
{
    public static void Main()
    {
        
        uint[] time = new uint[] { 500 * 1000, 500 * 1000 };


        SignalGenerator LED = new SignalGenerator(Cpu.Pin.GPIO_Pin1, false);

        // args:  initial value,
        //        array of times,
        //        array start offset,
        //        length of array,
        //        repeat -- if true ==> repeat
        LED.Set(false, time, 0, 2, true);//start the waveform

        //... do more code here and the LED will continue to work.
        //... because the default running mode is non-blocking.
    }
}
```
