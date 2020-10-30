# USB CDC & WinUSB
---
These protocols facilitate communication between your SITCore device and a PC.

> [!Note]
> The debug interface needs to be switched to serial (UART) to free up the USB Client port for PC communication. This is accomplished by pulling the MOD pin low during reset as detailed on the [SITCore System on Chip](../../../hardware/sitcore/soc.md) page. It is beneficial to add a 1K pull down on MOD to keep the device in serial debug mode indefinitely.

## USB CDC
The USB Communications Device Class (CDC) is natively supported by Windows and Linux. It is a way for a PC to use a USB port as a virtual serial port. Once loaded, the PC will use this port like any other serial port (COM port). Windows 10 works without the need for any drivers, but earlier operating systems may need a driver. While it works with most operating systems, CDC is typically limited to 64 KBytes/second.

> [!TIP]
> Needed Nugets: GHIElectronics.TinyCLR.Devices.UsbClient

```cs
static void DoTestCDC {
        var usbclient = UsbClientController.GetDefault();
    
        var usbClientSetting = new UsbClientSetting(){
                Mode = UsbClientMode.WinUsb,
                ManufactureName = "Manufacture_Name",
                ProductName = "Product_Name",
                SerialNumber = "12345678",
                Guid = "{your guid}",
                ProductId = 0x1234,
                VendorId = 0x5678,
        };
            
        usbclient.SetActiveSetting(usbClientSetting);
        usbclient.Enable();
        usbclient.DeviceStateChanged += (a,b) => Debug.WriteLine("Connection changed."); 
        usbclient.DataReceived += (a,count) => Debug.WriteLine("Data received:" + count);

        while (usbclient.DeviceState != DeviceState.Configured);
                Debug.WriteLine("UsbClient Connected");

// The example will read data from port to dataR array
// Copy dataR to dataW array, plus 1 for each element
// Write dataW array back to port

        while (true){
            var len = usbclient.ByteToRead;

                if (len > 0){
                    var dataR = new byte[len];
                    var dataW = new byte[len];
                    int read = usbclient.Read(dataR);

                for (var i = 0; i < read; i++){
                    dataW[i] = (byte)(dataR[i] + 1);
                }
            usbclient.Write(dataW);
        }
        Thread.Sleep(100);
    }
}
```

---

## WinUSB
The WinUSB drivers are unique to Windows and take advantage of the power and speed of USB to provide faster communication than CDC. The speed is limited by the data processing on the IoT device. Windows 10 loads the drivers automatically, Windows 7 requires drivers.


```cs
static void DoTestWinUsb {
        var usbclient = UsbClientController.GetDefault();
    
        var usbClientSetting = new UsbClientSetting(){
                Mode = UsbClientMode.WinUsb,
                ManufactureName = "Manufacture_Name",
                ProductName = "Product_Name",
                SerialNumber = "12345678",
                Guid = "{your guid}",
                ProductId = 0x1234,
                VendorId = 0x5678,
        };
            
        usbclient.SetActiveSetting(usbClientSetting);       
        usbclient.Enable();
        usbclient.DeviceStateChanged += (a,b) => Debug.WriteLine("Connection changed."); 
        usbclient.DataReceived += (a,count) => Debug.WriteLine("Data received:" + count);

        while (usbclient.DeviceState != DeviceState.Configured) ;
                Debug.WriteLine("UsbClient Connected");

// The example will read data from port to dataR array
// Copy dataR to dataW array, plus 1 for each element
// Write dataW array back to port
    
        while (true){
        var len = usbclient.ByteToRead;

        if (len > 0){
            var dataR = new byte[len];
            var dataW = new byte[len];
            int read = usbclient.Read(dataR);

            for (var i = 0; i < read; i++){
                dataW[i] = (byte)(dataR[i] + 1);
            }
            usbclient.Write(dataW);
        }
        Thread.Sleep(100);
    }
}
```

> [!NOTE]
> Unlike CDC mode, a disadvantage of WinUSB is that it requires a special code on the PC side to read and write to the device.



