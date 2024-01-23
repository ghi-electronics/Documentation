[IN PROGRESS](error.md) 
# Watchdog
---
A watchdog timer is used to reset the system if the system fails or locks up. 

During normal operation, the application will regularly reset the watchdog timer so it never reaches zero and doesn't reset the system. 

> [!Note]
> Once Watchdog is enabled it can't be disabled without resetting the system or a power cycle.

> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Devices.Watchdog 

It's recommend to run Watchdog inside a thread in the application.  

```cs
new Thread(RunWatchDog).Start();
                 
static void RunWatchDog() {

    // Set watchdog to 5 seconds and reset it every 4 seconds
    var WatchDog = WatchdogController.GetDefault();
    WatchDog.Enable(5000);

    while (true) {
        //reset the timer
        WatchDog.Reset();
        Thread.Sleep(4000);
    }
}
```
> [!Tip]
> Set your Watchdog timer to a reasonable amount of time, setting it too low will cause the application to constantly reset. 

> [!Note]
> Enabling the watchdog timer when debugging is a bad idea since the system will probably reset while stepping through code.
