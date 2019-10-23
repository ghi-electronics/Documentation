# Watchdog
---

## Introduction
In the embedded system world, devices are usually always running and with no user interaction. So if something went wrong, it would be very beneficial if we have an automatic reset button. Watchdog is your reset button!

Assume you are making a smart vending machine that reports its inventory over the network. If your code raises an exception that wasn't handled properly then your program will end. Program ended means the vending machine will no longer work. Someone will have to drive to the vending machine to reset it! The alternative is to use the watchdog.

When watchdog is enabled, it is given a timeout where it will reset the system if the time reached without resetting the timeout. This is like saying "reset the system in 5 seconds" then the program goes on to do something. The program needs to come back and reset the time and say "reset in 5 seconds". If the program keeps doing this, the system will never reset. But if the program got stuck somewhere, the 5 seconds will end causing the system to reset.

 
> [!Tip]
> GHI does not use the NETMF's built in services for watchdog, but uses its own.

Use the GHI.Hardware assembly when using watchdog.

 
> [!Warning]
> Do NOT set the Watchdog reset time too short during the debug phase. If it is shorter than the time taken to deploy your code then your device will reboot and the new code never gets loaded. The only way to get out of the problem is to erase the device and reflash the firmware.

We advice not to use watchdog during development and debugging.

## Max Timeouts
The following lists shows the max timeout value for watchdog on our various devices in milliseconds. Do note that for G120 and EMX, there is roughly a 30% margin of error around the max value where the device may still reset.

* G400: 15,995
* G120: 134,217
* EMX: 4,294,967
* Cerberus: 32768

## Five Second Watchdog
This example shows how to set the watchdog to 5 seconds timeout and create a thread to clear the watchdog every 3 seconds. Should anything go wrong and the thread that clears the watchdog isn't able the run due to another thread using all of the available resources, the device will reset in 5 seconds.

 
> [!Tip]
> Once you enable the Watchdog, it cannot be disabled. So you have to keep resetting the timeout. This is done to assure that no system corruption will disable watchdog accidentally.

```cs
using System;
using System.Threading;
using GHI.Processor;

public class Program
{
    public static void Main()
    {
        // Timeout 5 seconds
        int timeout = 1000 * 5;

        // Enable Watchdog
        Watchdog.Enable(timeout);

        // Start a time counter reset thread
        WDTCounterReset = new Thread(WDTCounterResetLoop);
        WDTCounterReset.Start();

        // ....
        // your program starts here

        // If we exit the program, 
        // the thread will stop working and the system will reset!
        Thread.Sleep(Timeout.Infinite);
    }

    static Thread WDTCounterReset;
    static void WDTCounterResetLoop()
    {
        while (true)
        {
            // reset time counter every 3 seconds
            Thread.Sleep(3000);

            Watchdog.ResetCounter();
        }
    }
}
```

You may be thinking, if the software locked up then how would the code that handles watchdog ever run?  It works because the watchdog is supported in hardware not software. This means that the counter and the reset mechanism are done inside the processor, without the need for any software.

## Detecting Watchdog
In some cases, you need to know if the system did reset because of a watchdog to log this info or run some recovery procedures. This is how it works

```
using System;
using System.Threading;
using Microsoft.SPOT;
using GHI.Processor;


public class Program
{
    public static void Main()
    {
        // Normally, you can read this flag ***ONLY ONCE*** on power up
        if (Watchdog.LastResetCause == Watchdog.ResetCause.Watchdog)
        {
            Debug.Print("Watchdog did Reset");
        }
        else
        {
            Debug.Print("Reset switch or system power");
        }
    }
}
```
