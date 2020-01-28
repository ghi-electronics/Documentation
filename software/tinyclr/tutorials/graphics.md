# Graphics
---
The `GHIElectronics.TinyCLR.Drawing` NuGet package includes the backbone for all graphics needs. It includes support for shapes, fonts and bitmaps.

Shape examples are `Graphics.FillEllipse`, `Graphics.DrawLine` and `Graphics.DrawRectangle`. These methods need `Pen` and `Brush` that are also part of `Graphics`.

TinyCLR OS has built in graphics methods for these displays. The following sample code runs on our SC20100 Dev Board with its built in display.

> [!Tip]
> Nugets: GHIElectronics.TinyCLR.Drawing, GHIElectronics.TinyCLR.Devices.Display, GHIElectronics.TinyCLR.Devices.Gpio, GHIElectronics.TinyCLR.Pins
> 
> Usings: GHIElectronics.TinyCLR.Devices.Display, GHIElectronics.TinyCLR.Devices.Gpio, GHIElectronics.TinyCLR.Devices.Pins, System.Drawing


The GPIO in this example is only used to control the display's backlight. Note that the backlight is on PE5 on the SITCore Sc20100 Dev Board. 

```csharp
using GHIElectronics.TinyCLR.Devices.Display;
using GHIElectronics.TinyCLR.Devices.Gpio;
using GHIElectronics.TinyCLR.Devices.Spi;
using GHIElectronics.TinyCLR.Drivers.Sitronix.ST7735;
using GHIElectronics.TinyCLR.Pins;
using System;
using System.Drawing;
using System.Threading;

namespace SITCoreTestCodeForDocs {

    class Program {
        private static ST7735Controller st7735;
        private const int SCREEN_WIDTH = 160;
        private const int SCREEN_HEIGHT = 128;

        private static void Main() {
            var spi = SpiController.FromName(SC20100.SpiBus.Spi3);
            var gpio = GpioController.GetDefault();

            st7735 = new ST7735Controller(
                spi.GetDevice(ST7735Controller.GetConnectionSettings(SpiChipSelectType.Gpio, SC20100.GpioPin.PD10)), //CS pin.
                gpio.OpenPin(SC20100.GpioPin.PC4), //RS pin.
                gpio.OpenPin(SC20100.GpioPin.PE15) //RESET pin.
            );

            var backlight = gpio.OpenPin(SC20100.GpioPin.PE5);
            backlight.SetDriveMode(GpioPinDriveMode.Output);
            backlight.Write(GpioPinValue.High);

            var displayController = DisplayController.FromProvider(st7735);
            st7735.SetDataAccessControl(true, true, false, false); //Rotate the screen.
            displayController.SetConfiguration(new SpiDisplayControllerSettings { Width = SCREEN_WIDTH, Height = SCREEN_HEIGHT, DataFormat = DisplayDataFormat.Rgb565 });
            displayController.Enable();

            // Create flush event
            Graphics.OnFlushEvent += Graphics_OnFlushEvent;

            // Create bitmap buffer
            var screen = Graphics.FromImage(new Bitmap(displayController.ActiveConfiguration.Width, displayController.ActiveConfiguration.Height));
            var image = Resource1.GetBitmap(Resource1.BitmapResources.smallJpegBackground);
            var font = Resource1.GetFont(Resource1.FontResources.small);

            screen.Clear(Color.Black);
            screen.FillEllipse(new SolidBrush(System.Drawing.Color.FromArgb(255, 255, 0, 0)), 0, 0, 80, 64);
            screen.FillEllipse(new SolidBrush(System.Drawing.Color.FromArgb(255, 0, 0, 255)), 80, 0, 80, 64);
            screen.FillEllipse(new SolidBrush(System.Drawing.Color.FromArgb(128, 0, 255, 0)), 40, 0, 80, 64);

            screen.DrawImage(image, 56,50);

            screen.DrawRectangle(new Pen(System.Drawing.Color.Yellow), 10, 80, 40, 25);
            screen.DrawEllipse(new Pen(Color.Purple), 60, 80, 40, 25);
            screen.FillRectangle(new SolidBrush(Color.Teal), 110, 80, 40,25);

            screen.DrawString("Hello, world", font, new SolidBrush(Color.Blue), 50,110);

            screen.Flush();
            Thread.Sleep(-1);
        }
        private static void Graphics_OnFlushEvent(IntPtr hdc, byte[] data) {
            st7735.DrawBuffer(data);
        }
    }
}
```

The `DisplayController.ActiveConfiguration` can be used to read the configuration at any time. The Width and Height can be used to write code that automatically scales to the display's resolution. The example above can be changed to automatically draw a line from corner to corner, no matter the display resolution.

```cs
screen.DrawLine(redPen, 0, 0, displayController.ActiveConfiguration.Width-1, displayController.ActiveConfiguration.Height-1);
```

It is important to note that drawing functions process graphics in RAM independently from any display. The display driver then transfers the pixels from the internal memory to the display, through `Graphics.Flush`. Learn more about the [display](displays.md) support.

## Images

TinyCLR OS supports BMP, GIF, and JPG. Depending on your hardware's limitation, one or more of these image formats maybe supported. Images can be loaded from a `stream` or simply load from [resources](resources.md). 

> [!Tip]
> BMP supports 256 colors and 24bit.
> GIF does not support animated images.

```cs
var screen = Graphics.FromHdc(displayController.Hdc);
var logo = Resource.GetBitmap(Resource.BitmapResources.GHI_Electronics_Logo);
screen.DrawImage(logo, 50, 150);
screen.Flush();
```

## Fonts

Fonts are well supported. They are covered [here](font-support.md).
