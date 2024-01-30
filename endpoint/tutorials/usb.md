# USB
---
![USB Logo](images/usb-logo.jpg)
 
 Both, USB Host and USB Device (Client) are utilized in any Endpoint device.

 ## USB Device
 
 An Endpoint device presents its USB Device as a virtual network interface. This interface is used to configure, program, and debug applications remotely. No user effort is needed to use this interface

 ## USB Host

 There are multiple way to benefit from USB Host to cover different needs.

 ```cs
 using GHIElectronics.Endpoint.Devices.UsbHost;
 //...
 var usbhost = new UsbHostController();

usbhost.OnConnectionChangedEvent += Usbhost_OnConnectionChangedEvent;
usbhostController.Enable();
void Usbhost_OnConnectionChangedEvent(UsbHostController sender, DeviceConnectionEventArgs e)
{
    Console.WriteLine("Detect changed Id: " + e.DeviceId + ", name: " + e.DeviceName + ", status:" + e.DeviceStatus);

}
 ```

 ### Mass Storage

 This allows users to access files on USB memory devices. Once a `MassStorage` device is inserted and detected, it can then be mounted, returning the device path needed to access files.

 ```cs
var usbhost = new UsbHostController();
string usbmountedPath = string.Empty;
usbhost.OnConnectionChangedEvent += Usbhost_OnConnectionChangedEvent;
usbhostController.Enable();
void Usbhost_OnConnectionChangedEvent(UsbHostController sender, DeviceConnectionEventArgs e)
{
    Console.WriteLine("Detect changed Id: " + e.DeviceId + ", name: " + e.DeviceName + ", status:" + e.DeviceStatus);

    if (e.Type == GHIElectronics.Endpoint.Devices.Usb.DeviceType.MassStorage && e.DeviceStatus == DeviceConnectionStatus.Connected)
    {
        usbmountedPath = GHIElectronics.Endpoint.FileSystem.Mount(e.DeviceName);

        Console.WriteLine("Mounted, path " + usbmountedPath);
    }
    else if (e.Type == GHIElectronics.Endpoint.Devices.Usb.DeviceType.MassStorage)
    {
        GHIElectronics.Endpoint.FileSystem.Unmount(usbmountedPath);

        Console.WriteLine("Unmounted");
    }
}
 ```
 
 Files can now be accessed normally.
 
```cs
string path = usbmountedPath + "/DataFile.txt";
using (FileStream fs = File.Create(path))
{
//...
}
```

### HID

Human Interface Devices, such as a Keyboards and Mice, are automatically mounted by the system.

```cs
using var hid = new HidInput();

hid.OnButtonPress += (e) => {
    Console.WriteLine($"Code:{e.Code} State:{e.State}");

};

hid.OnMouseMove += (e) =>
{
    Console.WriteLine($"Axis:{e.Axis} Amount:{e.Amount}");
};

hid.OnDisconnected += () =>
{
    Console.WriteLine("Device HID disconnected!");
};
```

### Camera

The USB Camera library provides a stream of images. Note that only cameras with UVC (USB Video Class) standard are supported.

```cs
usbhostController.OnConnectionChangedEvent += (a, b) =>
{
    var arg = b;

    if (arg.DeviceStatus == DeviceConnectionStatus.Connected)
    {
        Console.WriteLine("id: " + arg.DeviceId);
        Console.WriteLine("name: " + arg.DeviceName);
        Console.WriteLine("type: " + arg.Type);

        if (arg.Type == GHIElectronics.Endpoint.Devices.Usb.DeviceType.Webcam && arg.DeviceName.IndexOf("video0") > 0)
        {
            webcam = new Webcam(arg.DeviceName);

            var setting = new CameraConfiguration()
            {
                Width = 480,
                Height = 272,
                ImageFormat = Format.Rgb565,
            };

            webcam.Setting = setting;

            webcam.VideoStreamStart();
            webcam.FrameReceivedEvent += (a, b) =>
            {
                displayController.Flush(b, 0, b.Length, webcam.Width, webcam.Height);
            };
        }
    }
    else
    {
        if (webcam != null)
        {
            if (webcam.IsVideoStreaming)
            {
                webcam.VideoStreamStop();
            }
            webcam.Dispose();
            webcam = null;
        }
    }
};
```