## Neopixel

Neopixel is fixed to pin number 1 

- **NeoClear()** - Clears all LEDs (in memory). Needs `NeoShow()` to see the affect

- **NeoSet(index, red, green, blue)** - Sets a specific LED to a color. Needs `NeoShow()` to see affect<br>
**index:** The LED index where 0 is first one and supporting up to 256 LEDs<br>
**red, green, blue:** Color levels, 0 to 255 <br>

- **NeoShow(count)** - All NEO code is held internally until show<br>
 **count:** The count of LEDs to update and show

This example assumes we have 8 LEDs and will set 8 LEDs to red, increasing the color intensity from 0 to 80.  Then it waits one second before it sets the first LED to bright purple!

```basic
NeoClear()
For x = 0 to 8
    NeoSet(x,x*10,0,0)
Next
NeoShow(8)
Wait(1000)
NeoSet(0,200,0,200)
NeoShow(8)
```

- **NeoStream(count)** - Streams data directly to LEDs. Automatically calls `NeoShow()` internally<br>
 **count:** The count of LEDs to stream<br>
 **Stream size:** It is "count" multiplied by 3, DUE to the fact that each LED needs 3 bytes for colors, ordered in GRB format.
 
---