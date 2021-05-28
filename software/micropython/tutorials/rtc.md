# RTC
---

Real Time Clock is an internal clock that runs off a a separate battery even when the system is off.


```
from machine import RTC

rtc = RTC()
rtc.init()
rtc.datetime((2021, 8, 23, 1, 12, 48, 0, 0)) # set a specific date and time
while True:
    rtc.datetime()
    time.sleep(1)
```