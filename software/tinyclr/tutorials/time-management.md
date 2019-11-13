# Time Management
---
## Built-in Time Service

You can simply get the current time using `DateTime.Now`. The system starts counting at a fixed time on every power up, meaning the time ticks every second correctly but the time will be off. If the correct time is needed, the time needs to be set to the current true time (and date). This is accomplished using `GHIElectronics.TinyCLR.Native.SystemTime.SetTime(DateTime utcTime)`

```
using System;
using System.Diagnostics;
using System.Threading;

class Program {
    static void Main() {
        Debug.WriteLine("Time at power up: " + DateTime.Now);
        // January 1st 2019 at 11:11:11
        DateTime MyTime = new DateTime(2019, 1, 1, 11, 11, 11);
        GHIElectronics.TinyCLR.Native.SystemTime.SetTime(MyTime);
        while (true) {
            Debug.WriteLine("Current Time: " + DateTime.Now);
            Thread.Sleep(1000);
        }
    }
}
```

The output looks like

```
Time at power up: 01/01/2017 00:00:01
Current Time: 01/01/2019 11:11:11
Current Time: 01/01/2019 11:11:12
Current Time: 01/01/2019 11:11:13
Current Time: 01/01/2019 11:11:14
...
```

# Timers
---
A timer is used to call a method at a specific time. This example will call (invoke) Ticker initially after 3 seconds and then it will repeat once a second indefinitely.

```cs
static void Ticker(object o) {
    Debug.WriteLine("Hello!");
}
static void Main() {

    Timer timer = new Timer(Ticker, null, 3000, 1000);

    Thread.Sleep(Timeout.Infinite);
}
```

A thread can also be created that loops once a second. The difference is that a thread with a 1 second sleep will always sleep for one second after whatever time was needed by the thread. So if a thread needed 0.5 second to complete what it is doing, sleeping for one second will cause the thread to execute every 1.5 seconds. This also gets more complex as a thread can be interrupted by the system. There is no guaranteed time on threads.

A timer set to invoke a method every second will do so every second regardless of how long that method needs to complete its task. However, care must be taken as if a timer calls a method every 10 milliseconds but then the method needs more than 10 milliseconds to execute you will end up flooding the system. The best practice is for timers to invoke methods that execute in a short time.
