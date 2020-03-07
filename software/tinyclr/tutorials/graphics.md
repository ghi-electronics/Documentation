# Graphics
---
The `GHIElectronics.TinyCLR.Drawing` NuGet package includes the backbone for all graphics needs. It has support for shapes, fonts and bitmaps.

Shape examples are `Graphics.FillEllipse`, `Graphics.DrawLine` and `Graphics.DrawRectangle`. These methods need `Pen` and `Brush` that are also part of `Graphics`.

## Native Displays
Native display support in TinyCLR OS is handled automatically using the microcontroller's DMA to transfer data to the display without slowing down your application. Because of this, native displays can be much larger in size and resolution while using less processor time than non-native displays. Additionally, native displays usually transfer data in parallel as opposed to the serial transfer usually used with non-native displays, so the data is transferred much more quickly.

### SCM20260D Dev Board Code Sample
The following example runs on the SCM20260D Dev Board with either the 4.3" or 7" display. You will need to add a font and a small JPG image as [resources](resources.md) to run the code as is.

#### With 4.3" Display

> [!Tip]
> Needed Nugets: GHIElectronics.TinyCLR.Core, GHIElectronics.TinyCLR.Devices.Display, GHIElectronics.TinyCLR.Devices.Gpio, GHIElectronics.TinyCLR.Devices.I2c, GHIElectronics.TinyCLR.Devices.Spi, GHIElectronics.TinyCLR.Drawing, GHIElectronics.TinyCLR.Native, GHIElectronics.TinyCLR.Pins.

> [!Tip]
> Make sure you change the namespace to match your project!

```cs
using GHIElectronics.TinyCLR.Devices.Display;
using GHIElectronics.TinyCLR.Devices.Gpio;
using GHIElectronics.TinyCLR.Pins;
using System.Drawing;
using System.Threading;

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

            var image = Resource1.GetBitmap(Resource1.BitmapResources.smallJpegBackground);
            var font = Resource1.GetFont(Resource1.FontResources.small);

            screen.Clear(Color.Black);

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
            screen.SetPixel(240, 200, 0xFF0000);

            screen.DrawString("Hello world!", font, new SolidBrush(Color.Blue), 210, 255);

            screen.Flush();

            Thread.Sleep(-1);
        }
    }
}
```

#### With 7" Display

If you are using the UD700 7 inch display, replace the display configuration code with the following code:
```cs
displayController.SetConfiguration(new ParallelDisplayControllerSettings {
    Width = 800,
    Height = 480,
    DataFormat = DisplayDataFormat.Rgb565,
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

## Non-Native Displays

Our SC20100S Dev Board has a non-native SPI display installed on it. There are special considerations for non-native displays -- instead of the data being automatically written to the display using the microcontroller's DMA, you must format and then transfer the data to the display yourself. Only the SC20260B SITCore chip has the resources to support native displays. Any device the uses the SC20100S chip can only support non-native displays.

At the bottom of the next code sample, you will notice a Graphics_OnFlushEvent() event handler. This method gets called when the display is flushed. In this case, there is a DrawBuffer method that is part of the ST7735 display driver that writes to the display over SPI. Because this method is available, you need only call it within the Graphics_OnFlushEvent() event handler to write the buffer to the display. If you are using a display without a driver, you will have to correctly format the display data and send it to the display yourself inside this event handler.

### SC20100S Dev Board Code Sample

The following sample code runs on our SC20100S Dev Board with its built in display. You will need to add a font and a small JPG image as [resources](resources.md) to run the code as is.

> [!Tip]
> Needed Nugets: GHIElectronics.TinyCLR.Core, GHIElectronics.TinyCLR.Devices.Display, GHIElectronics.TinyCLR.Devices.Gpio, GHIElectronics.TinyCLR.Devices.I2c, GHIElectronics.TinyCLR.Devices.Spi, GHIElectronics.TinyCLR.Drawing, GHIElectronics.TinyCLR.Drivers.Sitronix.ST7735, GHIElectronics.TinyCLR.Native, GHIElectronics.TinyCLR.Pins.

> [!Tip]
> Make sure you change the namespace to match your project! 

```cs
using GHIElectronics.TinyCLR.Devices.Display;
using GHIElectronics.TinyCLR.Devices.Gpio;
using GHIElectronics.TinyCLR.Devices.Spi;
using GHIElectronics.TinyCLR.Drivers.Sitronix.ST7735;
using GHIElectronics.TinyCLR.Pins;
using System;
using System.Drawing;
using System.Threading;

namespace GraphicsSample {
    class Program {
        private static ST7735Controller st7735;
        private const int SCREEN_WIDTH = 160;
        private const int SCREEN_HEIGHT = 128;

        private static void Main() {
            var spi = SpiController.FromName(SC20100.SpiBus.Spi3);
            var gpio = GpioController.GetDefault();

            st7735 = new ST7735Controller(
                spi.GetDevice(ST7735Controller.GetConnectionSettings
                (SpiChipSelectType.Gpio, SC20100.GpioPin.PD10)), //CS pin.
                gpio.OpenPin(SC20100.GpioPin.PC4), //RS pin.
                gpio.OpenPin(SC20100.GpioPin.PE15) //RESET pin.
            );

            var backlight = gpio.OpenPin(SC20100.GpioPin.PE5);
            backlight.SetDriveMode(GpioPinDriveMode.Output);
            backlight.Write(GpioPinValue.High);

            var displayController = DisplayController.FromProvider(st7735);
            st7735.SetDataAccessControl(true, true, false, false); //Rotate the screen.
            
            displayController.SetConfiguration(new SpiDisplayControllerSettings
                { Width = SCREEN_WIDTH,
                Height = SCREEN_HEIGHT,
                DataFormat = DisplayDataFormat.Rgb565 });
            
            displayController.Enable();

            // Create flush event
            Graphics.OnFlushEvent += Graphics_OnFlushEvent;

            // Create bitmap buffer
            var screen = Graphics.FromImage(new Bitmap
                (displayController.ActiveConfiguration.Width, 
                displayController.ActiveConfiguration.Height));

            var image = Resource1.GetBitmap(Resource1.BitmapResources.smallJpegBackground);
            var font = Resource1.GetFont(Resource1.FontResources.small);

            screen.Clear(Color.Black);

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
            screen.SetPixel(80, 92, 0xFF0000);

            screen.DrawString("Hello world!", font, new SolidBrush(Color.Blue), 50, 110);

            screen.Flush();
            Thread.Sleep(-1);
        }

        private static void Graphics_OnFlushEvent(IntPtr hdc, byte[] data) {
            st7735.DrawBuffer(data);
        }
    }
}
```

## Helper Methods
The `DisplayController.ActiveConfiguration` can be used to read the configuration at any time. The Width and Height can be used to write code that automatically scales to the display's resolution. The following line of code draws a line from corner to corner, no matter the display resolution.

```cs
screen.DrawLine(new Pen(Color.Red), 0, 0, displayController.ActiveConfiguration.Width - 1,
    displayController.ActiveConfiguration.Height - 1);
```

It is important to note that drawing functions process graphics in RAM independently from the display. The display driver then transfers the pixels from internal memory to the display when `Graphics.Flush` is called. Learn more about [display](displays.md) support.

## Images

TinyCLR OS supports the BMP, GIF, and JPG. See the [Image Decoders](image-decoders.md) page.

## Fonts

Fonts are well supported. They are covered [here](font-support.md).
