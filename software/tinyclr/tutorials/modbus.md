# Modbus
---

## Modbus RTU

Modbus is an asynchronous serial communications protocol that uses RS485 as its physical layer. It was developed for communicating with programmable logic controllers and is widely used for industrial applications. Modbus uses the a server/client relationship. With one server and up to 32 connections for Modbus RTU.  

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

## Modbus IP
Modbus IP is Ethernet based Modbus that transfers data over standard Ethernet packets and devices. Modbus IP offers greater distances than Modbus RTU.

In the example below setup the hardware as Modbus IP client. First create a `ModbusClient` class that is derived from ModbusDevice. `Modbus ID 

```cs
public class ModbusClient : ModbusDevice{
    public ModbusSlave(byte deviceAddress, object syncObject = null)
       : base(deviceAddress, syncObject) { }

protected override string OnGetDeviceIdentification(ModbusObjectId objectId) {
    switch (objectId) {
        case ModbusObjectId.VendorName:
            return "GHI Electronics";
        case ModbusObjectId.ProductCode:
            return "101";
        case ModbusObjectId.MajorMinorRevision:
            return "1.0";
        case ModbusObjectId.VendorUrl:
            return "ghielectronics.com";
        case ModbusObjectId.ProductName:
            return "SitCore";
        case ModbusObjectId.ModelName:
            return "SCM20260D";
        case ModbusObjectId.UserApplicationName:
            return "Modbus Slave Test";
    }
    return null;
}

protected override ModbusConformityLevel GetConformityLevel() {
    return ModbusConformityLevel.Regular;
}

protected override ModbusErrorCode OnReadCoils(bool isBroadcast, ushort startAddress, ushort coilCount, byte[] coils) {
    try {
        for (int n = 0; n < coilCount; ++n) {
                coils[n] = 1;
        }
        Debug.WriteLine("Master read coils");
        return ModbusErrorCode.NoError;
    } catch {
        Debug.WriteLine("error in on read coils registers");
        return base.OnReadCoils(isBroadcast, startAddress, coilCount, coils);
    }
}

protected override ModbusErrorCode OnReadHoldingRegisters(bool isBroadcast, ushort startAddress, ushort[] registers) {
    for (int n = 0; n < registers.Length; ++n) {
        registers[n] = 65530; // set number in each register for testing               
    }           
        Debug.WriteLine("Master Read Holding Registers - " + registers[0].ToString());
        return ModbusErrorCode.NoError;
    } catch {
        Debug.WriteLine("error in on read holding registers");
        return base.OnReadHoldingRegisters(isBroadcast, startAddress, registers);
    }


// override On<ModusFunction> methods here
```

Now, we can set up the instantiate the Modbus client device inside our code.

```cs

ModbusDevice ModbusTCP_Device;
ModbusTCP_Device = new ModbusSlave(248);
ModbusTcpListener mbListner;
mbListner = new ModbusTcpListener(ModbusTCP_Device, 502, 5, 1000);
Thread.Sleep(100);
ModbusTCP_Device.Start();

```
