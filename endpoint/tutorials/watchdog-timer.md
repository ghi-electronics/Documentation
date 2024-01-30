# Watchdog

---

A watchdog timer is used to reset the system if the system fails or locks up. The system internally will reset the watchdog timer so it never reaches zero and doesn't reset the system. 

It's recommend to run Watchdog inside a thread in the application.  

```cs
var watchdog = new WatchdogController();
Console.WriteLine("Status before start: " + watchdog.Started);
bool start = watchdog.Start(10);
Console.WriteLine("Status after start: " + watchdog.Started);
```
