# Watchdog

---

A watchdog timer is used to reset the system if the system fails or locks up. The system internally will reset the watchdog timer so it never reaches zero and doesn't reset the system. 

It's recommend to run Watchdog inside a thread in the application.  

Max timeout is 32 seconds.

```cs
var watchdog = new WatchdogController();

watchdog.Start(10); // 10 second
var cnt = 0;
while (true)
{

    Console.WriteLine("cnt: " + cnt++);
    Thread.Sleep(1000);

    watchdog.Reset();   
}

```
