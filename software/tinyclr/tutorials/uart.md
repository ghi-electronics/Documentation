# UART 
---
Serial data ports, called UARTs, transfer data between devices using two pins: TXD (transmit data) and RXD (receive data). UART stands for Universal Asynchronous Receiver Transmitter. Asynchronous means there is no clock signal to synchronize the two devices. The devices agree on a data rate, called the baud rate, and send a start bit the beginning of each transmitted character to keep the devices synchronized.

Some of the UARTs also have additional pins (RTS and CTS) to control data flow. These pins are only activated when `Handshaking = UartHandshake.RequestToSend`.

> [!Tip]
> the TXD on one end (output) goes to the RXD on the other side (input) and vice versa.

> [!Tip]
> UART ports are also referred to as COM ports, especially on PCs..

The easiest way to test a UART is by wiring a device's TXD to its RXD so any transmitted data is received by the same device. This is called a "loopback" test. The following code performs a simple loopback test.

> [!Tip]
> UART requires the GHIElectronics.TinyCLR.Devices.Uart NuGet package.

```cs
var txBuffer = new byte[] { 0x41, 0x42, 0x43, 0x44, 0x45, 0x46 }; //A, B, C, D, E, F
var rxBuffer = new byte[txBuffer.Length];

var myUart = UartController.FromName(SC20100.UartPort.Uart7);

var uartSetting = new UartSetting() {
        BaudRate = 115200,
        DataBits = 8,
        Parity = UartParity.None,
        StopBits = UartStopBitCount.One,
        Handshaking = UartHandshake.None,
    };

myUart.SetActiveSettings(uartSetting);

myUart.Enable();
myUart.Write(txBuffer, 0, txBuffer.Length);

while (true) {
    if (myUart.BytesToRead > 0) {
        var bytesReceived = myUart.Read(rxBuffer, 0, myUart.BytesToRead);
        Debug.WriteLine(Encoding.UTF8.GetString(rxBuffer, 0, bytesReceived));
    }

    Thread.Sleep(20);
}
```

---

## UART Settings
The UART settings are expanded to better support serial protocols such as RS-485 and DMX. Here's a complete list of the available settings:
- BaudRate: Communication speed in bits per second.
- DataBits: Number of data bits in each byte. Usually set to eight.
- Parity: Parity bit setting. Disabled when set to `UartParity.None`.
- StopBits: Number of stop bits sent to mark the end of each byte.
- Handshaking: Can be set to none or `UartHandshake.RequestToSend` for hardware handshaking.
- EnableDePin: Used to enable and disable the `Driver Enable` pin, which is used for RS-485 communication.
- InvertTxPolarity: Used to invert high and low states of the transmit pin. Useful for hardware that inverts this signal.
- InvertRxPolarity: Used to invert high and low states of the receive pin. Useful for hardware that inverts this signal.
- InvertBinaryData: Used to invert the data polarity without inverting the start and stop bit polarity.
- SwapTxRxPin: Swaps the transmit and receive pins. Very useful for correcting board layout mistakes!
- InvertDePolarity: Inverts the polarity of the `Driver Enable` pin used for RS485.

---

## RS485 and Driver Enable
Transceivers, such as RS485, may require a DE (Driver Enable) pin. On SITCore, DE pin is same pin as RTS. The UART settings can be used to enable this feature through `EnableDePin` and `InvertDePolarity`.

---
## RS232
UART uses the processor's voltage levels (logic levels) for transferring data. On the SITCore this is 0 to 3.3 volts. In the early days of computers, UARTs used -12 to +12 volts to communicate reliably over longer distances. This is known as the RS232 standard.

Some PCs still include serial ports, but those are RS232 serial ports. A voltage level shifter is needed to properly connect a logic level UART to an RS232 device.

> [!Warning]
> Connecting your device to an RS232 port without a proper voltage level shifter can damage your device.

---

## Break Generation
It is sometimes necessary to generate a `break` signal before transmission to let the receiver(s) know that a new data frame is starting. Such is the case when using the DMX protocol, which is often used for stage lighting.

> [!NOTE]
> The previous transmission must finish before starting a new transmission that incorporates a break signal.

The following code sample shows how to transmit an array of bytes using the DMX protocol:
```cs
GpioPin dmxEnablePin = GpioController.GetDefault().OpenPin(SC20100.GpioPin.PA1);
dmxEnablePin.SetDriveMode(GpioPinDriveMode.Output);
dmxEnablePin.Write(GpioPinValue.High);

var uart = UartController.FromName(SC20100.UartPort.Uart5);

uart.SetActiveSettings(new UartSetting {
    DataBits = 8,
    StopBits = UartStopBitCount.Two,
    BaudRate = 250000 });

uart.Enable();

var txBuffer = new byte[] { 0, 127, 255, 255, 255 };

while (uart.BytesToWrite > 0) Thread.Sleep(0); //Make sure UART is done transmitting.

//The following line sends a break of 100 uS before sending the data.
uart.Write(txBuffer, 0, txBuffer.Length, TimeSpan.FromTicks(1000));
```

---

## Event Handlers
TinyCLR's UART API included the following event listeners:

* ClearToSendChanged
* DataReceived
* ErrorReceived

```cs
private static void Main() {
    txBuffer = new byte[] { 0x41, 0x42, 0x43, 0x44, 0x45, 0x46 }; //A, B, C, D, E, F
    rxBuffer = new byte[txBuffer.Length];

    myUart = UartController.FromName(SC20100.UartPort.Uart7);
    var uartSetting = new UartSetting()
            {
                BaudRate = 115200,
                DataBits = 8,
                Parity = UartParity.None,
                StopBits = UartStopBitCount.One,
                Handshaking = UartHandshake.None,
            };
    myUart.SetActiveSettings(uartSetting);
    myUart.Enable();
    myUart.DataReceived += MyUart_DataReceived;
    myUart.Write(txBuffer, 0, txBuffer.Length);
    while (true)
        Thread.Sleep(20);
}

private static void MyUart_DataReceived(UartController sender, DataReceivedEventArgs e) {
    var bytesReceived = myUart.Read(rxBuffer, 0, e.Count);
    Debug.WriteLine(Encoding.UTF8.GetString(rxBuffer, 0, bytesReceived));
}
```

> [!Tip] 
> Once you type += after the event, hit the tab key and Visual Studio will automatically create the event for you.

 

