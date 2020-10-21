# PPP
---

Point to Point Protocol (PPP) started in the days of dial up Internet and is still used today in cellular modems. While using PPP can be optional for small IoT systems, having a secure connection requires PPP. A [MAC address](networking-core.md) is not needed for PPP.

This example uses the LTE IoT 2 click module on the SCM20260D Dev Boards to establish a connection and read a web page. We've also successfully tested the SIMCOM SIM900 and NimbeLink's Skywire cellular embedded modems.

>[!TIP]
>Needed Nugets: GHIElectronics.TinyCLR.Core, GHIElectronics.TinyCLR.Devices.Gpio, GHIElectronics.TinyCLR.Devices.Network, GHIElectronics.TinyCLR.Devices.Spi, GHIElectronics.TinyCLR.Devices.Uart, GHIElectronics.TinyCLR.Native, GHIElectronics.TinyCLR.Networking, and GHIElectronics.TinyCLR.Pins.

```cs
class Program {
    static bool linkReady = false;

    static void Main() {
        var reset = GpioController.GetDefault().OpenPin(SC20260.GpioPin.PI8);

        reset.SetDriveMode(GpioPinDriveMode.Output);

        reset.Write(GpioPinValue.High);
        Thread.Sleep(200);

        reset.Write(GpioPinValue.Low);
        Thread.Sleep(7000); //Wait for modem to initialize.

        InitSimCard();
        TestPPP();
    }

    static void InitSimCard() {
        var serial = UartController.FromName
            (SC20260.UartPort.Uart8);

        serial.SetActiveSettings(115200, 8,
            UartParity.None,
            UartStopBitCount.One,
            UartHandshake.None);

        serial.Enable();

        while (!SendAT(serial, "AT")) { }

        SendAT(serial, "AT+CGDCONT=1,\"IP\",\"h2g2\"");                      //Google Fi.
        SendAT(serial, "AT+CGDCONT=2,\"IP\",\"telargo.t-mobile.com\"");      //T-Mobile.
        SendAT(serial, "AT+CGDCONT=3,\"IP\",\"fast.t-mobile.com\"");         //T-Mobile.
        SendAT(serial, "AT+CGDCONT=4,\"IPV4V6\",\"NIMBLINK.GW12.VZWENTP\""); //NimbeLink.

        SendAT(serial, "ATDT*99***1#"); //Modem dial string. The '1' in this string points
                                        //  to the Google Fi PDP context previously defined
                                        //  by the SendAT() method.

        Debug.WriteLine("OK to start PPP....");
    }

    static void TestPPP() {
        var networkController = NetworkController.
            FromName("NativeApis.Ppp.NetworkController");

        PppNetworkInterfaceSettings networkInterfaceSetting = new PppNetworkInterfaceSettings() {
                AuthenticationType = PppAuthenticationType.Pap,

                Username = "",
                Password = "",
            };

        UartNetworkCommunicationInterfaceSettings networkCommunicationInterfaceSettings = new UartNetworkCommunicationInterfaceSettings() {
                ApiName = SC20260.UartPort.Uart8,
                BaudRate = 115200,
                DataBits = 8,
                Parity = UartParity.None,
                StopBits = UartStopBitCount.One,
                Handshaking = UartHandshake.None,
            };

        networkController.SetInterfaceSettings(networkInterfaceSetting);
        networkController.SetCommunicationInterfaceSettings
            (networkCommunicationInterfaceSettings);

        networkController.SetAsDefaultController();

        networkController.NetworkAddressChanged += NetworkController_NetworkAddressChanged;
        networkController.NetworkLinkConnectedChanged +=
            NetworkController_NetworkLinkConnectedChanged;

        networkController.Enable();

        while (linkReady == false) { }
        //Network is now ready to use.
    }

    private static void NetworkController_NetworkLinkConnectedChanged
        (NetworkController sender, NetworkLinkConnectedChangedEventArgs e) {
        //Raise event connect/disconnect
    }

    private static void NetworkController_NetworkAddressChanged
        (NetworkController sender,NetworkAddressChangedEventArgs e) {

        var ipProperties = sender.GetIPProperties();
        var address = ipProperties.Address.GetAddressBytes();

        Debug.WriteLine("IP Address: " + address[0] + "." + address[1]
            + "." + address[2] + "." + address[3]);

        linkReady = address[0] != 0;
    }

    static bool SendAT(UartController port,
        string command) {

        command += "\r";

        var sendBuffer = Encoding.UTF8.GetBytes(command);
        var readBuffer = new byte[256];
        var read = 0;
        var count = 10;

        port.Write(sendBuffer, 0, sendBuffer.Length);

        while (count-- > 0) {
            Thread.Sleep(100);

            read += port.Read(readBuffer, read, readBuffer.Length - read);

            var response = new string
                (Encoding.UTF8.GetChars(readBuffer, 0, read));

            if (response.IndexOf("OK") != -1 || response.IndexOf("CONNECT") != -1) {
                Debug.WriteLine(" " + response);
                return true;
            }
        }
        return false;
    }
}
```

## Switching to Command Mode

When a PPP connection is set up successfully, you can switch the modem from data mode to command mode with the `+++` escape sequence. To prevent the `+++` escape sequence from being misinterpreted as data, the following guidelines should be followed: 
 
1) Do not send any other characters within one second (before or after) of sending `+++`.  
2) Send `+++` quickly, sending all three characters within one second. 
 
When the `+++` sequence is received, the modem will switch from data mode to command mode and reply with an "OK" response. 

## Switching to Data Mode
When the modem is in command mode, sending the `ATO` command will switch the modem to Data Mode. Wait for the "CONNECT 150000000" response after sending the `ATO` command to make sure the modem is in data mode. All data sent will now be treated as PPP frames.

The following example switches from Data mode to Command Mode, sends a few AT commands, then switches back to Data mode. TinyCLR OS provides two functions, Suspend() and Resume() that are needed for this example. This code uses SC20260.UartPort.Uart8 for PPP configuration.

```cs
//PPP is connected
//....

networkController.Suspend(); //Suspend PPP, release UART Port from TinyCLR OS.
{
    //Open UART.
    var serial = GHIElectronics.TinyCLR.Devices.Uart.UartController.FromName
        (SC20260.UartPort.Uart8);

    serial.SetActiveSettings(
        115200,
        8,
        GHIElectronics.TinyCLR.Devices.Uart.UartParity.None,
        GHIElectronics.TinyCLR.Devices.Uart.UartStopBitCount.One,
        GHIElectronics.TinyCLR.Devices.Uart.UartHandshake.None);

    serial.Enable();

    Thread.Sleep(1000);

    SendAT(serial, "+++"); //Send "+++" to enter command mode.

    Thread.Sleep(1000);

    //Send any AT command here. 
    //For example, AT+CSQ to check signal strength.
    SendAT(serial, "AT+CSQ");

    SendAT(serial, "ATO"); //Enable "PPP" modem, wait for "CONNECT 150000000" response.

    serial.Dispose();

    serial = null; //Release UART, resume PPP interface.
}

networkController.Resume();

// Continue network
...
```

> [!NOTE]
> When sending "+++", do not send "\r" or "\n" at the end. While most AT commands need end of line characters, +++ does not.

## Security Clarification

Most users of embedded systems that connect to mobile networks assume they are secure, but often they are not. Typically, a serial connection with AT commands is used to communicate with the modem. While the data over the air is secure, all data transmitted over the serial connection is raw unencrypted data that can be easily scoped. This is not the case with TinyCLR OS.

With TinyCLR OS, serial data between the device and the modem is encrypted. All data handling is done internally inside the core processor, which is extremely difficult to hack into.

