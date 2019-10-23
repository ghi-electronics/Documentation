# Drawing
---
The `GHIElectronics.TinyCLR.Drawing` NuGet package includes the backbone for all graphics needs. It includes support for shapes, fonts and bitmaps.

Shape examples are `Graphics.FillEllipse`, `Graphics.DrawLine` and `Graphics.DrawRectangle`. These methods need `Pen` and `Brush` that are also part of `Graphics`.

TinyCLR OS has built in graphics methods for these displays. The following sample code runs on our UCM Dev Board with the UD435 Display option. You will need to add the `GHIElectronics.TinyCLR.Drawing`, `GHIElectronics.TinyCLR.Devices.Gpio` and `GHIElectronics.TinyCLR.Pins` NuGet package to your program.

The GPIO in this example is only used to control the display's backlight. Note that the backlight is on GPIO A on the UCM Dev Board. 

```cs
using System.Drawing;
using GHIElectronics.TinyCLR.Devices.Display;
using GHIElectronics.TinyCLR.Devices.Gpio;
using GHIElectronics.TinyCLR.Pins;

class Program {
    private static void Main() {
        UCMStandard.SetModel(UCMModel.UC5550); // Change to your specific board.
        var backlight = GpioController.GetDefault().OpenPin(UCMStandard.GpioPin.A);
        backlight.SetDriveMode(GpioPinDriveMode.Output);

        var displayController = DisplayController.GetDefault();

        // Enter the proper display configurations for the UD435
        displayController.SetConfiguration(new ParallelDisplayControllerSettings {
            Width = 480,
            Height = 272,
            DataFormat = DisplayDataFormat.Rgb565,
            HorizontalBackPorch = 46,
            HorizontalFrontPorch = 16,
            HorizontalSyncPolarity = false,
            HorizontalSyncPulseWidth = 1,
            DataEnableIsFixed = false,
            DataEnablePolarity = false,
            PixelClockRate = 16_000_000,
            PixelPolarity = false,
            VerticalBackPorch = 23,
            VerticalFrontPorch = 7,
            VerticalSyncPolarity = false,
            VerticalSyncPulseWidth = 1
        });

        displayController.Enable();
        backlight.Write(GpioPinValue.High);

        // Some needed objects
        var screen = Graphics.FromHdc(displayController.Hdc);
        var greenPen = new Pen(Color.Green, 5);
        var redPen = new Pen(Color.Red, 3);

        // Start Drawing (to memory)
        screen.Clear(Color.Black);
        screen.DrawEllipse(greenPen, 40, 30, 80, 60);
        screen.DrawLine(redPen, 0, 0, 479, 271);

        // Flush the memory to the display. This is a very fast operation.
        screen.Flush();
    }
}
```

The `DisplayController.ActiveConfiguration` can be used to read the configuration at any time. The Width and Height can be used to write code that automatically scales to the display's resolution. The example above can be changed to automatically draw a line from corner to corner, no matter the display resolution.

```cs
screen.DrawLine(redPen, 0, 0, displayController.ActiveConfiguration.Width-1, displayController.ActiveConfiguration.Height-1);
```

It is important to note that drawing functions process graphics in RAM independently from any display. The display driver then transfers the pixels from the internal memory to the display, through `Graphics.Flush`. Learn more about the [display](display.md) support.

## Images

TinyCLR OS supports BMP, GIF, and JPG. Depending on your hardware's limitation, one or more of these image formats maybe supported. Images can be loaded from a `stream` or simply load from [resources](../resources.md). 

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

Fonts are well supported. They are covered [here](font.md).
