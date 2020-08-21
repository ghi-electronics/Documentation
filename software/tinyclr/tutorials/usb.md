# USB
---
TinyCLR OS supports both USB Client and USB Host and includes support for using USB keyboards, mice, and mass storage devices with your SITCore devices.

## USB Client
USB client support is mainly used for deploying and debugging applications. It can also be used to transfer data between a SITCore device and a PC. See [USB CDC & WinUSB](usb-cdc-winusb.md) for details.

## USB Host
The USB Host API supports USB keyboards, mice, raw devices, and USB MSC (Mass Storage Class), which allows file access on USB memory devices. The following code sample shows how to detect devices as they are connected to your SITCore device's USB host port.

> [!Note]
> USB hubs are not currently supported. Special USB memory devices that have multiple interfaces or built in hubs will not work.

> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Core, GHIElectronics.TinyCLR.Devices.Storage, GHIElectronics.TinyCLR.Devices.UsbHost, GHIElectronics.TinyCLR.IO, GHIElectronics.TinyCLR.Native, and GHIElectronics.TinyCLR.Pins.

```cs
class Program {
    static void Main() {
        var usbHostController = GHIElectronics.TinyCLR.Devices.UsbHost.
            UsbHostController.GetDefault();

        usbHostController.OnConnectionChangedEvent +=
            UsbHostController_OnConnectionChangedEvent;

        usbHostController.Enable();

        System.Threading.Thread.Sleep(-1);
    }

    private static void UsbHostController_OnConnectionChangedEvent
        (GHIElectronics.TinyCLR.Devices.UsbHost.UsbHostController sender,
        GHIElectronics.TinyCLR.Devices.UsbHost.DeviceConnectionEventArgs e) {

        System.Diagnostics.Debug.WriteLine("e.Id = " + e.Id + " \n");
        System.Diagnostics.Debug.WriteLine("e.InterfaceIndex = " + e.InterfaceIndex + " \n");
        System.Diagnostics.Debug.WriteLine("e.PortNumber = " + e.PortNumber);
        System.Diagnostics.Debug.WriteLine("e.Type = " + ((object)(e.Type)).
            ToString() + " \n");

        System.Diagnostics.Debug.WriteLine("e.VendorId = " + e.VendorId + " \n");
        System.Diagnostics.Debug.WriteLine("e.ProductId = " + e.ProductId + " \n");

        switch (e.DeviceStatus) {
            case GHIElectronics.TinyCLR.Devices.UsbHost.DeviceConnectionStatus.Connected:
                switch (e.Type) {
                    case GHIElectronics.TinyCLR.Devices.UsbHost.BaseDevice.
                        DeviceType.Keyboard:

                        var keyboard = new GHIElectronics.TinyCLR.Devices.UsbHost.
                            Keyboard(e.Id, e.InterfaceIndex);

                        keyboard.KeyUp += Keyboard_KeyUp;
                        keyboard.KeyDown += Keyboard_KeyDown;
                        break;

                    case GHIElectronics.TinyCLR.Devices.UsbHost.BaseDevice.DeviceType.Mouse:
                        var mouse = new GHIElectronics.TinyCLR.Devices.UsbHost.
                            Mouse(e.Id, e.InterfaceIndex);

                        mouse.ButtonChanged += Mouse_ButtonChanged;
                        mouse.CursorMoved += Mouse_CursorMoved;
                        break;

                    case GHIElectronics.TinyCLR.Devices.UsbHost.BaseDevice.
                        DeviceType.MassStorage:

                        var storageController = GHIElectronics.TinyCLR.Devices.Storage.
                            StorageController.FromName(GHIElectronics.TinyCLR.Pins.
                            SC20260.StorageController.UsbHostMassStorage);

                        var driver = GHIElectronics.TinyCLR.IO.FileSystem.
                            Mount(storageController.Hdc);

                        var driveInfo = new System.IO.DriveInfo(driver.Name);

                        System.Diagnostics.Debug.WriteLine
                            ("Free: " + driveInfo.TotalFreeSpace);

                        System.Diagnostics.Debug.WriteLine
                            ("TotalSize: " + driveInfo.TotalSize);

                        System.Diagnostics.Debug.WriteLine
                            ("VolumeLabel:" + driveInfo.VolumeLabel);

                        System.Diagnostics.Debug.WriteLine
                            ("RootDirectory: " + driveInfo.RootDirectory);

                        System.Diagnostics.Debug.WriteLine
                            ("DriveFormat: " + driveInfo.DriveFormat);

                        break;

                    default:
                        var rawDevice = new GHIElectronics.TinyCLR.Devices.UsbHost.
                            RawDevice(e.Id, e.InterfaceIndex, e.Type);

                        var devDesc = rawDevice.GetDeviceDescriptor();
                        var cfgDesc = rawDevice.GetConfigurationDescriptor(0);
                        var endpointData = new byte[7];

                        endpointData[0] = 7;        //Length in bytes of this descriptor.
                        endpointData[1] = 5;        //Descriptor type (endpoint).
                        endpointData[2] = 0x81;     //Input endpoint address.
                        endpointData[3] = 3;        //Transfer type is interrupt endpoint.
                        endpointData[4] = 8;        //Max packet size LSB.
                        endpointData[5] = 0;        //Max packet size MSB.
                        endpointData[6] = 10;       //Polling interval.

                        var endpoint = new GHIElectronics.TinyCLR.Devices.UsbHost.
                            Descriptors.Endpoint(endpointData, 0);

                        var pipe = rawDevice.OpenPipe(endpoint);
                        pipe.TransferTimeout = 10;

                        var data = new byte[8];
                        var read = pipe.Transfer(data);

                        if (read > 0) {
                            System.Diagnostics.Debug.WriteLine("Raw Device has new data "
                                + data[0] + ", " + data[1] + ", " + data[2] + ", " + data[3]);
                        }

                        else if (read == 0) {
                            System.Diagnostics.Debug.WriteLine("No new data");
                        }

                        System.Threading.Thread.Sleep(500);
                        break;
                }
                break;

            case GHIElectronics.TinyCLR.Devices.UsbHost.DeviceConnectionStatus.Disconnected:
                System.Diagnostics.Debug.WriteLine("Device Disconnected");
                //Unmount filesystem if it was mounted.
                break;

            case GHIElectronics.TinyCLR.Devices.UsbHost.DeviceConnectionStatus.Bad:
                System.Diagnostics.Debug.WriteLine("Bad Device");
                break;
        }
    }

    private static void Keyboard_KeyDown(GHIElectronics.TinyCLR.Devices.UsbHost.Keyboard
        sender, GHIElectronics.TinyCLR.Devices.UsbHost.Keyboard.KeyboardEventArgs args) {
        
        System.Diagnostics.Debug.WriteLine("Key pressed: " + ((object)args.Which).ToString());
        System.Diagnostics.Debug.WriteLine("Key pressed ASCII: " +
            ((object)args.ASCII).ToString());
    }

    private static void Keyboard_KeyUp(GHIElectronics.TinyCLR.Devices.UsbHost.Keyboard
        sender, GHIElectronics.TinyCLR.Devices.UsbHost.Keyboard.KeyboardEventArgs args) {

        System.Diagnostics.Debug.WriteLine
            ("Key released: " + ((object)args.Which).ToString());

        System.Diagnostics.Debug.WriteLine
            ("Key released ASCII: " + ((object)args.ASCII).ToString());
    }

    private static void Mouse_CursorMoved(GHIElectronics.TinyCLR.Devices.UsbHost.Mouse
        sender, GHIElectronics.TinyCLR.Devices.UsbHost.Mouse.CursorMovedEventArgs e) {

        System.Diagnostics.Debug.WriteLine("Mouse moved to: " + e.NewPosition.X +
             ", " + e.NewPosition.Y);
    }

    private static void Mouse_ButtonChanged(GHIElectronics.TinyCLR.Devices.UsbHost.Mouse
        sender, GHIElectronics.TinyCLR.Devices.UsbHost.Mouse.ButtonChangedEventArgs args) {

        System.Diagnostics.Debug.WriteLine
            ("Mouse button changed: " + ((object)args.Which).ToString());
    }
}
```
