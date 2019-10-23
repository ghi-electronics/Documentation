# Signal Capture
---

## Introduction
The SignalCapture class monitors a pin and records any changes (high-low or low-high transitions) of the pin into an array. It is a digital waveform recorder. Each array element is the number of microseconds between each signal change.

SignalCapture is a GHI Electronics' extension to NETMF. It requires the GHI.Hardware assembly. 

```cs
using System.Threading;
using Microsoft.SPOT.Hardware;
using GHI.IO;


public class Program
{
    public static void Main()
    {
        uint[] signal = new uint[100];
        SignalCapture pin = new SignalCapture(Cpu.Pin.GPIO_Pin1, Port.ResistorMode.Disabled);
        pin.Read(false, signal);
        
      	// ...
      	// process the "signal"
    }
}
```

## Timeouts
When calling read, it blocks until it has read as much data as the buffer can hold or you specify using the count parameter. If your signal is shorter than that, the call will never return. Make sure to request only what you plan to capture.

Alternatively, you can use the ReadTimeout property to signal to the call to return after the number of milliseconds specified by the property regardless of how much data you captured.

