# Camera Interface
---
For devices with digital camera interface, sometimes called DCMI or DCI, TinyCLR OS includes the necessary drivers. Typically, cameras need to be configured using [I2C bus](i2c.md). Please refer to the camera’s manuals to determine the needed configuration.

The function to capture from the camera will be from this line in the driver.  
```
public void Capture(byte[] data, int timeoutMillisecond) => this.cameraController.Capture(data, timeoutMillisecond);
```
Don't forget you still have to configure your camera before you capture, check the Omnivision/Ov9655 driver under
https://github.com/ghi-electronics/TinyCLR-Drivers for an example of how to configure your camera 

This example configures and shows the camera on the display on the SCM20260D Dev Board.

```csharp
using GHIElectronics.TinyCLR.Devices.Gpio;
using System.Drawing;
using System.Diagnostics;
using GHIElectronics.TinyCLR.Devices.I2c;
using GHIElectronics.TinyCLR.Native;
using GHIElectronics.TinyCLR.Drivers.Omnivision.Ov9655;
using GHIElectronics.TinyCLR.Pins;


class Program
{
    static void Test_Dcmi()
    {
        GpioPin backlight = GpioController.GetDefault().OpenPin(SC20260.GpioPin.PA15);
        backlight.SetDriveMode(GpioPinDriveMode.Output);
        backlight.Write(GpioPinValue.High);

        var displayController = GHIElectronics.TinyCLR.Devices.Display.DisplayController.GetDefault();

        var controllerSetting = new GHIElectronics.TinyCLR.Devices.Display.ParallelDisplayControllerSettings
        {
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
        };

        displayController.SetConfiguration(controllerSetting);
        displayController.Enable();

        var screen = Graphics.FromHdc(displayController.Hdc);
        var controller = I2cController.GetDefault();

        // Camera
        var ov9655 = new Ov9655(controller);

        var id = ov9655.ReadId();

        Debug.WriteLine("id = " + id);

        var ptr = Memory.UnmanagedMemory.Allocate(640 * 480 * 2);
        var data = Memory.UnmanagedMemory.ToBytes(ptr, 640 * 480 * 2);

        ov9655.SetResolution(Ov9655.Resolution.Vga);

        byte temp = 0;

        while (true)
        {
            try
            {
                ov9655.Capture(data, 100);

                displayController.DrawBuffer(0, 0, 0, 0, 480, 270, 640, data, 0);
            }
            catch (System.Exception)
            { }
        }
    }
    static void Main()
    {
        Test_Dcmi();
    }
}
```

