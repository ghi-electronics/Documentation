# Real Time Clock
---
The Real Time Clock (RTC) is a circuit that runs off a small battery or a super capacitor. It has its own crystal and keeps running even when the system is powered off. Not all hardware has a built in RTC, so check your hardware's documentation for more details.

In the event the RTC battery was drained or the RTC was never initialized, the RTC will not have a correct value. Use the `rtc.IsValid` to determine if the time was set correctly.

```cs
using GHIElectronics.TinyCLR.Devices.Rtc;
using GHIElectronics.TinyCLR.Native;
using System;
using System.Diagnostics;
using System.Threading;

class Program {
    static void Main() {
        var rtc = RtcController.GetDefault();

        if (rtc.IsValid) {
            Debug.WriteLine("RTC is Valid");
            // RTC is good so let's use it
            SystemTime.SetTime(rtc.Now);
        }
        else {
            Debug.WriteLine("RTC is Invalid");
            // RTC is not valid. Get user input to set it
            // This example will simply set it to January 1st 2019 at 11:11:11
            var MyTime = new DateTime(2019, 1, 1, 11, 11, 11);
            rtc.Now = MyTime;
            SystemTime.SetTime(MyTime);
        }

        while (true) {
            Debug.WriteLine("Current Time    : " + DateTime.Now);
            Debug.WriteLine("Current RTC Time: " + rtc.Now);
            Thread.Sleep(1000);
        }
    }
}
```

The output will show both times and they should match. If the time is invalid when you first run them program, the program will detect the invalid time and will set the RTC.

```
RTC is Valid
Current Time    : 01/01/2019 11:15:35
Current RTC Time: 01/01/2019 11:15:35
Current Time    : 01/01/2019 11:15:36
Current RTC Time: 01/01/2019 11:15:36
```

## System Clock

You can get the current system time using `DateTime.Now`. The system clock starts running at power up, but until you set the clock, the time and date will be incorrect. 

The following command is used to set the time:

```cs
GHIElectronics.TinyCLR.Native.SystemTime.SetTime(DateTime utcTime);
```

To set the system clock to the RTC time, use the following command:

```cs
GHIElectronics.TinyCLR.Native.SystemTime.SetTime(rtc.Now);
```