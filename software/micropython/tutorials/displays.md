# Displays

---

See the [Graphics](graphics.md) tutorial on details on how to draw using the display drivers below.

## SSD1306

Drivers for this commonly available display are built in. Pull in the drivers using `from displays pull ssd1306`.

```py
from machine import I2C
import ssd1306

# using default address 0x3C
i2c = I2C(1)
display = ssd1306.SSD1306_I2C(128, 64, i2c)

display.text('Hello, World!', 0, 0, 1)
display.show()
```

The display driver also includes other helper methods.

```py
display.poweroff()     # power off the display, pixels persist in memory
display.poweron()      # power on the display, pixels redrawn
display.contrast(0)    # dim
display.contrast(255)  # bright
display.invert(1)      # display inverted
display.invert(0)      # display normal
display.rotate(True)   # rotate 180 degrees
display.rotate(False)  # rotate 0 degrees
display.show()         # write the contents of the FrameBuffer to display memory
```
