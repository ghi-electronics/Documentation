# USB
---
TinyCLR OS supports both USB Client and USB Host.

## USB Client
USB client support is used for deploying and debugging applications. However, deploying and debugging can be switched to a serial mode, freeing the USB Client port. The port can be configured to support multiple modes.

> [!Note]
> The debug interface needs to be switched to serial (UART) to free up the USB Client port for PC communication. This is accomplished by pulling the MOD pin low during reset as detailed on the [SITCore System on Chip](../../../hardware/sitcore/soc.md) page. It is beneficial to add a 1K pull down on MOD to keep the device in serial debug mode indefinitely.

> [!Tip]
> These can all be found in the GHIElectronics.TinyCLR.Devices.UsbClient namespace

### USB Mouse
In this mode, SITCore acts as a USB mouse. The driver supports absolute and relative modes. In absolute mode, the `MoveCursor` method will move the cursor from current location, where ever it might be. Meaning, `MoveCursor(10,0)` followed by `MoveCursor(-10,0)` will move the cursor and immediately move it back where it started.

In absolute mode, `MoveCursor` sets the cursor from (0,0), which is in the top left corner of the screen.

```cs
var usbclientController = GetDefault();
var absolutePosition = true;
var mouse = new Mouse(usbclientController, absolutePosition);

mouse.DeviceStateChanged += UsbClientDeviceStateChanged;
mouse.Enable();

//...

private static void UsbClientDeviceStateChanged(RawDevice sender, DeviceState state) {
var i = 0.0;
    if (state == DeviceState.Configured) {
        new Thread(() => {
            while (true) {
                ((Mouse)sender).MoveCursor(
                    Mouse.MaxRange /4 + (int)(Math.Cos(i) * Mouse.MaxRange / 10),
                    Mouse.MaxRange /4 + (int)(Math.Sin(i) * Mouse.MaxRange / 10));
                i+=0.03;
                Thread.Sleep(50);
            }
        }).Start();
    }
}
```

### USB Keyboard
A USB Keyboard is simulated in this mode. The keys used can be `Press`, `Release` or `Stroke` (which is same as a `Press` followed by `Release`).

```cs
var usbClientSetting = new UsbClientSetting() {
    ManufactureName = "Manufacture_Name",
    ProductName = "Product_Name",
    SerialNumber = "serialnumber",
};
var usbclientController = UsbClientController.GetDefault();
var kb = new Keyboard(usbclientController, usbClientSetting);
var key = new Key[] { Key.G, Key.H, Key.I, Key.Space, Key.E, Key.L, Key.E, Key.C, Key.T, Key.R, Key.O, Key.N, Key.I, Key.C, Key.S };
kb.Enable();

while (kb.DeviceState != DeviceState.Configured)
    Thread.Sleep(100);// wait or use events

kb.Press(Key.LeftShift);// hold shift down
for (var i = 0; i < key.Length; i++) {
    kb.Stroke(key[i]);
    Thread.Sleep(500);// type it twice a second
}
kb.Release(Key.LeftShift);// release shift
```

### CDC & WinUSB
These two modes are used to transfer data between a SITCore device and a PC. See [USB CDC & WinUSB](usb-cdc-winusb.md) for details.

### USB Raw
For advanced users, virtually any type of USB device can be created using USB Raw. The USB mouse driver inside [GHIElectronics.TinyCLR.Devices.UsbClient](https://github.com/ghi-electronics/TinyCLR-Libraries) is a good example of how this can be achieved.   

---
## USB Host
The USB Host API supports USB keyboards, mice, raw devices, and USB MSC (Mass Storage Class), which allows file access on USB memory devices. The following code sample shows how to detect devices as they are connected to your SITCore device's USB host port.

> [!Note]
> USB hubs are not currently supported. Special USB memory devices that have multiple interfaces or built in hubs will not work.

> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Core, GHIElectronics.TinyCLR.Devices.Storage, GHIElectronics.TinyCLR.Devices.UsbHost, GHIElectronics.TinyCLR.IO, GHIElectronics.TinyCLR.Native, and GHIElectronics.TinyCLR.Pins.

```cs
class Program {
    static void Main() {
        var usbHostController = UsbHostController.GetDefault();

        usbHostController.OnConnectionChangedEvent +=
            UsbHostController_OnConnectionChangedEvent;

        usbHostController.Enable();

        Thread.Sleep(Timeout.Infinite);
    }

    private static void UsbHostController_OnConnectionChangedEvent
        (UsbHostController sender,DeviceConnectionEventArgs e) {

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

                    case BaseDevice.DeviceType.MassStorage:

                        var storageController = StorageController.FromName
                            (SC20260.StorageController.UsbHostMassStorage);
                        var driver = FileSystem.Mount(storageController.Hdc);
                        var driveInfo = IO.DriveInfo(driver.Name);

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

                        var endpoint = new Descriptors.Endpoint(endpointData, 0);

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
        Debug.WriteLine ("Key released: " + ((object)args.Which).ToString());
        Debug.WriteLine ("Key released ASCII: " + ((object)args.ASCII).ToString());
    }

    private static void Mouse_CursorMoved(Mouse sender, Mouse.CursorMovedEventArgs e) {
        Debug.WriteLine("Mouse moved to: " + e.NewPosition.X + ", " + e.NewPosition.Y);
    }

    private static void Mouse_ButtonChanged(Mouse sender, Mouse.ButtonChangedEventArgs args) {
        Debug.WriteLine("Mouse button changed: " + ((object)args.Which).ToString());
    }
}
```
