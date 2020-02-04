# WiFi
---
First introduced over twenty years ago, WiFi has become the most popular wireless networking technology. Our SITCore line of products includes native support for the Microchip [ATWINC1500](https://www.microchip.com/wwwproducts/en/ATwinc1500) series of WiFi modules. These modules are available pre-certified from FCC, CE, and other regulatory agencies. For added security, WiFi module communication is handled through SPI, not through AT commands.

The easiest way to get started quickly is by plugging a mikro WiFi 7 click module into the mikroBUS 1 socket on one of our dev boards. If you want to use a bare ATWINC1500 module instead of a mikro click module, you'll need to connect interrupt, reset, and chip select lines in addition to the SPI lines (MOSI, MISO, SCK).

This example uses the WiFi 7 click on our SC20100 dev board.

>[!TIP]
>Needed Nugets: GHIElectronics.TinyCLR.Devices.Network, GHIElectronics.TinyCLR.Devices.Gpio, GHIElectronics.TinyCLR.Devices.Spi, GHIElectronics.TinyCLR.Pins

```cs
static void DoTestWiFi7Click()
{
    var enablePin = GpioController.GetDefault().OpenPin(SC20100.GpioPin.PA15);
            
    enablePin.SetDriveMode(GpioPinDriveMode.Output);
    enablePin.Write(GpioPinValue.High);

    SpiNetworkCommunicationInterfaceSettings networkCommunicationInterfaceSettings =
        new SpiNetworkCommunicationInterfaceSettings();

    var settings = new GHIElectronics.TinyCLR.Devices.Spi.SpiConnectionSettings()
    {
        ChipSelectLine = SC20100.GpioPin.PD3,
        ClockFrequency = 4000000,
        Mode = GHIElectronics.TinyCLR.Devices.Spi.SpiMode.Mode0,
        DataBitLength = 8,
        ChipSelectType = GHIElectronics.TinyCLR.Devices.Spi.SpiChipSelectType.Gpio,
        ChipSelectHoldTime = TimeSpan.FromTicks(10),
        ChipSelectSetupTime = TimeSpan.FromTicks(10)
    };

    networkCommunicationInterfaceSettings.SpiApiName =
        GHIElectronics.TinyCLR.Pins.SC20260.SpiBus.Spi3;

    networkCommunicationInterfaceSettings.GpioApiName =
        GHIElectronics.TinyCLR.Pins.SC20260.GpioPin.Id;

    networkCommunicationInterfaceSettings.SpiSettings = settings;
    networkCommunicationInterfaceSettings.InterruptPin = SC20100.GpioPin.PC5;
    networkCommunicationInterfaceSettings.InterruptEdge = GpioPinEdge.FallingEdge;
    networkCommunicationInterfaceSettings.InterruptDriveMode = GpioPinDriveMode.InputPullUp;
    networkCommunicationInterfaceSettings.ResetPin = SC20100.GpioPin.PD4;
    networkCommunicationInterfaceSettings.ResetActiveState = GpioPinValue.Low;

    var networkController = NetworkController.FromName
        ("GHIElectronics.TinyCLR.NativeApis.ATWINC15xx.NetworkController");

    WiFiNetworkInterfaceSettings networkInterfaceSetting = new WiFiNetworkInterfaceSettings()
    {
        Ssid = "yourSSID",
        Password = "yourPassword",
    };

    networkInterfaceSetting.Address = new IPAddress(new byte[] { 192, 168, 1, 122 });
    networkInterfaceSetting.SubnetMask = new IPAddress(new byte[] { 255, 255, 255, 0 });
    networkInterfaceSetting.GatewayAddress = new IPAddress(new byte[] { 192, 168, 1, 1 });
    networkInterfaceSetting.DnsAddresses = new IPAddress[] { new IPAddress(new byte[]
        { 75, 75, 75, 75 }), new IPAddress(new byte[] { 75, 75, 75, 76 }) };

    networkInterfaceSetting.MacAddress = new byte[] { 0x00, 0x4, 0x00, 0x00, 0x00, 0x00 };
    networkInterfaceSetting.IsDhcpEnabled = true;
    networkInterfaceSetting.IsDynamicDnsEnabled = true;

    networkInterfaceSetting.TlsEntropy = new byte[] { 0, 1, 2, 3 };

    networkController.SetInterfaceSettings(networkInterfaceSetting);
    networkController.SetCommunicationInterfaceSettings
        (networkCommunicationInterfaceSettings);

    networkController.SetAsDefaultController();

    networkController.NetworkAddressChanged += NetworkController_NetworkAddressChanged;
    networkController.NetworkLinkConnectedChanged +=
        NetworkController_NetworkLinkConnectedChanged;

    networkController.Enable();

    while (linkReady == false) ;

    // Network is ready to used
}

private static void NetworkController_NetworkLinkConnectedChanged
    (NetworkController sender, NetworkLinkConnectedChangedEventArgs e)
{
    // Raise event connect/disconnect
}

private static void NetworkController_NetworkAddressChanged
    (NetworkController sender, NetworkAddressChangedEventArgs e)
{
    var ipProperties = sender.GetIPProperties();
    var address = ipProperties.Address.GetAddressBytes();
           
    linkReady = address[0] != 0;
}
```

> [!IMPORTANT] 
> There is an enable pin which needs to be pulled high on the WiFI 7 click module. 

```cs
var enablePin = GpioController.GetDefault().OpenPin(SC20100.GpioPin.PA15);
            
enablePin.SetDriveMode(GpioPinDriveMode.Output);
enablePin.Write(GpioPinValue.High);
```



