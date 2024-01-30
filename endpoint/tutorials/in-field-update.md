# In-Field Update

---

It is possible to update the internal flash from an image found on SD or USB memory. This allows a device to be updated in-field.

```cs
var usbhost = new UsbHostController();
usbhost.OnConnectionChangedEvent += UsbThumbDriveConnected;
usbhost.Enable();
var cnt = 0;
while (UsbMountPath == string.Empty)
{
    Console.WriteLine($"Wait for source files {cnt++}");

    Thread.Sleep(1000);
}
var update = new UpdateController(UpdateController.Mode.ProgrameMMC, EPM815.Gpio.Pin.PF0, UsbMountPath);
var result = update.Update();
Console.WriteLine("Result update: " + result);

string UsbMountPath = string.Empty;

void UsbThumbDriveConnected(UsbHostController sender, DeviceConnectionEventArgs e)
{
    Console.WriteLine("Detect changed Id: " + e.DeviceId + ", name: " + e.DeviceName + ", status:" + e.DeviceStatus);



    if (e.Type == GHIElectronics.Endpoint.Devices.Usb.DeviceType.MassStorage && e.DeviceStatus == DeviceConnectionStatus.Connected)
    {
        UsbMountPath = GHIElectronics.Endpoint.FileSystem.Mount(e.DeviceName);

        Console.WriteLine("Mounted, path " + UsbMountPath);
    }
    else if (e.Type == GHIElectronics.Endpoint.Devices.Usb.DeviceType.MassStorage)
    {
        GHIElectronics.Endpoint.FileSystem.Unmount(UsbMountPath);

        Console.WriteLine("Umounted");
    }
}
```