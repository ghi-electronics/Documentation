# Graphics
---

## Introduction
NETMF provides excellent support for graphics through the Bitmap class (that we also supplement with our Glide library). It can draw various shapes, text, and images from BMPs, JPGs, and GIFs -- which can be obtained from the file system, network, or resources.

When drawing on a bitmap, everything is rendered on an in-memory object that can be quite large depending on your screen size. To transfer a bitmap object from memory to the screen, we need to call Flush on the bitmap object. Flush will only work if the size of the bitmap is exactly the size of the screen. If it is any other size, no image will be displayed.

## Non-Native Support
Some smaller devices do not have a built in LCD controller. As a result, they can only use displays through a different type of bus, often SPI. Depending on your exact display, you may need to call a display specific function in its driver to draw on the scree. However, some SPI displays do support the Flush method on bitmaps, so be sure to consult your display documentation.

## Display Configuration
In order to use a display, you must configure it. You can select the display type from FEZ Config on the LCD Configuration tab or you can execute the below code (make sure to select your actual display). After you set the configuration, the device must reboot for it to take effect. The Save method returns whether or not a reboot is needed.

If you are using a display that is not present under GHIDisplay, you will need to configure the properties on the Display object instead of calling the Populate method.

```cs
using GHI.Processor;
using Microsoft.SPOT.Hardware;

public class Program
{
    public static void Main()
    {
        Display.Populate(Display.GHIDisplay.DisplayCP7);

        if (Display.Save())
            PowerState.RebootDevice(false);

        //Display is now configured.
    }
}
```

## Drawing
The following example draws a line and an ellipse on the screen. The assemblies Microsoft.SPOT.Graphics and Microsoft.SPOT.TinyCore are required.

```cs
using Microsoft.SPOT;
using Microsoft.SPOT.Presentation;
using Microsoft.SPOT.Presentation.Media;

public class Program
{
    public static void Main()
    {
        Bitmap lcd = new Bitmap(SystemMetrics.ScreenWidth, SystemMetrics.ScreenHeight);

        lcd.DrawLine(Colors.Green, 1, 20, 20, 40, 40);
        lcd.DrawEllipse(Colors.Blue, 5, 5, 5, 5);

        lcd.Flush();
    }
}
```
## Text
The following code shows how to display text using NETMF. Since resources depend on your project's default namespace, make sure that you change the namespace in this example to match your namespace. If you do not currently have a font resource in your project, NETMF ships with two default fonts that you can add as a resource found in C:\Program Files (x86)\Microsoft .NET Micro Framework\v4.3\Fonts. You can find the NinaB font that we use below in that folder.

```cs
using Microsoft.SPOT;
using Microsoft.SPOT.Presentation;
using Microsoft.SPOT.Presentation.Media;

namespace your_namespace
{
    public class Program
    {
        public static void Main()
        {
            Font font = Resources.GetFont(Resources.FontResources.NinaB);
            Bitmap lcd = new Bitmap(SystemMetrics.ScreenWidth, SystemMetrics.ScreenHeight);

            lcd.DrawText("Hello, World!", font, Colors.White, 0, 0);

            lcd.Flush();
        }
    }
}
```
Adding new fonts to your application is very easy. TTL fonts can be converted to the simple font format used in NETMF using the TinyFont tool

## SPI Displays
If you are using a G80 or Cerb based device and a SPI display, you can configure the device so that when you call Flush on a bitmap, it is automatically sent to the display.

If the ControlPin is provided, the draw window will automatically be set, the data byte will be sent, and the ControlPin will be set high for you when you call Flush. The display will also be initialized on the first call to Flush. Additionally, the backlight pin will automatically be set high if provided on the first call to Flush. Lastly, if ResetPin is provided, it will be toggled before initialization.

If your device does not have enough memory to create a bitmap for the entire screen, you can create a smaller one and only draw to a subset of the display. You can set the draw window on the display to match that new size and pick which position it is drawn at. Doing this multiple times allows you to draw the entire screen by moving the draw window around and redrawing the bitmap.

The below example shows how to do this on the FEZ Cerberus and requires the GHI.Hardware, Microsoft.SPOT.Graphics, and Microsoft.SPOT.Hardware assemblies. Make sure you properly set any pins other configuration below for your actual device bearing in mind the above considerations. If you are not using the DisplayN18, you must configure the display before first use and set the draw window before you call Flush every time.

```cs
using GHI.Pins;
using GHI.Processor;
using GHI.Utilities;
using Microsoft.SPOT;
using Microsoft.SPOT.Hardware;
using Microsoft.SPOT.Presentation.Media;

public class Program {
    public static void Main() {
        Display.Width = 128;
        Display.Height = 160;
        Display.Type = Display.DisplayType.Spi;
        Display.CurrentRotation = Display.Rotation.Normal;
        Display.BitmapFormat = Bitmaps.Format.Bpp16BgrLe;
        Display.SpiModule = FEZCerberus.Socket5.SpiModule;
        Display.ChipSelectPin = FEZCerberus.Socket5.Pin6;
        Display.ResetPin = FEZCerberus.Socket5.Pin3;
        Display.BacklightPin = FEZCerberus.Socket5.Pin4;
        Display.ControlPin = FEZCerberus.Socket5.Pin5;
        Display.Save();

        var bmp = new Bitmap(Display.Width, Display.Height);
        bmp.DrawEllipse(Colors.Red, 5, 5, 5, 5);
        bmp.DrawEllipse(Colors.Green, 15, 5, 5, 5);
        bmp.DrawEllipse(Colors.Blue, 25, 5, 5, 5);
    }
}
```

## Gadgeteer
When using Gadgeteer display modules, the SimpleGraphics interface is provided for you. It provides an API that is a bit easier to use than regular NETMF bitmaps. It is available as the SimpleGraphics property on every display.

The below example shows how to display an ellipse, line, and some text. Make sure that you change the namespace to match yours. Gadgeteer programs automatically add the NinaB font to your project so you do not need to worry about adding it yourself.

```cs
using GT = Gadgeteer;

namespace your_namespace
{
    public partial class Program
    {
        void ProgramStarted()
        {
            this.displayCP7.SimpleGraphics.DisplayEllipse(GT.Color.Red, 1, GT.Color.Red, 5, 5, 5, 5);
            this.displayCP7.SimpleGraphics.DisplayLine(GT.Color.Blue, 1, 20, 20, 40, 40);
            this.displayCP7.SimpleGraphics.DisplayText("Hello, World!", Resources.GetFont(Resources.FontResources.NinaB), GT.Color.Green, 60, 60);
        }
    }
}
```
