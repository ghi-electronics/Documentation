# Camera Interface
---

Endpoint supports digital cameras through USB or the parallel interface (DCMI). 

## USB Cameras

The use of USB Cameras is straightforward and similar to using other USB devices. The [USB](usb.md) tutorials covers the details.

## DCMI Camera

Typically, DCMI cameras need two interfaces, the DCMI itself for transferring the images and an I2C bus for configuring the camera internal controller.

Endpoint includes experimental support for OV5640 cameras. Only I2C6 can be used with this camera.

```cs
var setting = new CameraConfiguration()
{
    Width = 640,
    Height = 480,
    ImageFormat = Format.Rgb565, //Format.Jpeg
    FrameRate = 15,

};

var webcam = new OV5640Controller(EPM815.I2c.I2c6, EPM815.Gpio.Pin.PG0, EPM815.Gpio.Pin.PZ3); // i2c, pin reset, power down
var resolutions = webcam.GetResolution();
webcam.Setting = setting;
var cnt = 0;
while (true)
{
    if (webcam != null)
    {
        var data = webcam.Capture();
        if (data != null)
        {
            if (setting.ImageFormat == Format.Rgb565)
            {
                // Show on screen
                //displayController.Flush(data, 0, data.Length, webcam.Width, webcam.Height);
            }
            else if (setting.ImageFormat == Format.Jpeg)
            {
                // Save to file
                using (var stream = File.Open($"/.epdata/{webcam.Width}x{webcam.Height}_{cnt}.jpeg", FileMode.Create))
                {
                    using (var writer = new BinaryWriter(stream, Encoding.UTF8, false))
                    {
                        writer.Write(data);

                    }
                }

            }
        }

    }

    Thread.Sleep(10);
}
```

