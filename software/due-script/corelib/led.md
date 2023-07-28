# LED

This function is used to take control of the on-board LED. `LED()` is non-blocking so it can be used as a status indicator for your programs while they run. 

- **LED(high, low, count)**<br>
  **high:** The duration in milliseconds the LED is on.<br>
**low:** The duration in milliseconds the LED is off.<br>
**count:** The number of times the LED will blink, 


> [!TIP] 
> Setting count to **-1** will blink the LED forever, and **0** will turn off the LED.

```basic
LED(1000,1000,10)
```

> [!NOTE]
> All DUE enabled hardware's on-board LED can also be accessed directly using the [`DWrite()`](../corelib/digital.md) function using pin 'L' or 'l', which are ASCII 108. `DWrite('L',1)`