# MJPEG Video
---
The MJPEG video format is simply a chain of JPG images that are stored in a single file. SITCore's speed and its capacity to store large amounts of data allow for high performance MJPEG video playback.

The following code sample runs on the SC20100S Dev Board and plays an MJPEG video file that is stored on a USB flash drive.

> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Core, GHIElectronics.TinyCLR.Devices.Display, GHIElectronics.TinyCLR.Devices.Gpio, GHIElectronics.TinyCLR.Devices.I2c, GHIElectronics.TinyCLR.Devices.Spi, GHIElectronics.TinyCLR.Devices.Storage, GHIElectronics.TinyCLR.Drawing, GHIElectronics.TinyCLR.Drivers.Media, GHIElectronics.TinyCLR.Drivers.Sitronix.ST7735, GHIElectronics.TinyCLR.IO, GHIElectronics.TinyCLR.Native, and GHIElectronics.TinyCLR.Pins.

```cs
class Program {
    private static GHIElectronics.TinyCLR.Drivers.Sitronix.ST7735.ST7735Controller st7735;
    private const int SCREEN_WIDTH = 128;
    private const int SCREEN_HEIGHT = 160;
    private static System.Drawing.Graphics graphic;

    private static void Main() {
        var spi = GHIElectronics.TinyCLR.Devices.Spi.SpiController.FromName
            (GHIElectronics.TinyCLR.Pins.SC20100.SpiBus.Spi3);

        var gpio = GHIElectronics.TinyCLR.Devices.Gpio.GpioController.GetDefault();

        st7735 = new GHIElectronics.TinyCLR.Drivers.Sitronix.ST7735.ST7735Controller(
            spi.GetDevice(GHIElectronics.TinyCLR.Drivers.Sitronix.ST7735.ST7735Controller.
            GetConnectionSettings(GHIElectronics.TinyCLR.Devices.Spi.SpiChipSelectType.Gpio,
            GHIElectronics.TinyCLR.Pins.SC20100.GpioPin.PD10)), //CS pin.

            gpio.OpenPin(GHIElectronics.TinyCLR.Pins.SC20100.GpioPin.PC4), //RS pin.
            gpio.OpenPin(GHIElectronics.TinyCLR.Pins.SC20100.GpioPin.PE15) //RESET pin.
        );

        var backlight = gpio.OpenPin(GHIElectronics.TinyCLR.Pins.SC20100.GpioPin.PE5);
        backlight.SetDriveMode(GHIElectronics.TinyCLR.Devices.Gpio.GpioPinDriveMode.Output);
        backlight.Write(GHIElectronics.TinyCLR.Devices.Gpio.GpioPinValue.High);

        var displayController = GHIElectronics.TinyCLR.Devices.Display.DisplayController.
            FromProvider(st7735);

        st7735.SetDataAccessControl(false, false, false, false); //Rotate the screen.

        displayController.SetConfiguration(new GHIElectronics.TinyCLR.Devices.Display.
            SpiDisplayControllerSettings {

            Width = SCREEN_WIDTH,
            Height = SCREEN_HEIGHT,
            DataFormat = GHIElectronics.TinyCLR.Devices.Display.DisplayDataFormat.Rgb565
        });

        displayController.Enable();

        //Create flush event
        System.Drawing.Graphics.OnFlushEvent += Graphics_OnFlushEvent;

        //Create bitmap buffer
        graphic = System.Drawing.Graphics.FromImage(new System.Drawing.Bitmap
            (displayController.ActiveConfiguration.Width,
            displayController.ActiveConfiguration.Height));

        var media = GHIElectronics.TinyCLR.Devices.Storage.StorageController.FromName
            (GHIElectronics.TinyCLR.Pins.SC20100.StorageController.UsbHostMassStorage);

        var drive = GHIElectronics.TinyCLR.IO.FileSystem.Mount(media.Hdc);

        var stream = new System.IO.FileStream($@"A:\128x160.mjpeg", System.IO.FileMode.Open);

        var settings = new GHIElectronics.TinyCLR.Drivers.Media.Mjpeg.Setting();
        settings.BufferSize = 16 * 1024;
        settings.BufferCount = 3;

        var mjpegDecoder = new GHIElectronics.TinyCLR.Drivers.Media.Mjpeg(settings);

        mjpegDecoder.FrameDecodedEvent += MjpegDecoder_FrameDecodedEvent;

        mjpegDecoder.StartDecode(stream);

        System.Threading.Thread.Sleep(-1);
    }

    private static void MjpegDecoder_FrameDecodedEvent(byte[] data) {
        using (var image = new System.Drawing.Bitmap(data, 0, data.Length,
            System.Drawing.BitmapImageType.Jpeg)) {

            if (graphic != null) {
                graphic.DrawImage(image, 0, 0, image.Width, image.Height);
                graphic.Flush();
            }
        }

        System.GC.WaitForPendingFinalizers();
    }

    private static void Graphics_OnFlushEvent(System.IntPtr hdc, byte[] data) {
        st7735.DrawBuffer(data);
    }
}
```

