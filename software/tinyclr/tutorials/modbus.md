# Modbus
---
Modbus is an asynchronous serial communications protocol that uses RS485 as its physical layer. It was developed for communicating with programmable logic controllers and is widely used for industrial applications.

The following sample is written for the SC20100S Dev Board and uses Uart5 for communication:

>[!Tip]
>Needed NuGets: GHIElectronics.TinyCLR.Devices.Uart, GHIElectronics.TinyCLR.Pins, GHIElectronics.TinyCLR.Devices.Modbus

```cs
var serial = UartController.FromName(SC20100.UartPort.Uart5);

var uartSetting = new UartSetting(){
        BaudRate = 19200,
        DataBits = 8,
        Parity = UartParity.None,
        StopBits = UartStopBitCount.One,
        Handshaking = UartHandshake.None,
    };

serial.SetActiveSettings(uartSetting);

serial.Enable();

IModbusInterface mbInterface;
mbInterface = ModbusRtuInterface(
    serial,
    19200,
    8,
    UartStopBitCount.One,
    UartParity.None);

ModbusMaster mbMaster;
mbMaster = new ModbusMaster(mbInterface);

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
        Debug.WriteLine("Modbus Timeout");
        mbTimeout = true;
    }

    if (!mbTimeout) {
        Debug.WriteLine("Modbus : " + (object)reply[0].ToString());
    }

    Thread.Sleep(1000);
}
```
