# Real Time Clock
---

## Introduction
Systems typically have a Real Time Clock (RTC) that uses a backup battery (VBAT) and a separate crystal to keep time running even if the system is not powered. Typical crystal value is 32.768Khz. Consult your product's documentation to see if it has a built in RTC.

Note: NETMF has time services that you can use to get/set the system time such as DateTime.Now. When power is lost or the system is reset, the time is also reset. Those services do not need RTC. An application can set proper time by reading from the RTC (running from a separate always-on power) or from the internet through a time server. Not having RTC will not limit NETMF's time services beyond resetting the date and time to a preset value. Time measurement is still available.

## Time via NETMF
This example sets the current time to a predefined value that is lost when power is lost.

```cs
using System;
using System.Threading;
using Microsoft.SPOT;
using Microsoft.SPOT.Hardware;

public class Program
{
    public static void Main()
    {
        //Set the time to 07/25/2012 at 11:46:11
        DateTime time = new DateTime(2012, 07, 25, 11, 46, 11);

        // lost after power cycle or reset:
        Utility.SetLocalTime(time);
        while (true)
        {
            Debug.Print(DateTime.Now.ToString());
            Thread.Sleep(100);
        }
    }
}
```

## Using GHI's extension for Real Time Clock
To use the RTC hardware, we first need to check if the RTC hardware has the valid time or not. If RTC has a valid time then we can read from the RTC and use that to set the NETMF system time. If time is not valid, then you will need to set the RTC to the correct time. You can verify the validilty of the RTS several ways. One way is to use the built in battery ram (if available) to store some "magic numbers" that we check later to determine if the battery ram data is still valid. If they are then most likely the RTC is valid. You can also check the RTC against some known time. For example, if your program was written on 1/1/2014, you can check to see if the current RTC date is before that known date. If it is, then the time is incorrect.

```cs
using System;
using GHI.Processor;
using Microsoft.SPOT;

public class Program
{
    public static void Main()
    {
        DateTime DT;
        try
        {
            DT = RealTimeClock.GetDateTime();
            Debug.Print("Current Real-time Clock " + DT.ToString());
        }
        catch // If the time is not good due to powerloss or being a new system an exception will be thrown and a new time will need to be set
        {
            Debug.Print("The date was bad and caused a bad time");
            DT = new DateTime(2014, 1, 1, 1, 1, 1); // This will set a time for the Real-time Clock clock to 1:01:01 on 1/1/2014
            RealTimeClock.SetDateTime(DT); //This will set the hardware Real-time Clock to what is in DT
        }

        if (DT.Year < 2011)
        {
            Debug.Print("Time is not resonable");
        }

        Debug.Print("Current Real-time Clock " + RealTimeClock.GetDateTime().ToString());
        DT = new DateTime(2014, 9, 15, 7, 30, 0); // This will set the clock to 9:30:00 on 9/15/2014
        RealTimeClock.SetDateTime(DT); //This will set the hardware Real-time Clock to what is in DT
        Debug.Print("New Real-time Clock " + RealTimeClock.GetDateTime().ToString());
    }
}
```
