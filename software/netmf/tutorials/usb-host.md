# USB Host
---

There is usually a lot of confusion between USB host and USB client. USB host is the system that connects to multiple USB clients. For example, the PC is a USB host and it can connect to multiple USB clients like mice, keyboards, and mass storage devices. Implementing a USB client is rather simple but implementing a host is far more complicated.

USB host is an exclusive feature from GHI Electronics. With this feature, you can connect almost any USB device to GHI's NETMF products. This feature opens new possibilities for embedded systems. Your product can now connect to a standard USB keyboard and can also access files on a USB thumb drive. USB is a hot pluggable system which means any device can be connected or disconnected at any time. Events are generated when devices are connected or disconnected. The program that you write should subscribe to these events and handle them accordingly. With USB hub support, devices can be connected directly to the USB host port or the user may connect multiple USB devices through a USB hub.

## Getting Started

When working with USB host, you interact with the Controller.  You subscribe to the connected event for various devices and then start the controller. When a device connected, you receive an object representing that device as the event arguments. You can subscribe to the Disconnect event on that device to do any clean up you might need.

The below code requires the GHI.Usb and GHI.Hardware assemblies and shows you briefly how to handle device connections and disconnections.

```cs
using GHI.Usb.Host;
using Microsoft.SPOT;
using System.Threading;

public class Program
{
    public static void Main()
    {
        Controller.DeviceConnectFailed += Controller_DeviceConnectFailed;
        Controller.KeyboardConnected += Controller_KeyboardConnected;

        Controller.Start();

        Thread.Sleep(-1);
    }

    private static void Controller_DeviceConnectFailed(object sender, EventArgs e)
    {
        Debug.Print("Failed.");
    }

    private static void Controller_KeyboardConnected(object sender, Keyboard keyboard)
    {
        Debug.Print("Keyboard connected.");

        keyboard.Disconnected += keyboard_Disconnected;
    }

    private static void keyboard_Disconnected(BaseDevice sender, EventArgs e)
    {
        Debug.Print("Keyboard disconnected.");
    }
}
```

## Mice, keyboards, and joysticks
Once you receive a connect event and the associated object for a mouse, keyboard, or joystick, you can subscribe to various events on those objects to receive data from the device. The below code simply prints out when a button or key is pressed.

```cs
using GHI.Usb.Host;
using Microsoft.SPOT;
using System.Threading;

public class Program
{
    public static void Main()
    {
        Controller.KeyboardConnected += Controller_KeyboardConnected;
        Controller.MouseConnected += Controller_MouseConnected;
        Controller.JoystickConnected += Controller_JoystickConnected;

        Controller.Start();

        Thread.Sleep(-1);
    }

    private static void Controller_KeyboardConnected(object sender, Keyboard keyboard)
    {
        Debug.Print("Keyboard connected.");

        keyboard.KeyUp += keyboard_KeyUp;
        keyboard.KeyDown += keyboard_KeyDown;
    }

    private static void Controller_MouseConnected(object sender, Mouse mouse)
    {
        Debug.Print("Mouse connected.");

        mouse.ButtonChanged += mouse_ButtonChanged;
        mouse.CursorMoved += mouse_CursorMoved;
        mouse.WheelMoved += mouse_WheelMoved;
    }

    private static void Controller_JoystickConnected(object sender, Joystick joystick)
    {
        Debug.Print("Joystick connected.");

        joystick.ButtonChanged += joystick_ButtonChanged;
        joystick.CursorMoved += joystick_CursorMoved;
        joystick.HatSwitchPressed += joystick_HatSwitchPressed;
    }

    private static void keyboard_KeyUp(Keyboard sender, Keyboard.KeyboardEventArgs e)
    {
        Debug.Print("Up: " + e.Which.ToString());
    }

    private static void keyboard_KeyDown(Keyboard sender, Keyboard.KeyboardEventArgs e)
    {
        Debug.Print("Down: " + e.Which.ToString());
    }

    private static void mouse_ButtonChanged(Mouse sender, Mouse.ButtonChangedEventArgs e)
    {
        Debug.Print(e.State.ToString() + " " + e.Which);
    }

    private static void mouse_CursorMoved(Mouse sender, Mouse.CursorMovedEventArgs e)
    {
        Debug.Print(e.Delta.ToString() + " " + e.NewPosition.ToString());
    }

    private static void mouse_WheelMoved(Mouse sender, Mouse.WheelMovedEventArgs e)
    {
        Debug.Print(e.Delta.ToString() + " " + e.NewPosition.ToString());
    }

    private static void joystick_ButtonChanged(Joystick sender, Joystick.ButtonChangedEventArgs e)
    {
        Debug.Print(e.State.ToString() + " " + e.Which);
    }

    private static void joystick_CursorMoved(Joystick sender, Joystick.CursorMovedEventArgs e)
    {
        Debug.Print(e.Delta.ToString() + " " + e.NewPosition.ToString() + " " + e.Which.ToString());
    }

    private static void joystick_HatSwitchPressed(Joystick sender, Joystick.HatSwitchPressedEventArgs e)
    {
        Debug.Print(e.Direction.ToString());
    }
}
```

## Serial

Serial (UART) communication is a very common interface. There are many companies that create chips that convert USB to serial. GHI currently supports chipsets from FTDI. Their FT232 is known to work, though others may as well. USB chipsets are made to be somewhat customized. A company can use an FTDI chip to make their product run on USB and they will change the strings in USB descriptors so that when you plug in their device to a PC you will see the company name and not FTDI. They can also change the USB VID/PID, vendor ID and product ID. Many of the interface products on the market use the FTDI chipset.

A few other USB-Serial manufacturers, like Prolific, are included, but they are deprecated and not supported by us.

The below example simply echoes any data received back out to the sender and prints it to the debug output.

```cs
using GHI.Usb.Host;
using Microsoft.SPOT;
using System.Threading;

public class Program
{
    public static void Main()
    {
        Controller.UsbSerialConnected += Controller_UsbSerialConnected;

        Controller.Start();

        Thread.Sleep(-1);
    }

    private static void Controller_UsbSerialConnected(object sender, UsbSerial usbSerial)
    {
        Debug.Print("UsbSerial connected.");

        usbSerial.DataReceived += usbSerial_DataReceived;
    }

    private static void usbSerial_DataReceived(UsbSerial sender, UsbSerial.DataReceivedEventArgs e)
    {
        for (int i = 0; i < e.Data.Length; i++)
            Debug.Print(e.Data[i].ToString());

        sender.Write(e.Data);
    }
}
```

##Mass Storage

When you connect a mass storage device, it can be accessed through the regular NETMF filesystem functions with the device root "USB". Once you mount the device, you need to wait for NETMF to fire the RemovableMedia.Insert event before you try accessing the filesystem.

The below code simply opens or creates a file on the drive, writes "Hello, World!" to it, and then unmounts the device. It requires the Microsoft.SPOT.IO and System.IO assembly.

```cs
using GHI.Usb.Host;
using Microsoft.SPOT;
using Microsoft.SPOT.IO;
using System.IO;
using System.Text;
using System.Threading;

public class Program
{
    private static AutoResetEvent evt = new AutoResetEvent(false);

    public static void Main()
    {
        Controller.MassStorageConnected += Controller_MassStorageConnected;

        Controller.Start();

        Thread.Sleep(-1);
    }

    private static void Controller_MassStorageConnected(object sender, MassStorage massStorage)
    {
        RemovableMedia.Insert += RemovableMedia_Insert;

        massStorage.Mount();

        evt.WaitOne();

        using (var fs = new FileStream("\\USB\\Hello.txt", FileMode.OpenOrCreate))
            fs.Write(Encoding.UTF8.GetBytes("Hello, World!"), 0, 13);

        massStorage.Unmount();
    }

    private static void RemovableMedia_Insert(object sender, MediaEventArgs e)
    {
        Debug.Print("Inserted.");

        evt.Set();
    }
}
```

## Warning
Under current versions of NETMF, the Flush method of FileStream will eventually write the buffers; unfortunately, there is a delay (sometimes up to a minute) from when Flush is called to when the data is actually flushed. See Files and Folders for more details.

## Webcams
You can also connect a webcam and stream images from it. Webcams only support certain image formats and sizes so you need to query the formats supported and tell the camera to stream images using that format. We support cameras that support the YUV2 color format.

The below code requires the Microsoft.SPOT.Graphics and Microsoft.SPOT.TinyCore assemblies. It looks for a format that has a size of 320x240 and starts to stream it. When a new image is available an event is raised and we draw the received image to the bitmap that represents our screen and then flush it. Make sure you have a display properly configured.

```cs
using GHI.Usb.Host;
using Microsoft.SPOT;
using Microsoft.SPOT.Presentation;
using System.Threading;

public class Program
{
    private static Bitmap lcd = new Bitmap(SystemMetrics.ScreenWidth, SystemMetrics.ScreenHeight);

    public static void Main()
    {
        Controller.WebcamConnected += Controller_WebcamConnected;
        
        Controller.Start();

        Thread.Sleep(-1);
    }

    private static void Controller_WebcamConnected(object sender, Webcam webcam)
    {
        webcam.ImageAvailable += webcam_ImageAvailable;

        foreach (Webcam.ImageFormat i in webcam.SupportedFormats)
        {
            if (i.Width == 320 && i.Height == 240)
            {
                webcam.StartStreaming(i);

                break;
            }
        }
    }

    private static void webcam_ImageAvailable(Webcam sender, EventArgs e)
    {
        sender.GetImage(lcd);
        lcd.Flush();
    }
}
```

## Unknown Devices
If your device is not recognized by our libraries, the UnknownDeviceConnected event will be triggered. This event will give you the USB parameters of the device that you can use to "force" the creation of a specific type. This method is not guaranteed to work with every unknown device, however. The below code illustrates how to do this with a usb to serial device.

```cs
using GHI.Usb.Host;
using Microsoft.SPOT;
using System.Threading;

public class Program
{
    private static UsbSerial serial;

    public static void Main()
    {
        Controller.UnknownDeviceConnected += Controller_UnknownDeviceConnected;

        Controller.Start();

        Thread.Sleep(-1);
    }

    private static void Controller_UnknownDeviceConnected(object sender, Controller.UnknownDeviceConnectedEventArgs e)
    {
        Debug.Print("Unknown device connected.");

        serial = new UsbSerial(e.Id, e.InterfaceIndex, e.VendorId, e.ProductId, e.PortNumber, BaseDevice.DeviceType.SerialProlific);
        serial.DataReceived += serial_DataReceived;
    }

    private static void serial_DataReceived(UsbSerial sender, UsbSerial.DataReceivedEventArgs e)
    {
        for (int i = 0; i < e.Data.Length; i++)
            Debug.Print(e.Data[i].ToString());

        sender.Write(e.Data);
    }

}
```
