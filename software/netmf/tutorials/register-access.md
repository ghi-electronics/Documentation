# Register Access
---

## Introduction
To make the processor registers directly available to developers, We added the Register class.

```cs
Register PCONP = new Register(0xE01FC0C4);
// Enable timer2 and timer3
PCONP.SetBits((1 << 22) | (1 << 23));
```

Do you understand why 1 << 22 was used? It's easy to get the first bit (0x01), second bit (0x02) and so on but what about the higher bits such as 0x00400000? Which bit is this one? Instead of complicating things, let the compiler do the work for you. Simply use 1 << 22 for the 22nd bit.

## Pulse Counter
NETMF doesn't have a way to count pulses. What if the processor supports it?

Here is an example that sets timer 3 and P0.4 on the LPC2478 processor to count pulses. While this code will compile on any platform, it will only work on LPC2478. Other processors have different registers and different features.

> [!Tip]
> You will need the LPC2478 datasheet and manuall to fully understand the example.

```cs
using System;
using System.Threading;
using Microsoft.SPOT;

using GHI.Processor;

namespace MFConsoleApplication1
{
    public class Program
    {
        public static void Main()
        {
            Register PCONP = new Register(0xE01FC0C4);
            PCONP.SetBits(1 << 22);//enable timer2 

            // Select IO0 on EMX CAP2.0
            Register PINSEL0 = new Register(0xE002C000);
            PINSEL0.SetBits((3 << 8));//set bits 8 and 9

            // To enable timer/counter
            Register T2TCR = new Register(0xE0070004);
            T2TCR.Value = 1;

            // set prescale to 0
            Register T2PR = new Register(0xE007000C);
            T2PR.Value = 0;

            Register T2CTCR = new Register(0xE0070070);
            T2CTCR.Value = (2 << 0 | 0 << 2);//count on falling edge and use CAPn.0

            // should be 0 for a counter
            Register T2CCR = new Register(0xE0070028);
            T2CCR.ClearBits(0x07);

            // Don't do anything on match
            Register T2MCR = new Register(0xE0070014);
            T2MCR.Value = 0;

            // To reset the counter
            T2TCR.SetBits((1 << 1));
            T2TCR.ClearBits((1 << 1));

            // To read
            Register T2TC = new Register(0xE0070008);
            while (true)
            {
                uint count = T2TC.Value;

                Debug.Print("Total count: " + count);

                Thread.Sleep(1000);
            }
        }
    }
}
```
