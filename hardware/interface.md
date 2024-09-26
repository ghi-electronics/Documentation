# Interface

---

The connection between a DUELink Motherboard and a host device, such as a laptop, uses serial communication. This serial communication can be transported in different ways. 

## USB

Using USB is the most common and it works by simulating a virtual serial connections. This is a standard USB class that is understood by modern operating systems. There is no need to install any special USB drivers.

This interface is also needed to update the firmware living on a DUELink Mainboard.

A helper method is provided to help in identifying the serial port with a connected DUELink mainboard `port = DUELinkController.GetConnectionPort()`

## Bluetooth

DUELink Mainboards with Bluetooth (BLE) interface use the serial profile, allowing the operating system to access the device using a wireless connection.