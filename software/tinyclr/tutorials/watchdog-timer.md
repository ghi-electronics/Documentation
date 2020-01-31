# Watchdog
---
The watchdog is a feature to keep checking that the system is functional by regularly “checking in”, or by “kicking the dog”! First, there is a countdown timer that is set to a specific time. When the timer reaches zero, the system will completely reset. A normally operating software will always regularly reset the timer so it will never reach zero, and so the system never resets under normal conditions. However, when the system fails or locks up, the timer will end up reaching zero and the system will reset.

> Note
> Once Watchdog is enabled it can’t be disabled without resetting the system or a power cycle.

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

> Note
> Enabling Watchdog when debugging is a bad idea since the system will probably reset when stepping through code.
