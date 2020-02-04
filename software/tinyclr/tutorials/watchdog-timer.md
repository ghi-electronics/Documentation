# Watchdog
---
A watchdog timer is used to reset the system if the system fails or locks up. A watchdog timer is a countdown timer that will reset the system when the timer reaches zero. During normal operation, the application will regularly reset the watchdog timer so it never reaches zero and doesn't reset the system. However, when the system fails or locks up, the timer will time out and reset the system.

> [!Note]
> Once Watchdog is enabled it can't be disabled without resetting the system or a power cycle.

```cs
// Set watchdog to 5 seconds and reset it every 4 seconds
Watchdog.Enable(5000);
While(true)
{
              // reset the timer
Watchdog.Reset()
              Thread.Sleep(4000);
}

```

> [!Note]
> Enabling the watchdog timer when debugging is a bad idea since the system will probably reset while stepping through code.
