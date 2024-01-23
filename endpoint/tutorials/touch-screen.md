# Touch Screen
---

## Introduction
Displays may optionally include a touch sensitive screen to detect user touch input. Touch Screens can be resistive or capacitive.



---

## Resistive Touch

A resistive touch screen measures the resistance across the X and Y axes to determine the touch position. While it is possible to use GPIO and ADC, it is better to use dedicated chips. The only advantage of resistive touch over capacitive is that resistive touch works through a change in resistance induced by finger pressure, meaning you can use it while wearing gloves. However, resistive touch is not very accurate and requires calibration.

Unless you have specific reason to use resistive touch, capacitive touch is preferred.

The NuGet package `GHIElectronics.TinyCLR.Drivers.Touch.ResistiveTouch` simplifies the process of adding resistive touch to a project. The code example below details how it is used.  

```cs
var touch = new ResistiveTouchController(
    320, // Screen width
    240, // Screen height
    SC20260.GpioPin.PA0,  // digital pin support analog
    SC20260.GpioPin.PA3,  // digital pin support analog
    SC20260.GpioPin.PA5,  // digital pin
    SC20260.GpioPin.PC3,  // digital pin
    SC20260.Adc.Controller1.Id, // Analog controller id
    SC20260.Adc.Controller1.PA0, // analog channel id
    SC20260.Adc.Controller1.PA3 // analog channel id
    );

touch.ScaleX = new Scale(20, 280); // option to get more accurate point
touch.ScaleY = new Scale(20, 200); // option to get more accurate point

while (true)
{
    Thread.Sleep(100); // poll interval every 100ms

    var x = touch.X;
    var y = touch.Y;

    if (x >= 0 && y >= 0) // detected touch
        Debug.WriteLine("X: " + x +", Y = " + y);
}
```

---

## Capacitive Touch

Capacitive touch screens are used on most modern devices, including phones. They are very accurate and capable of detecting multiple simultaneous touches.

A special capacitive controller chip must be used to read the touch panel. This chip is usually mounted right on the flat cable going to the touch panel. These chips are usually I2C or SPI, with I2C being more common.

The capacitive displays used in our development options use a touch controller from FocalTech.

We provide the `GHIElectronics.TinyCLR.Drivers.FocalTech.FT5xx6` NuGet package to interact with capacitive touch screens. The constructor simply needs to know which I2C bus and reset pin are being used. The event fires giving the exact position using display pixels as units -- there is no need for scaling or calibration. The driver source code is found on the [TinyCLR Drivers repo](https://github.com/ghi-electronics/TinyCLR-Drivers).

This simple example will draw a dot on touch move:

```cs
using GHIElectronics.TinyCLR.Drivers.FocalTech.FT5xx6;

var touch = new FT5xx6Controller(
    i2cController.GetDevice(FT5xx6Controller.GetConnectionSettings()),
    gpioController.OpenPin(SC20260.GpioPin.PJ14));

touch.Orientation = FT5xx6Controller.TouchOrientation.Degrees0; //Rotate touch coordinates.

touch.TouchMove += (_, e) => {
    screen.FillEllipse(brush, e.X, e.Y, 5, 5);
    screen.Flush();
};
```
