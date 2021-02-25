# USB Client
---
By default, USB client support is used for deploying and debugging applications. However, deploying and debugging can be switched to a serial mode using MOD pin, freeing the USB Client port to serve other purposes.

 The USB port can also be freed by completely disabling the USB debug interface, which is a feature of [ip protection](ip-protection.md).

> [!Tip]
> Feature found in the GHIElectronics.TinyCLR.Devices.UsbClient NuGet and namespace

### USB Mouse
In this mode, the hardware acts as a USB mouse. The driver supports absolute and relative modes. In relative mode, the `MoveCursor` method will move the cursor from current location, where ever it might be. Meaning, `MoveCursor(10,0)` followed by `MoveCursor(-10,0)` will move the cursor and immediately move it back where it started.

In absolute mode, `MoveCursor` sets the cursor from (0,0), which is in the top left corner of the screen.

```cs
var usbclientController = UsbClientController.GetDefault();
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

### USB Joystick
Devices running TinyCLR OS can simulate a Joystick. 

```cs
var usbclientController = UsbClientController.GetDefault();

var usbClientSetting = new UsbClientSetting() {
    ManufactureName = "Manufacture_Name",
    ProductName = "Product_Name",
    SerialNumber = "serialnumber",
};

var joystick = new Joystick(usbclientController, usbClientSetting);
joystick.DeviceStateChanged += UsbClientDeviceStateChanged;
joystick.Enable();

Thread.Sleep(Timeout.Infinite);

//...

private static void UsbClientDeviceStateChanged(RawDevice sender, DeviceState state) {
    if (state == DeviceState.Configured) {
        new Thread(() => {
            Joystick joystick = (Joystick)sender;
            while (true) {
                joystick.PressButton(0);
                Thread.Sleep(500);
                joystick.ReleaseButton(0);
                Thread.Sleep(1000);
            }
        }).Start();
    }
}
```

### PC Data Transfer
This feature is used to transfer data between the hardware and a PC. See [PC Data Comm](usb-pc-comm.md) for details.

### USB Raw
For advanced users, virtually any type of USB device can be created using USB Raw. The USB mouse driver inside [GHIElectronics.TinyCLR.Devices.UsbClient](https://github.com/ghi-electronics/TinyCLR-Libraries) is a good example of how this can be achieved.   

