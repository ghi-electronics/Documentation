# UART 
---
Serial data ports, called UARTs, transfer data between devices using two pins: TXD (transmit data) and RXD (receive data). UART stands for Universal Asynchronous Receiver Transmitter. Asynchronous means there is no clock signal to synchronize the two devices. The devices agree on a data rate, called the baud rate, and send a start bit the beginning of each transmitted character to keep the devices synchronized. 

> [!Tip]
> the TXD on one end (output) goes to the RXD on the other side (input) and vice versa.

The easiest way to test a UART is by wiring a device's TXD to its RXD so any transmitted data is received by the same device. This is called a "loopback" test. The following code performs a simple loopback test on the FEZ. If you connect the TX pin directly to the RX pin, you will see "ABCDEF" in the output window when running this code.

> [!Tip]
> Don't forget to add the GHIElectronics.TinyCLR.Devices.Uart NuGet package!

```csharp
using System.Diagnostics;
using System.Text;
using System.Threading;
using GHIElectronics.TinyCLR.Devices.Uart;
using GHIElectronics.TinyCLR.Pins;

class Program {
    private static void Main() {
        var txBuffer = new byte[] { 0x41, 0x42, 0x43, 0x44, 0x45, 0x46 };    //A, B, C, D, E, F
        var rxBuffer = new byte[txBuffer.Length];

        var myUart = UartController.FromName(FEZ.UartPort.Usart1);

        myUart.SetActiveSettings(9600, 8, UartParity.None, UartStopBitCount.One, UartHandshake.None);
        myUart.Enable();
        myUart.Write(txBuffer, 0, txBuffer.Length);

        while (true) {
            if (myUart.BytesToRead > 0) {
                var bytesReceived = myUart.Read(rxBuffer, 0, myUart.BytesToRead);
                Debug.WriteLine(Encoding.UTF8.GetString(rxBuffer, 0, bytesReceived));
            }
            Thread.Sleep(20);
        }
    }
}

```

## Event Handlers
TinyCLR's UART API included the following event watchers:

* ClearToSendChanged
* DataReceived
* ErrorReceived

The following example demonstrates the DateReceived event.
```csharp
using System.Diagnostics;
using System.Text;
using System.Threading;
using GHIElectronics.TinyCLR.Devices.Uart;
using GHIElectronics.TinyCLR.Pins;

class Program {
    private static byte[] txBuffer;
    private static byte[] rxBuffer;
    private static UartController myUart;

    private static void Main() {
        txBuffer = new byte[] { 0x41, 0x42, 0x43, 0x44, 0x45, 0x46 };    //A, B, C, D, E, F
        rxBuffer = new byte[txBuffer.Length];
        myUart = UartController.FromName(FEZ.UartPort.Usart1);

        myUart.SetActiveSettings(9600, 8, UartParity.None, UartStopBitCount.One, UartHandshake.None);
        myUart.Enable();

        myUart.DataReceived += MyUart_DataReceived;

        myUart.Write(txBuffer, 0, txBuffer.Length);

        while (true) {
            Thread.Sleep(20);
        }
    }

    private static void MyUart_DataReceived(UartController sender, DataReceivedEventArgs e) {
        var bytesReceived = myUart.Read(rxBuffer, 0, e.Count);
        Debug.WriteLine(Encoding.UTF8.GetString(rxBuffer, 0, bytesReceived));
    }
}

```
> [!Tip] 
> Once you type += after the event, hit the tab key and Visual Studio will automatically create the event for you.

## RS232
UART uses the processor's voltage levels (logic levels) for transferring data. On the FEZ this is 0 to 3.3 volts. In the early days of computers UARTs used -12 to 12 volts to communicate reliably over longer distances. This is known as the RS232 standard.

Some PCs still include serial ports, but those are RS232 serial ports. A voltage level shifter is needed to properly connect a logic level UART to an RS232 device.

> [!Warning]
> Connecting your device to an RS232 port without a proper voltage level shifter can damage your device.
