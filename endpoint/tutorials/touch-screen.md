# Touch Screen
---

## Introduction
Displays may optionally include a touch sensitive screen to detect user touch input. Endpoint supports capacitive touch.

---

## Capacitive Touch

Capacitive touch screens are used on most modern devices, including phones. They are very accurate and capable of detecting multiple simultaneous touches.

A special capacitive controller chip must be used to read the touch panel. This chip is usually mounted right on the flat cable going to the touch panel. These chips are usually I2C or SPI, with I2C being more common.

The capacitive displays used in our development options use a touch controller from FocalTech.

We provide the `GHIElectronics.Endpoint.Drivers.FocalTech.FT5xx6` NuGet package to interact with capacitive touch screens. The constructor simply needs to know which I2C bus and reset pin are being used. The event fires giving the exact position using display pixels as units -- there is no need for scaling or calibration. The driver source code is found on the [Endpoint Drivers repo](https://github.com/ghi-electronics/endpoint-drivers).

This simple example will draw the touch x and y coordinates on the screen.

```cs
using System.Device.Gpio;
using System.Device.Gpio.Drivers;
using SkiaSharp;
using GHIElectronics.Endpoint.Core;
using GHIElectronics.Endpoint.Devices.Display;
using GHIElectronics.Endpoint.Drivers.FocalTech.FT5xx6;

//Initialize Screen
var screenWidth = 480;
var screenHeight = 272;
var backlightPort = EPM815.Gpio.Pin.PD14 / 16;
var backlightPin = EPM815.Gpio.Pin.PD14 % 16;

var backlightDriver = new LibGpiodDriver((int)backlightPort);
var backlightController = new GpioController(PinNumberingScheme.Logical, backlightDriver);
backlightController.OpenPin(backlightPin);
backlightController.SetPinMode(backlightPin, PinMode.Output);
backlightController.Write(backlightPin, PinValue.High);

var configuration = new FBDisplay.ParallelConfiguration(){
    Clock = 10000,
    Width = 480,
    Hsync_start = 480 + 2,
    Hsync_end = 480 + 2 + 41,
    Htotal = 480 + 2 + 41 + 2,
    Height = 272,
    Vsync_start = 272 + 2,
    Vsync_end = 272 + 2 + 10,
    Vtotal = 272 + 2 + 10 + 2,
};
var fbDisplay = new FBDisplay(configuration);
var displayController = new DisplayController(fbDisplay);

//Initialize Touch
var touchX = 0;
var touchY = 0;
var TouchResetPin = EPM815.Gpio.Pin.PF2 % 16;
var TouchResetPort = EPM815.Gpio.Pin.PF2 / 16;
var TouchController = new GpioController(PinNumberingScheme.Logical, new LibGpiodDriver(TouchResetPort));
TouchController.OpenPin(TouchResetPin);
TouchController.Write(TouchResetPin, PinValue.Low);
Thread.Sleep(100);
TouchController.Write(TouchResetPin, PinValue.High);
EPM815.I2c.Initialize(EPM815.I2c.I2c5);
var touch = new FT5xx6Controller(EPM815.I2c.I2c5, EPM815.Gpio.Pin.PB11);
touch.TouchUp += Touch_TouchUp;

//Initialize Graphics
SKBitmap bitmap = new SKBitmap(screenWidth, screenHeight, SKImageInfo.PlatformColorType, SKAlphaType.Premul);
bitmap.Erase(SKColors.Transparent);

while (true){
    using (var screen = new SKCanvas(bitmap)){

        //Create Black Screen 
        screen.DrawColor(SKColors.Black);
        screen.Clear(SKColors.Black);
        // Draw X
        using (SKPaint text = new SKPaint()){
            text.Color = SKColors.White;
            text.IsAntialias = true;
            text.StrokeWidth = 2;
            text.Style = SKPaintStyle.Fill;
            SKFont sKFont = new SKFont();
            sKFont.Size = 60;

            SKTextBlob textBlob = SKTextBlob.Create("Touch X =" + touchX.ToString(), sKFont);
            screen.DrawText(textBlob, 60, 125, text);
        }
        // Draw Y
        using (SKPaint text = new SKPaint()){
            text.Color = SKColors.White;
            text.IsAntialias = true;
            text.StrokeWidth = 2;
            text.Style = SKPaintStyle.Fill;
            SKFont sKFont = new SKFont();
            sKFont.Size = 60;

            SKTextBlob textBlob = SKTextBlob.Create("Touch Y =" + touchY.ToString(), sKFont);
            screen.DrawText(textBlob, 60, 175, text);
        }
        // Flush to screen
        var data = bitmap.Copy(SKColorType.Rgb565).Bytes;
        displayController.Flush(data);
        Thread.Sleep(1);
    }
}
void Touch_TouchUp(FT5xx6Controller sender, FT5xx6Controller.TouchEventArgs e){
    touchX = e.X;
    touchY = e.Y;
    return;
}
```
