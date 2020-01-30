# USB CDC & WinUSB
This feature is for devices that needs to transfer data to a PC. Note that the debug interface need to be switched to serial to free up the USB Client port for this feature. This is accomplished though the MODE pin, details in the device's documentations.

> [!TIP]
> Need Nugets: GHIElectronics.TinyCLR.Devices.UsbClient


## USB CDC
The CDC class is natively supported by Windows and Linux. It is a way for the PC to see a virtual serial port. Once loaded, the PC will can use this port like any other serial port (COM port). Windows 10 works without the need for any drivers. Earlier operating systems needs a driver. While it works with most operating systems, CDC is typically limited to 64KB/sec.

```csharp
static void DoTestCDC 
{
    var usbclient = GHIElectronics.TinyCLR.Devices.UsbClient.UsbClientController.GetDefault();
            
    usbclient.SetActiveSetting(GHIElectronics.TinyCLR.Devices.UsbClient.UsbClientMode.Cdc, 0x1234, 0x5678);
    usbclient.Enable();

    usbclient.DeviceStateChanged += (a,count) => Debug.WriteLine("Data received:" + count);
    usbclient.DataReceived += (a,b) => Debug.WriteLine("Connection changed."); 

    while (usbclient.DeviceState != GHIElectronics.TinyCLR.Devices.UsbClient.DeviceState.Configured) ;

    Debug.WriteLine("UsbClient Connected");

    // The example will read data from port to dataR array
    // Copy dataR to dataW array, plus 1 for each element
    // Write dataW array back to port

    while (true)
    {
        var len = usbclient.ByteToRead;

        if (len > 0)
        {
            var dataR = new byte[len];
            var dataW = new byte[len];

            int read = usbclient.Read(dataR);

            for (var i = 0; i < read; i++)
            {
                dataW[i] = (byte)(dataR[i] + 1);
            }

            usbclient.Write(dataW);
        }
        Thread.Sleep(100);
    }
}
```

## WinUSB
The WinUSB drivers are unique to Windows and they do take advantage of the power and speed of USB, meaning they are faster then CDC at data transfers. The speed is limited by the data processing on the IoT devices. Windows 10 loads the drivers automatically, Windows 7 requires drivers.


```csharp
static void DoTestWinUsb
{
    var usbclient = GHIElectronics.TinyCLR.Devices.UsbClient.UsbClientController.GetDefault();
    usbclient.SetActiveSetting(GHIElectronics.TinyCLR.Devices.UsbClient.UsbClientMode.WinUsb, "Manufacture_Name", "Product_Name", "SerailNumber", 0x1234, 0x5678, "{your guid}");
    usbclient.Enable();

    usbclient.DeviceStateChanged += (a,count) => Debug.WriteLine("Data received:" + count);
    usbclient.DataReceived += (a,b) => Debug.WriteLine("Connection changed."); 

    while (usbclient.DeviceState != GHIElectronics.TinyCLR.Devices.UsbClient.DeviceState.Configured) ;

    Debug.WriteLine("UsbClient Connected");

    // The example will read data from port to dataR array
    // Copy dataR to dataW array, plus 1 for each element
    // Write dataW array back to port
    while (true)
    {
        var len = usbclient.ByteToRead;

        if (len > 0)
        {
            var dataR = new byte[len];
            var dataW = new byte[len];

            int read = usbclient.Read(dataR);

            for (var i = 0; i < read; i++)
            {
                dataW[i] = (byte)(dataR[i] + 1);
            }

            usbclient.Write(dataW);
        }
        Thread.Sleep(100);
    }
}

```

> [!NOTE]
> Unlike CDC mode, a disadvantage to WinUSB is that fact that it requires a special code on the PC side to read and write to the device.



