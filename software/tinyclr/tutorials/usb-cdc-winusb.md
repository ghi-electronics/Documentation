# USB CDC & WinUSB
This feature is for devices that needs to transfer data to a PC. Note that the debug interface need to be switched to serial to free up the USB Client port for this feature. This is accomplished though the MODE pin, details in the device's documentations.

## USB CDC
The CDC class is natively supported by Windows and Linux. It is a way for the PC to see a virtual serial port. Once loaded, the PC will can use this port like any other serial port (COM port). Windows 10 works without the need for any drivers. Earlier operating systems needs a driver. While it works with most operating systems, CDC is typically limited to 64KB/sec.

```
// code
```

## WinUSB
The WinUSB drivers are unique to Windows and they do take advantage of the power and speed of USB, meaning they are faster then CDC at data transfers. The speed is limited by the data processing on the IoT devices. Windows 10 loads the drivers automatically, Windows 7 requires drivers.


```
//code
```
A disadvantage to WinUSB is that fact that it requires a special code on the PC side to read and write to the device. Fear not, we are providing an example as well.

```
// or we should give them github link? Probably github!
```
