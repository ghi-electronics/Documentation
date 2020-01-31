# Displays
---
Graphical Displays can be grouped into two distinct interface categories, parallel TFT displays and serial (SPI/I2C) displays. There are also non-graphical character displays.

The display drivers are meant to transfer the pixel data from memory to the actual display. The [graphics](graphics.md) tutorial shows how drawing is done, in memory.

## Parallel TFT Displays
These displays connect to special dedicated pins on the processor. Internally, the display controller automatically transfers (refreshes) the display directly from memory without any processor interaction, using DMA. When the system needs to update the display, it simply writes to memory. Neither the operating system nor the application program are burdened with display processing. The down side to this is that the system needs to have enough RAM to handle the display. An 800x600 display with 16bpp needs 960,000 bytes!

## Serial SPI/I2C Displays
The internal graphics services can be mapped to work with serial displays. This is done by having access directly to the graphics memory, which then can be transfered to the desired display.

As each display has its own pixel format and color depth, you also have access to the way pixels are written in the graphics memory.

This [blog](https://forums.ghielectronics.com/t/managed-graphics-for-non-tft-displays-in-tinyclr/21887) details how this can be accomplished.

## Character Displays
![Character Display](../images/character-display.jpg)

These displays are capable of only showing characters. The most commonly use the HD44780 controller. They are available in different sizes but 2x16 character is most common. These displays only require GPIO pins and can be used with TinyCLR.

## Low Level Display Access
TinyCLR also provides low level display access as part of the `GHIElectronics.TinyCLR.Devices.Display` library. These methods provide a simple way to write to a display without need for the `System.Drawing` library or an added font resource file.

The following example is written for the SC20100 Dev Board and will paint the screen as shown in the picture beneath the code. Note that low level display access requires that you to use the data format required by your display as configured. The SC20100 Dev Board used in this example expects each pixel to have 16 bits (two bytes per pixel) of color information in RGB565 format.

```cs
using GHIElectronics.TinyCLR.Devices.Display;
using GHIElectronics.TinyCLR.Devices.Gpio;
using GHIElectronics.TinyCLR.Pins;

namespace LowLevelDisplayAccess{
    class Program{
        private static void Main(){
            GpioPin backlight = GpioController.GetDefault().OpenPin(SC20260.GpioPin.PA15);
            backlight.SetDriveMode(GpioPinDriveMode.Output);
            backlight.Write(GpioPinValue.High);
            var displayController = DisplayController.GetDefault();

            // Enter the proper display configurations
            displayController.SetConfiguration(new ParallelDisplayControllerSettings{
                Width = 480,
                Height = 272,
                DataFormat = GHIElectronics.TinyCLR.Devices.Display.DisplayDataFormat.Rgb565,
                PixelClockRate = 10000000,
                PixelPolarity = false,
                DataEnablePolarity = false,
                DataEnableIsFixed = false,
                HorizontalFrontPorch = 2,
                HorizontalBackPorch = 2,
                HorizontalSyncPulseWidth = 41,
                HorizontalSyncPolarity = false,
                VerticalFrontPorch = 2,
                VerticalBackPorch = 2,
                VerticalSyncPulseWidth = 10,
                VerticalSyncPolarity = false,
            });

            displayController.Enable();
            byte[] myPic = new byte[480 * 272 * 2];

            for (var i = 0; i < myPic.Length; i++){
                myPic[i] = (byte)(((i % 2) == 0) ? ((i / 4080) & 0b00000111) << 5 : i / 32640);
            }

            displayController.DrawString("\f");     
            displayController.DrawBuffer(0, 0, 0, 0, 480, 272, 480, myPic, 0);
            displayController.DrawString("GHI Electronics\n");
            displayController.DrawString("Low Level Display Demo.");

            for (var x = 20; x < 459; x++){
                displayController.DrawPixel(x, 50, 0xF800);     //Color is 31,0,0 (RGB565).
                displayController.DrawPixel(x, 51, 0xF800);
            }
        }
    }
}

```

SC20260D Dev Board display after running the sample code:

![Low Level Display Sample](../images/low-level-display-sample.jpg)
