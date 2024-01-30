# Power Management

---

There are multiple ways to put a system in different power modes to save on power consumption.

Endpoint currently only support complete shutdown.

Both [RTC](rtc.md) and one of the wakeup pins can be used to wakeup the system from shutdown.

```cs
using GHIElectronics.Endpoint.Native;
using GHIElectronics.Endpoint.Devices.Rtc;

var rtc = new RtcController();
var dt = DateTime.Now;
rtc.Now = dt;
Console.WriteLine("rtc = " + rtc.Now);
Console.WriteLine("system = " + DateTime.Now);
Power.EnableWakeup(DateTime.Now.AddSeconds(30), WakeupPin.PA0);
Console.WriteLine("Wakeup = " + DateTime.Now.AddSeconds(30).ToString());
Power.Shutdown();
```

> [!Tip]
> Shutdown is brings the system down completely. Any unsaved files will be lost.