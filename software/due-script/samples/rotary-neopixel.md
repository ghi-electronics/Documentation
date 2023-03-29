# Rotary NeoPixel

---
This sample uses a Grove rotary module to control NeoPixel Ring

![Rotary Module](images/rotary-neopixel.gif)

Hardware:
 - FEZ Flea
- Grove XIAO Shield
- Grove Rotary Angle Sensor
- NeoPixel Ring

> [!NOTE] 
> The Rotary module can be attached to any analog pins. The NeoPixel can only be attached to a certain pin. See specific hardware page for details.

```basic
@loop
NeoClear()
NeoShow(24)
a=ARead(6)
NeoSet(a/4,255,0,0)
NeoShow(24)
Wait(50)
goto loop
```
