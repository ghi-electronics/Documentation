## LED

This function is used to take control of the on-board LED. **LED()** is non-blocking so it can be used as a status indicator for your programs while they run. 

- **LED(high, low, count)**<br>
  **high:** The duration in milliseconds the LED is on.<br>
**low:** The duration in milliseconds the LED is off.<br>
**count:** The number of times the LED will blink, 


> [!NOTE] 
> a number value of **-1** will blink the LED forever. A value of **0** will turn off the LED.
