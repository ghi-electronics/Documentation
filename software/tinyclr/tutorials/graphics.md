# Graphics
---
The `GHIElectronics.TinyCLR.Drawing` NuGet package includes the backbone for all graphics needs. It has support for shapes, fonts and bitmaps.

Shape examples are `Graphics.FillEllipse`, `Graphics.DrawLine` and `Graphics.DrawRectangle`. These methods need `Pen` and `Brush` that are also part of `Graphics`.

Besides the basic methods above, there are some additional useful methods found inside the Graphics library. 

| Method                      | Description                                                |
|-----------------------------|------------------------------------------------------------|
| `TileImage`             | Used to tile the image over a any area on the screen.|
| `DrawTextInRect`        | Confines text to a specific rectangle area of the screen. Parameters can be set to justify or word wrap the text inside the rectangle's area.|
| `SetClippingRectangle`  | Creates a rectangle area on the screen where only the area within that rectangle is drawn.|
| `MakeTransparent`      | Used to select a color within an image that appears transparent.|
| `Scale9Image`           | Used to scale the size of an image. You can also stretch specific areas within the image itself, opacity can also be controlled.|
| `MeasureString`        | Used to measure a string size in pixels, when using a specific font.|
| `RotateImage`        | Used to rotate an image based on arguments passed.|

---

## Native Displays
Native display support in TinyCLR OS is handled automatically using the microcontroller's DMA to transfer data in parallel to the display without slowing down your application.

The following example runs on the SCM20260D Dev Board with either the 4.3" or 7" display. You will need to add a font and a small JPG image as [resources](resources.md) to run the code as is.


> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Core, GHIElectronics.TinyCLR.Devices.Display, GHIElectronics.TinyCLR.Devices.Gpio, GHIElectronics.TinyCLR.Devices.I2c, GHIElectronics.TinyCLR.Devices.Spi, GHIElectronics.TinyCLR.Drawing, GHIElectronics.TinyCLR.Native, GHIElectronics.TinyCLR.Pins.

```cs
using System.Drawing;
using System.Threading;
using GHIElectronics.TinyCLR.Devices.Display;
using GHIElectronics.TinyCLR.Devices.Gpio;
using GHIElectronics.TinyCLR.Pins;

namespace GraphicsSample {
    class Program {
        private static void Main() {
            GpioPin backlight = GpioController.GetDefault().OpenPin(SC20260.GpioPin.PA15);
            backlight.SetDriveMode(GpioPinDriveMode.Output);
            backlight.Write(GpioPinValue.High);

            var displayController = DisplayController.GetDefault();

            // Enter the proper display configurations
            displayController.SetConfiguration(new ParallelDisplayControllerSettings {
                Width = 480,
                Height = 272,
                DataFormat = DisplayDataFormat.Rgb565,
                Orientation = DisplayOrientation.Degrees0, //Rotate display.
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

            displayController.Enable(); //This line turns on the display I/O and starts
                                        //  refreshing the display. Native displays are
                                        //  continually refreshed automatically after this
                                        //  command is executed.

            var screen = Graphics.FromHdc(displayController.Hdc);

            var image = Resources.GetBitmap(Resources.BitmapResources.smallJpegBackground);
            var font = Resources.GetFont(Resources.FontResources.small);

            screen.Clear();

            screen.FillEllipse(new SolidBrush(System.Drawing.Color.FromArgb
                (255, 255, 0, 0)), 0, 0, 240, 136);

            screen.FillEllipse(new SolidBrush(System.Drawing.Color.FromArgb
                (255, 0, 0, 255)), 240, 0, 240, 136);

            screen.FillEllipse(new SolidBrush(System.Drawing.Color.FromArgb
                (128, 0, 255, 0)), 120, 0, 240, 136);

            screen.DrawImage(image, 216, 122);

            screen.DrawRectangle(new Pen(Color.Yellow), 10, 150, 140, 100);
            screen.DrawEllipse(new Pen(Color.Purple), 170, 150, 140, 100);
            screen.FillRectangle(new SolidBrush(Color.Teal), 330, 150, 140, 100);

            screen.DrawLine(new Pen(Color.White), 10, 271, 470, 271);
            screen.SetPixel(240, 200, Color.White);

            screen.DrawString("Hello world!", font, new SolidBrush(Color.Blue), 210, 255);

            screen.Flush();

            Thread.Sleep(Timeout.Infinite);
        }
    }
}
```

Same example but with 7 inch display, replace the display configuration code with the following code:

```cs
displayController.SetConfiguration(new ParallelDisplayControllerSettings {
    Width = 800,
    Height = 480,
    DataFormat = DisplayDataFormat.Rgb565,
    Orientation = DisplayOrientation.Degrees0, //Rotate display.
    PixelClockRate = 24000000,
    PixelPolarity = false,
    DataEnablePolarity = false,
    DataEnableIsFixed = false,
    HorizontalFrontPorch = 16,
    HorizontalBackPorch = 46,
    HorizontalSyncPulseWidth = 1,
    HorizontalSyncPolarity = false,
    VerticalFrontPorch = 7,
    VerticalBackPorch = 23,
    VerticalSyncPulseWidth = 1,
    VerticalSyncPolarity = false,
});
```

---

## Virtual Displays
Displays can be virtual, meaning the system handles the drawing in RAM and when `Flush` is called an event is fired with the graphics data that needs to be transferred to the display. This for example can be an SPI display or over-the-network display.

The following sample code runs on our SC20100S Dev Board with its SPI-based display. You will need to add a font and a small JPG image as [resources](resources.md) to run the code as is.

> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Core, GHIElectronics.TinyCLR.Devices.Display, GHIElectronics.TinyCLR.Devices.Gpio, GHIElectronics.TinyCLR.Devices.I2c, GHIElectronics.TinyCLR.Devices.Spi, GHIElectronics.TinyCLR.Drawing, GHIElectronics.TinyCLR.Drivers.Sitronix.ST7735, GHIElectronics.TinyCLR.Native, GHIElectronics.TinyCLR.Pins.

```cs
using System;
using System.Drawing;
using System.Threading;
using GHIElectronics.TinyCLR.Devices.Gpio;
using GHIElectronics.TinyCLR.Devices.Spi;
using GHIElectronics.TinyCLR.Drivers.Sitronix.ST7735;
using GHIElectronics.TinyCLR.Pins;

namespace GraphicsSample {
    class Program {
        private static ST7735Controller st7735;
        private const int SCREEN_WIDTH = 160;
        private const int SCREEN_HEIGHT = 128;

        private static void Main() {
            var spi = SpiController.FromName(SC20100.SpiBus.Spi4);
            var gpio = GpioController.GetDefault();

            st7735 = new ST7735Controller(
                spi.GetDevice(ST7735Controller.GetConnectionSettings
                (SpiChipSelectType.Gpio, gpio.OpenPin(SC20100.GpioPin.PD10))), //CS pin.
                gpio.OpenPin(SC20100.GpioPin.PC4), //RS pin.
                gpio.OpenPin(SC20100.GpioPin.PA15) //RESET pin.
            );

            var backlight = gpio.OpenPin(SC20100.GpioPin.PE5);
            backlight.SetDriveMode(GpioPinDriveMode.Output);
            backlight.Write(GpioPinValue.High);

            st7735.SetDataAccessControl(true, true, false, false); //Rotate the screen.
            st7735.SetDrawWindow(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            st7735.Enable();

            // Create flush event
            Graphics.OnFlushEvent += Graphics_OnFlushEvent;

            // Create bitmap buffer
            var screen = Graphics.FromImage(new Bitmap(SCREEN_WIDTH, SCREEN_HEIGHT));

            var image = Resources.GetBitmap(Resources.BitmapResources.
                smallJpegBackground);

            var font = Resources.GetFont(Resources.FontResources.small);

            screen.Clear();

            screen.FillEllipse(new SolidBrush(System.Drawing.Color.FromArgb
                (255, 255, 0, 0)), 0, 0, 80, 64);

            screen.FillEllipse(new SolidBrush(System.Drawing.Color.FromArgb
                (255, 0, 0, 255)), 80, 0, 80, 64);

            screen.FillEllipse(new SolidBrush(System.Drawing.Color.FromArgb
                (128, 0, 255, 0)), 40, 0, 80, 64);

            screen.DrawImage(image, 56, 50);

            screen.DrawRectangle(new Pen(Color.Yellow), 10, 80, 40, 25);
            screen.DrawEllipse(new Pen(Color.Purple), 60, 80, 40, 25);
            screen.FillRectangle(new SolidBrush(Color.Teal), 110, 80, 40, 25);

            screen.DrawLine(new Pen(Color.White), 10, 127, 150, 127);
            screen.SetPixel(80, 92, Color.White);

            screen.DrawString("Hello world!", font, new SolidBrush(Color.Blue), 50, 110);

            screen.Flush();
            Thread.Sleep(Timeout.Infinite);
        }

        private static void Graphics_OnFlushEvent(Graphics sender, byte[] data, int x, int y, int width, int height, int originalWidth) {
            st7735.DrawBuffer(data);
        }
    }
}
```

---

## Helper Methods

With parallel native displays the `DisplayController.ActiveConfiguration` can be used to read the configuration at any time. The Width and Height can be used to write code that automatically scales to the display's resolution. The following line of code draws a line from corner to corner, no matter the display resolution.

```cs
screen.DrawLine(new Pen(Color.Red), 0, 0, displayController.ActiveConfiguration.Width - 1,
    displayController.ActiveConfiguration.Height - 1);
```

---

## Images

TinyCLR OS supports BMP, GIF, and JPG file formats. See the [Image Decoders](image-decoders.md) page.

---

## Fonts

Fonts are fully supported. They are covered [here](font-support.md).

---

## Color Space

Internally, TinyCLR uses 5:6:5 RGB 16BPP color space. There are helper methods to convert to other color spaces. See [Encoding & Decoding](encoding-decoding.md) for more details.

---
## 2D Matrix copy
The built-in native 2D Matrix extract/copy is an simple, fast and efficient way to crop out an area of an image.

```cs
var groupSize = 2;
var screenWidth = 160;
var screenHeight = 128;
 
var screen = new Bitmap(screenWidth, screenHeight);

var imageNew = new byte[80 * 80 * 2];
var x = 5;
var y = 5;
var width = 80;
var height = 80;

Array.Copy2D(screen.GetBitmap(), imageNew, x, y, width, height, screenWidth, groupSize);
```
---

## VNC

VNC (Virtual Network Computing) is a simple remote desktop that with available terminals supported by major operating systems. It is covered [here](vnc.md).