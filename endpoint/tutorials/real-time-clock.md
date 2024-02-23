# Real Time Clock
---
The Real Time Clock (RTC) is a circuit that runs off a small battery or a super capacitor connected to VBAT. It needs its own crystal and keeps running even when the main system and its clocks are powered off.

```cs
var rtc = new RtcController();

var time = new DateTime(2024, 1, 1, 10, 59, 50);
rtc.Now = time;

// Read some time later
var rtc_time = rtc.Now;
```

## VBAT

VBAT mode can be set in "charger mode" where it can charge an attached supercap.

> [!Important]
> Make sure the RTC battery charge mode is correctly set. Charging a lithium coin cell may cause damage to the cell and could cause it to leak.

```cs
var rtc = new RtcController();

rtc.EnableChargeMode(BatteryChargeMode.Fast);
```

## System Clock

You can get the current system time using `DateTime.Now`. 
After boot, if valid rtc detected, system clock will be updated by rtc. 
To set system time if rtc is not used, use `SetSystemTime`.

```cs
var rtc = new RtcController();
rtc.SetSystemTime(new DateTime(2024, 1, 30, 15, 00, 00));
```

