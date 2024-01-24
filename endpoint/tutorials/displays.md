[IN PROGRESS](error.md) 
# Displays
---
Graphical Displays can be grouped into two distinct interface categories, built-in parallel TFT displays and virtual displays, typically serial (SPI/I2C) displays. 

The display drivers are meant to transfer the pixel data from memory to the actual display. The [graphics](graphics.md) tutorial shows how drawing is done in memory.

---

## Native Displays
These displays connect to special dedicated pins on the processor. Internally, the display controller automatically transfers (refreshes) the display directly from memory without any processor interaction, using DMA. When the system needs to update the display, it simply writes to memory. Neither the operating system nor the application program are burdened with display processing. The down side to this is that the system needs to have enough RAM to handle the display. An 800x600 display with 16bpp needs 960,000 bytes!

---

## Virtual Displays
The internal graphics services can be mapped to work with virtual display displays, such as SPI displays. See the [Graphics](graphics.md) tutorial for more information and sample code.

---

## Character Displays
![Character Display](images/character-display.jpg)

These displays are capable of only showing characters. They are available in different sizes, but two lines of 16 characters is most common. These displays types use the standard .NET [Iot.Device.CharacterLcd](https://learn.microsoft.com/en-gb/dotnet/api/iot.device.characterlcd?view=iot-dotnet-latest) library

---

