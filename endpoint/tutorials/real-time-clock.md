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

You can get the current system time using `DateTime.Now`. The system clock starts running at power up, but until you set the clock, the time and date will be incorrect. 

The following command is used to set the system time to match the RTC.

```cs
var rtc = new RtcController();
var rtc_time = rtc.Now;
rtc.SetSystemTime(rtc_time);
```

