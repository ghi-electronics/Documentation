# PPP
---
Point to Point protocol started in the phone line dial-up Internet days and it is still in use today through cellular modems. While using PPP can be optional for small IoT systems, having a secure connection requires PPP.

This example uses the xxxx click module on our dev boards to establish a connection and read a web page.

```csharp
static bool linkReady = false;

static void DoTestPPP()
{
            
    var networkController = NetworkController.FromName("GHIElectronics.TinyCLR.NativeApis.Ppp.NetworkController");
    PppNetworkInterfaceSettings networkInterfaceSetting = new PppNetworkInterfaceSettings()
    {
        AuthenticationType = PppAuthenticationType.Pap,
        Username = "",
        Password = "",
    };

    UartNetworkCommunicationInterfaceSettings networkCommunicationInterfaceSettings = new UartNetworkCommunicationInterfaceSettings()
    {
        ApiName = GHIElectronics.TinyCLR.Pins.SC20260.UartPort.Usart1,
        BaudRate = 115200,
        DataBits = 8,
        Parity = UartParity.None,
        StopBits = UartStopBitCount.One,
        Handshaking = UartHandshake.None,
    };

    networkInterfaceSetting.Address = new IPAddress(new byte[] { 192, 168, 1, 122 });
    networkInterfaceSetting.SubnetMask = new IPAddress(new byte[] { 255, 255, 255, 0 });
    networkInterfaceSetting.GatewayAddress = new IPAddress(new byte[] { 192, 168, 1, 1 });
    networkInterfaceSetting.DnsAddresses = new IPAddress[] { new IPAddress(new byte[] { 75, 75, 75, 75 }), new IPAddress(new byte[] { 75, 75, 75, 76 }) };

    networkInterfaceSetting.MacAddress = new byte[] { 0x00, 0x4, 0x00, 0x00, 0x00, 0x00 };
    networkInterfaceSetting.IsDhcpEnabled = true;
    networkInterfaceSetting.IsDynamicDnsEnabled = true;

    networkInterfaceSetting.TlsEntropy = new byte[] { 0, 1, 2, 3 };

    networkController.SetInterfaceSettings(networkInterfaceSetting);
    networkController.SetCommunicationInterfaceSettings(networkCommunicationInterfaceSettings);
    networkController.SetAsDefaultController();

    networkController.NetworkAddressChanged += NetworkController_NetworkAddressChanged;
    networkController.NetworkLinkConnectedChanged += NetworkController_NetworkLinkConnectedChanged;

    networkController.Enable();

    while (linkReady == false) ;

    // Network is ready to used
}

private static void NetworkController_NetworkLinkConnectedChanged(NetworkController sender, NetworkLinkConnectedChangedEventArgs e)
{
    // Raise event connect/disconnect
}

private static void NetworkController_NetworkAddressChanged(NetworkController sender, NetworkAddressChangedEventArgs e)
{
    var ipProperties = sender.GetIPProperties();
    var address = ipProperties.Address.GetAddressBytes();

    linkReady = address[0] != 0;
}
```

> [!NOTE]  
> Depends on your sim card and cellular modem, you may need to send some commands to initialize the sim card to be ready for PPP.

Below is simple AT commands that we tested on SIM900 and SKYWIRE modules, using T-Mobile Simcard.

```csharp
static void InitSimCard() {
    var serial = GHIElectronics.TinyCLR.Devices.Uart.UartController.FromName(GHIElectronics.TinyCLR.Pins.SC20260.UartPort.Usart1);

    serial.SetActiveSettings(115200, 8, GHIElectronics.TinyCLR.Devices.Uart.UartParity.None, GHIElectronics.TinyCLR.Devices.Uart.UartStopBitCount.One, GHIElectronics.TinyCLR.Devices.Uart.UartHandshake.None);

    serial.Enable();

    SendAT(serial, "AT");

    SendAT(serial, "AT+CGDCONT=2,\"IP\",\"telargo.t-mobile.com\"");
    SendAT(serial, "ATDT*99***2#");
    
    System.Diagnostics.Debug.WriteLine("OK to start PPP....");
}

static void SendAT(UartController port, string command)
{
    command += "\r";

    var sendBuffer = Encoding.UTF8.GetBytes(command);
    var readBuffer = new byte[256];
    var read = 0;

    port.Write(sendBuffer, 0, sendBuffer.Length);

    while (true)
    {
        read += port.Read(readBuffer, read, readBuffer.Length - read);

        var response = new string(Encoding.UTF8.GetChars(readBuffer, 0, read));

        if (response.IndexOf("OK") != -1 || response.IndexOf("CONNECT") != -1)
        {
            System.Diagnostics.Debug.WriteLine(" " + response);
            break;
        }
    }
}
```

From Main function, the example will look like below:
```csharp
static void Main()
{
    InitSimCard();
    DoTestPPP();
}
```

## Security Clarification
Most embedded systems that connect to mobile networks assume they are secure but they are surely not. Typically, a serial connection with AT commands are used to communicate with the Internet. While the data offer the air is secure, all the data going over the serial wire is raw unencrypted data that can be easily scoped. This is not the case on TinyCLR OS.

Operating systems like TinyCLR that utilizes PPP for communication are secure due to the fact that the serial data between the device and the modem is encrypted. All data handling is done internally inside the core processor, which is extremely difficult to hack into.

