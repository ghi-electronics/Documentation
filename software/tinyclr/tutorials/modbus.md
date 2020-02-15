# Modbus
---
Modbus is an asynchronous serial communications protocol that uses RS485 as its physical layer. It was developed for communicating with programmable logic controllers and is widely used for industrial applications.

The following sample is written for the SC20100 Dev Board and uses Uart5 for communication:

>[!Note]
>Needed NuGets: GHIElectronics.TinyCLR.Devices.Uart, GHIElectronics.TinyCLR.Pins, GHIElectronics.TinyCLR.Devices.Modbus

```cs
var serial = GHIElectronics.TinyCLR.Devices.Uart.UartController.FromName
    (GHIElectronics.TinyCLR.Pins.SC20100.UartPort.Uart5);

serial.SetActiveSettings(
    19200,
    8,
    GHIElectronics.TinyCLR.Devices.Uart.UartParity.None,
    GHIElectronics.TinyCLR.Devices.Uart.UartStopBitCount.One,
    GHIElectronics.TinyCLR.Devices.Uart.UartHandshake.None);

serial.Enable();

GHIElectronics.TinyCLR.Devices.Modbus.Interface.IModbusInterface mbInterface;
mbInterface = new GHIElectronics.TinyCLR.Devices.Modbus.Interface.ModbusRtuInterface(
    serial,
    19200,
    8,
    GHIElectronics.TinyCLR.Devices.Uart.UartStopBitCount.One,
    GHIElectronics.TinyCLR.Devices.Uart.UartParity.None);

GHIElectronics.TinyCLR.Devices.Modbus.ModbusMaster mbMaster;
mbMaster = new GHIElectronics.TinyCLR.Devices.Modbus.ModbusMaster(mbInterface);

var mbTimeout = false;

ushort[] reply = null;
int count = 0;

while (true) {
    try {
        mbTimeout = false;

        reply = mbMaster.ReadHoldingRegisters(10, 0, 1, 3333);
        count++;

        if (count == 5)
            break;
    }
    catch (System.Exception error) {
        System.Diagnostics.Debug.WriteLine("Modbus Timeout");
        mbTimeout = true;
    }

    if (!mbTimeout) {
        System.Diagnostics.Debug.WriteLine("Modbus : " + (object)reply[0].ToString());
    }

    System.Threading.Thread.Sleep(1000);
}
```