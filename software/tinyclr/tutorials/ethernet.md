# Ethernet
---
Ethernet connection is supported through the internal MAC, by adding an external PHY (100BASE), and also supported through ENC28J60 through [SPI](spi.md) bus (10BASE). Some of the available modules include the necessary PHY so the user will only need to add an Ethernet connector with magnets.

## Built-in Ethernet

This is a simple example:

```csharp
        static bool linkReady = false;

        static void DoTestEthernet()
        {
            // Do external Phy reset
            var gpioController = GpioController.GetDefault();
            var resetPin = gpioController.OpenPin(SC20260.GpioPin.PG3);
            resetPin.SetDriveMode(GpioPinDriveMode.Output);

            resetPin.Write(GpioPinValue.Low);
            Thread.Sleep(100);

            resetPin.Write(GpioPinValue.High);
            Thread.Sleep(100);

            var networkController = NetworkController.FromName("GHIElectronics.TinyCLR.NativeApis.STM32H7.EthernetEmacController\\0");
            var networkInterfaceSetting = new EthernetNetworkInterfaceSettings();
            var networkCommunicationInterfaceSettings = new BuiltInNetworkCommunicationInterfaceSettings();

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

            System.Diagnostics.Debug.WriteLine("Network is ready to use");

            Thread.Sleep(-1);
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

## ENC28J60

This example uses the ENC28J60 click on our SC20100 dev board.

```csharp
static void DoTestEnc28()
{
    var networkController = NetworkController.FromName("GHIElectronics.TinyCLR.NativeApis.ENC28J60.NetworkController");
    var networkInterfaceSetting = new EthernetNetworkInterfaceSettings();

    var networkCommunicationInterfaceSettings = new SpiNetworkCommunicationInterfaceSettings();
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

    networkCommunicationInterfaceSettings.SpiApiName = GHIElectronics.TinyCLR.Pins.SC20260.SpiBus.Spi3;
    networkCommunicationInterfaceSettings.GpioApiName = GHIElectronics.TinyCLR.Pins.SC20260.GpioPin.Id;
    networkCommunicationInterfaceSettings.SpiSettings = settings;
    networkCommunicationInterfaceSettings.InterruptPin = SC20100.GpioPin.PC5;
    networkCommunicationInterfaceSettings.InterruptEdge = GpioPinEdge.FallingEdge;
    networkCommunicationInterfaceSettings.InterruptDriveMode = GpioPinDriveMode.InputPullUp;
    networkCommunicationInterfaceSettings.ResetPin = SC20100.GpioPin.PD4;
    networkCommunicationInterfaceSettings.ResetActiveState = GpioPinValue.Low;

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

    System.Diagnostics.Debug.WriteLine("Network is ready to use");

    Thread.Sleep(-1);
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
## Event Handlers
NetworkController provides two events:
```csharp
private static void NetworkController_NetworkLinkConnectedChanged(NetworkController sender, NetworkLinkConnectedChangedEventArgs e)
{
    // Raise event connect/disconnect
}

private static void NetworkController_NetworkAddressChanged(NetworkController sender, NetworkAddressChangedEventArgs e)
{
    var ipProperties = sender.GetIPProperties();
	var address = ipProperties.Address.GetAddressBytes();
	var subnet = ipProperties.SubnetMask.GetAddressBytes();
	var gw = ipProperties.GatewayAddress.GetAddressBytes();

	var interfaceProperties = sender.GetInterfaceProperties();

	for (int i = 0; i < dnsCount; i++)
	{
		var dns = ipProperties.DnsAddresses[i].GetAddressBytes();

	}
}
```


