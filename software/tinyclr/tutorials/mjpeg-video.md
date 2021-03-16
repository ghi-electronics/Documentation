# MJPEG Video
---
The MJPEG video format is simply a chain of JPG images that are stored in a single file.

The following code sample runs on the SC20100S Dev Board and plays an MJPEG video file that is stored on a USB flash drive.

> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Core, GHIElectronics.TinyCLR.Devices.Display, GHIElectronics.TinyCLR.Devices.Gpio, GHIElectronics.TinyCLR.Devices.I2c, GHIElectronics.TinyCLR.Devices.Spi, GHIElectronics.TinyCLR.Devices.Storage, GHIElectronics.TinyCLR.Drawing, GHIElectronics.TinyCLR.Media, GHIElectronics.TinyCLR.Drivers.Sitronix.ST7735, GHIElectronics.TinyCLR.IO, GHIElectronics.TinyCLR.Native, and GHIElectronics.TinyCLR.Pins.

```cs
class Program {
    private static ST7735.ST7735Controller st7735;
    private const int SCREEN_WIDTH = 128;
    private const int SCREEN_HEIGHT = 160;
    private static System.Drawing.Graphics graphic;

    private static void Main() {
        var spi = SpiController.FromName(SC20100.SpiBus.Spi3);

        var gpio = GpioController.GetDefault();

        st7735 = new ST7735.ST7735Controller(spi.GetDevice(ST7735.ST7735Controller.
            GetConnectionSettings(SpiChipSelectType.Gpio,SC20100.GpioPin.PD10)), //CS pin.

            gpio.OpenPin(SC20100.GpioPin.PC4), //RS pin.
            gpio.OpenPin(SC20100.GpioPin.PE15) //RESET pin.
        );

        var backlight = gpio.OpenPin(SC20100.GpioPin.PE5);
        backlight.SetDriveMode(GpioPinDriveMode.Output);
        backlight.Write(GpioPinValue.High);

        st7735.SetDataAccessControl(false, false, false, false);
        st7735.SetDrawWindow(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        st7735.Enable();

        st7735.SetDataAccessControl(true, true, false, false); //Rotate the screen.
        st7735.SetDrawWindow(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        st7735.Enable();

        //Create flush event
        Graphics.OnFlushEvent += Graphics_OnFlushEvent;

        //Create bitmap buffer
        graphic = Graphics.FromImage(new Bitmap
            (SCREEN_WIDTH, SCREEN_HEIGHT));

        var media = StorageController.FromName
            (SC20100.StorageController.UsbHostMassStorage);

        var drive = FileSystem.Mount(media.Hdc);

        var stream = new FileStream($@"A:\128x160.mjpeg", FileMode.Open);

        var settings = new Mjpeg.Setting();
        settings.BufferSize = 16 * 1024;
        settings.BufferCount = 3;

        var mjpegDecoder = new Mjpeg(settings);

        mjpegDecoder.FrameDecodedEvent += MjpegDecoder_FrameDecodedEvent;

        mjpegDecoder.StartDecode(stream); // Non-block function

        Thread.Sleep(Timeout.Infinite);
    }

    private static void MjpegDecoder_FrameDecodedEvent(byte[] data) {
        using (var image = new Bitmap(data, 0, data.Length,BitmapImageType.Jpeg)) {

            if (graphic != null) {
                graphic.DrawImage(image, 0, 0, image.Width, image.Height);
                graphic.Flush();
            }
        }

        GC.WaitForPendingFinalizers();
    }

    private static void Graphics_OnFlushEvent(System.Graphics sender, byte[] data, int x, int y, int width, int height, int originalWidth) {
        st7735.DrawBuffer(data);
    }
}
```

