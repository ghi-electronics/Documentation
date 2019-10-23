# USB Client
---

By default, all of GHI's NETMF devices use USB for deploying and debugging. You may optionally use the USB client (not the host) for something other than debugging. This is actually supported by NETMF and GHI adds more functionality making it even easier to use.

Say you are making a device that that reads temperature and humidity and logs all of this data on an SD card. This device can be configured to set the time or give file names and you want this configuration to happen over USB, perhaps in the field. So when your device plugs into a USB port, you want it to show as a virtual serial port. This way, anyone can open a terminal software (like TeraTerm) to connect to your device and configure it.

Using the USB client, there is no need to add the extra cost of additional RS232 serial ports or USB<->serial chipsets. The built-in USB client port can be configured to act as a CDC device, a virtual COM port. However, you still need to connect the PC to your device for debugging and deploying applications. Since the USB client port is used by your end application, you need to debug and deploy using a serial connection. You only need the serial interface in the development and deployment stage.

##Setting Up

Debugging and deploying serially is specific to each device so you may want to consult your device's manual or Developers' Guide. Once the device is configured for the serial interface, remember to select the proper transport in Visual Studio.
 
> [!Tip]
> The examples shown below require the Microsoft.SPOT.Hardware.Usb and GHI.Usb assemblies.

## Mouse
The following example tells your device to act as a mouse and send random commands to your computer. You could use this to prank others and send their computer fake mouse commands or to have a second mouse for your own computer.

```cs
using System;
using System.Threading;
using GHI.Usb;
using GHI.Usb.Client;
using Microsoft.SPOT;
using Microsoft.SPOT.Hardware.UsbClient;

public class Program
{
    public static void Main()
    {
        // Start Mouse

        Mouse mouse = new Mouse();
		  Controller.ActiveDevice = mouse;

        // Move pointer in a swirl
        const int ANGLE_STEP_SIZE = 15;
        const int MIN_CIRCLE_DIAMETER = 50;
        const int MAX_CIRCLE_DIAMETER = 200;
        const int CIRCLE_DIAMETER_STEP_SIZE = 1;

        int diameter = MIN_CIRCLE_DIAMETER;
        int diameterIncrease = CIRCLE_DIAMETER_STEP_SIZE;
        int angle = 0;
        int factor;
        Random rnd = new Random();
        int i = 0;

        while (true)
        {
            // we want to do it every sometime randomely
            i = rnd.Next(5000) + 5000;//between 5 and 10 seconds
            Debug.Print("Delaying for " + i + " ms");
            Thread.Sleep(i);
            i = rnd.Next(200) + 100;//do it for a short time    
            Debug.Print("Looping " + i + " times!");

            while (i-- > 0)
            {
                // Check if connected to PC
                
                if (Controller.State ==
                    UsbController.PortState.Running)
                {
                    // Note Mouse X, Y are reported as change in position 
                    // (relative position, not absolute)
                    factor = diameter * ANGLE_STEP_SIZE *
                             (int)System.Math.PI / 180 / 2;
                    int dx = (-1 * factor *
                              (int)Microsoft.SPOT.Math.Sin(angle) / 1000);
                    int dy = (factor *
                              (int)Microsoft.SPOT.Math.Cos(angle) / 1000);

                    angle += ANGLE_STEP_SIZE;
                    diameter += diameterIncrease;

                    if (diameter >= MAX_CIRCLE_DIAMETER ||
                        diameter <= MIN_CIRCLE_DIAMETER
                        )
                        diameterIncrease *= -1;

                    // report mouse position
                    mouse.SendRawData(dx, dy, 0,Buttons.None);
                }

                Thread.Sleep(10);
            }
        }
    }
}
```

## Keyboard
Emulating a keyboard is as very similar to emulating a mouse. The following example will create a USB Keyboard and send "Hello world!" to a computer every second.

```cs
using System.Threading;
using GHI.Usb;
using GHI.Usb.Client;
using Microsoft.SPOT;
using Microsoft.SPOT.Hardware.UsbClient;

public class Program
{
    public static void Main()
    {
        // Start keyboard
       Keyboard kb = new Keyboard();
		  Controller.ActiveDevice = kb;
        Debug.Print("Waiting to connect to PC...");
        // Send "Hello world!" every second
        while (true)
        {
            // Check if connected to PC
            if ( Controller.State ==
                    UsbController.PortState.Running)
            {
                // We need shift down for capital "H"
                 
                kb.Press(Key.LeftShift);
                kb.Stroke(Key.H);
               
                kb.Release(Key.LeftShift);
                // Now "ello world"
                kb.Stroke(Key.E);
                kb.Stroke(Key.L);
                kb.Stroke(Key.L);
                kb.Stroke(Key.O);
                kb.Stroke(Key.Space);
                kb.Stroke(Key.W);
                kb.Stroke(Key.O);
                kb.Stroke(Key.R);
                kb.Stroke(Key.L);
                kb.Stroke(Key.D);
                // The "!"
                kb.Press(Key.LeftShift);
                kb.Stroke(Key.D1);
                kb.Release(Key.LeftShift);
                // Send an enter key
                kb.Stroke(Key.Enter);
            }
            Thread.Sleep(1000);
        }
    }
}
```

## CDC - Virtual Serial Port

Serial ports are the most common interface, especially in the embedded system world. It is an ideal solution for devices to transfer data between computers and embedded devices NETMF products. To combine the popularity and usefulness of USB with the ease of serial, we have virtual USB devices. To Windows' applications or devices, a virtual serial port works just like a serial port but it is actually a USB port.

To use CDC, you need the USB Drivers that come with the GHI Electronics NETMF and Gadgeteer SDK (2016 R1 and later). This will only work if you use the default constructor of the Cdc class. If you do not and you provide different Vendor and Product Ids, this driver will not work and you will need to create your own. You can use the one we provide in the SDK as a model, though it will not be signed.

Note: CDC drivers usually handle one transaction in every frame. The max EP size on USB is 64 bytes and there 1000 frames per second on full-speed USB. This means that the maximum transfer rate in ideal conditions for CDC is 64KB/sec.

The buffer size is limited so you must be make sure to read all data quickly because there is no overflow event.

The following example will create a USB CDC and send "Hello world!" to computer every second.

```cs
using System.Threading;
using GHI.Usb;
using GHI.Usb.Client;
using Microsoft.SPOT;
using Microsoft.SPOT.Hardware.UsbClient;

public class Program
{
    public static void Main()
    {
        // Start Cdc
        Cdc vsp = new Cdc();
		  Controller.ActiveDevice = vsp;

        // Send "Hello world!" to PC every second. (Append a new line too)
        byte[] bytes = System.Text.Encoding.UTF8.GetBytes("Hello world!\r\n");
        while (true)
        {
            // Check if connected to PC
            if (Controller.State !=
                UsbController.PortState.Running)
            {
                Debug.Print("Waiting to connect to PC...");
            }
            else
            {
                vsp.Stream.Write(bytes, 0, bytes.Length);
            }
            Thread.Sleep(1000);
        }
    }
}
```

## Mass Storage

GHI's USB client supports Mass Storage Class (MSC). This allows access to connected media right from USB. For example, a data logger application that needs to save data to an SD card or USB memory. When the user is done collecting data, they can plug the USB data logger into the PC and now the PC can detect the device as a mass storage device. The user can then transfer the files using standard operating system controls. It may be helpful to think of the device as a memory card reader. We can even enhance our logger where the USB client interface can be CDC to configure the device and later dynamically switch to MSC to transfer files.

Once very common question on GHI support is "Why can't I access the media from my application while the media is also accessed externally (from windows)?"  Due to caching of file system data and/or the possibility of a write from one interface while the other is doing a read and/or a write, data on the media and/or data used by the interface will likely (and quickly) be corrupted.

Note: you can easily switch back and forth between internal file system and USB MSC.

This example code assumes an SD card is always plugged in. It enables MSC showing the device as a card reader. This code assumes that the USB port is NOT being used for debugging.

In addition to the assemblies mentioned above in the Note, the following code requires the GHI.Hardware assembly.

```cs
using System;
using System.Threading;
using GHI.Usb.Client;
using GHI.Usb;
using GHI.IO.Storage;

public class Program
{
    public static void Main()
    {
        // Start MS
        MassStorage ms = new MassStorage();
		  Controller.ActiveDevice = ms;

        // Assume SD card is connected
        SDCard sd;
        try
        {
            sd = new SDCard();
        }
        catch
        {
            throw new Exception("SD card not detected");
        }
        ms.AttachLogicalUnit(sd,0, " ", " ");

        // enable host access 
        ms.EnableLogicalUnit(0);

        Thread.Sleep(Timeout.Infinite);
    }
}
```

## HID and Custom Devices

Windows and other operating systems have built in drivers for USB HID (Human Interface Devices). These drivers are ideal as they provide a simple way to transfer data between a computer and a device. HID's are usually mice and keyboards but they can also be simple data transfer devices. Although examples in codeshare may need changes for differences in SDK releases, this  project provides a good example:

 http://www.ghielectronics.com/community/codeshare/entry/420
 
The GHI USB Client allows you to control the USB client in anyway you like. This feature requires advanced knowledge of USB. If you do not know what an EndPoint or a Pipe is then do not attempt to create custom devices. It is very important to have the device configured correctly the first time it is plugged into Windows since Windows stores a lot of information in its registry. If you change the configuration of your device after you had it plugged into Windows previously, Windows may not see the changes since it will be using the old configuration from its registry. Do not use USB Client Custom Devices unless you really have good reason to use them and you are knowledgeable in USB and Windows drivers.