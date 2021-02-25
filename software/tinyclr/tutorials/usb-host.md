# USB Host

The USB Host API supports USB keyboards, mice, joysticks, raw devices, and USB MSC (Mass Storage Class), which allows file access on USB memory devices. The following code sample shows how to detect devices as they are connected to your SITCore device's USB host port.

> [!Note]
> USB hubs are not currently supported. Special USB memory devices that have multiple interfaces or built in hubs will not work.

> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Core, GHIElectronics.TinyCLR.Devices.Storage, GHIElectronics.TinyCLR.Devices.UsbHost, GHIElectronics.TinyCLR.IO, GHIElectronics.TinyCLR.Native, and GHIElectronics.TinyCLR.Pins.

```cs
using System.IO;
using System.Diagnostics;
using System.Threading;
using GHIElectronics.TinyCLR.Devices.UsbHost;
using GHIElectronics.TinyCLR.Devices.UsbHost.Descriptors;
using GHIElectronics.TinyCLR.Devices.Storage;
using GHIElectronics.TinyCLR.IO;
using GHIElectronics.TinyCLR.Pins;

class Program {
    static void Main() {
        var usbHostController = UsbHostController.GetDefault();

        usbHostController.OnConnectionChangedEvent +=
            UsbHostController_OnConnectionChangedEvent;

        usbHostController.Enable();

        Thread.Sleep(Timeout.Infinite);
    }

    private static void UsbHostController_OnConnectionChangedEvent
        (UsbHostController sender, DeviceConnectionEventArgs e) {

        Debug.WriteLine("e.Id = " + e.Id + " \n");
        Debug.WriteLine("e.InterfaceIndex = " + e.InterfaceIndex + " \n");
        Debug.WriteLine("e.PortNumber = " + e.PortNumber);
        Debug.WriteLine("e.Type = " + ((object)(e.Type)).
            ToString() + " \n");

        Debug.WriteLine("e.VendorId = " + e.VendorId + " \n");
        Debug.WriteLine("e.ProductId = " + e.ProductId + " \n");

        switch (e.DeviceStatus) {
            case DeviceConnectionStatus.Connected:
                switch (e.Type) {
                    case BaseDevice.DeviceType.Keyboard:
                        var keyboard = new Keyboard(e.Id, e.InterfaceIndex);
                        keyboard.KeyUp += Keyboard_KeyUp;
                        keyboard.KeyDown += Keyboard_KeyDown;
                        break;

                    case BaseDevice.DeviceType.Mouse:
                        var mouse = new Mouse(e.Id, e.InterfaceIndex);
                        mouse.ButtonChanged += Mouse_ButtonChanged;
                        mouse.CursorMoved += Mouse_CursorMoved;
                        break;

                    case BaseDevice.DeviceType.Joystick:
                        var joystick = new Joystick(e.Id, e.InterfaceIndex);
                        joystick.CursorMoved += Joystick_CursorMoved;
                        joystick.HatSwitchPressed += Joystick_HatSwitchPressed;
                        joystick.ButtonChanged += Joystick_ButtonChanged;
                        break;

                    case BaseDevice.DeviceType.MassStorage:
                        var storageController = StorageController.FromName
                            (SC20260.StorageController.UsbHostMassStorage);
                        var driver = FileSystem.Mount(storageController.Hdc);
                        var driveInfo = new DriveInfo(driver.Name);

                        Debug.WriteLine("Free: " + driveInfo.TotalFreeSpace);
                        Debug.WriteLine("TotalSize: " + driveInfo.TotalSize);
                        Debug.WriteLine("VolumeLabel:" + driveInfo.VolumeLabel);
                        Debug.WriteLine("RootDirectory: " + driveInfo.RootDirectory);
                        Debug.WriteLine("DriveFormat: " + driveInfo.DriveFormat);

                        break;

                    default:
                        var rawDevice = new RawDevice(e.Id, e.InterfaceIndex, e.Type);
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

                        var endpoint = new Endpoint(endpointData, 0);

                        var pipe = rawDevice.OpenPipe(endpoint);
                        pipe.TransferTimeout = 10;

                        var data = new byte[8];
                        var read = pipe.Transfer(data);

                        if (read > 0) {
                            Debug.WriteLine("Raw Device has new data "
                                + data[0] + ", " + data[1] + ", " + data[2] + ", " + data[3]);
                        }

                        else if (read == 0) {
                            Debug.WriteLine("No new data");
                        }

                        Thread.Sleep(500);
                        break;
                }
                break;

            case DeviceConnectionStatus.Disconnected:
                Debug.WriteLine("Device Disconnected");
                //Unmount filesystem if it was mounted.
                break;

            case DeviceConnectionStatus.Bad:
                Debug.WriteLine("Bad Device");
                break;
        }
    }
    private static void Keyboard_KeyDown(Keyboard sender, Keyboard.KeyboardEventArgs args) {
        Debug.WriteLine("Key pressed: " + ((object)args.Which).ToString());
        Debug.WriteLine("Key pressed ASCII: " +
            ((object)args.ASCII).ToString());
    }
    private static void Keyboard_KeyUp(Keyboard sender, Keyboard.KeyboardEventArgs args) {
        Debug.WriteLine("Key released: " + ((object)args.Which).ToString());
        Debug.WriteLine("Key released ASCII: " + ((object)args.ASCII).ToString());
    }
    private static void Mouse_CursorMoved(Mouse sender, Mouse.CursorMovedEventArgs e) {
        Debug.WriteLine("Mouse moved to: " + e.NewPosition.X + ", " + e.NewPosition.Y);
    }
    private static void Mouse_ButtonChanged(Mouse sender, Mouse.ButtonChangedEventArgs args) {
        Debug.WriteLine("Mouse button changed: " + ((object)args.Which).ToString());
    }
    private static void Joystick_ButtonChanged(Joystick sender, Joystick.ButtonChangedEventArgs e) {
        Debug.WriteLine("Joystick button changed  = " + ((object)(e.Which)).ToString());
    }
    private static void Joystick_HatSwitchPressed(Joystick sender, Joystick.HatSwitchPressedEventArgs e) {
        Debug.WriteLine("Joystick direction  = " + ((object)(e.Direction)).ToString());
    }
    private static void Joystick_CursorMoved(Joystick sender, Joystick.CursorMovedEventArgs e) {
        Debug.WriteLine("Joystick.move  = " + e.NewPosition.X + ", " + e.NewPosition.Y);
    }
}

```
