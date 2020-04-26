# Ethernet
---
Ethernet is supported through the internal MAC, by adding an external PHY (100BASE), and also by using an ENC28J60 over [SPI](spi.md) bus (10BASE). Some available modules include the necessary PHY, so the user will only need to add an Ethernet connector with magnets.

## Built-in Ethernet

Here is a simple example:

>[!TIP]
>Needed Nugets: GHIElectronics.TinyCLR.Devices.Network, GHIElectronics.TinyCLR.Devices.Gpio, GHIElectronics.TinyCLR.Pins

```cs
static bool linkReady = false;

static void EthernetTest() {
    //Reset external phy.
    var gpioController = GHIElectronics.TinyCLR.Devices.Gpio.GpioController.GetDefault();
    var resetPin = gpioController.OpenPin(GHIElectronics.TinyCLR.Pins.SC20260.GpioPin.PG3);
    resetPin.SetDriveMode(GHIElectronics.TinyCLR.Devices.Gpio.GpioPinDriveMode.Output);
    resetPin.Write(GHIElectronics.TinyCLR.Devices.Gpio.GpioPinValue.Low);

    System.Threading.Thread.Sleep(100);

    resetPin.Write(GHIElectronics.TinyCLR.Devices.Gpio.GpioPinValue.High);
    System.Threading.Thread.Sleep(100);

    var networkController = GHIElectronics.TinyCLR.Devices.Network.NetworkController.FromName
        (GHIElectronics.TinyCLR.Pins.SC20260.NetworkController.EthernetEmac);

    var networkInterfaceSetting = new GHIElectronics.TinyCLR.Devices.Network.
        EthernetNetworkInterfaceSettings();

    var networkCommunicationInterfaceSettings = new GHIElectronics.TinyCLR.
        Devices.Network.BuiltInNetworkCommunicationInterfaceSettings();

    networkInterfaceSetting.Address = new System.Net.IPAddress
        (new byte[] { 192, 168, 1, 122 });

    networkInterfaceSetting.SubnetMask = new System.Net.IPAddress
        (new byte[] { 255, 255, 255, 0 });

    networkInterfaceSetting.GatewayAddress = new System.Net.IPAddress
        (new byte[] { 192, 168, 1, 1 });

    networkInterfaceSetting.DnsAddresses = new System.Net.IPAddress[] 
        { new System.Net.IPAddress(new byte[] { 75, 75, 75, 75 }),
         new System.Net.IPAddress(new byte[] { 75, 75, 75, 76 }) };

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

    System.Diagnostics.Debug.WriteLine("Network is ready to use");

    System.Threading.Thread.Sleep(-1);
}

private static void NetworkController_NetworkLinkConnectedChanged
    (GHIElectronics.TinyCLR.Devices.Network.NetworkController sender,
    GHIElectronics.TinyCLR.Devices.Network.NetworkLinkConnectedChangedEventArgs e) {
    //Raise connect/disconnect event.
}

private static void NetworkController_NetworkAddressChanged
    (GHIElectronics.TinyCLR.Devices.Network.NetworkController sender,
    GHIElectronics.TinyCLR.Devices.Network.NetworkAddressChangedEventArgs e) {

    var ipProperties = sender.GetIPProperties();
    var address = ipProperties.Address.GetAddressBytes();

    linkReady = address[0] != 0;
}
```

## ENC28J60

This example uses the ENC28J60 click on our SC20260D Dev Board.

>[!TIP]
>Needed Nugets: GHIElectronics.TinyCLR.Devices.Network, GHIElectronics.TinyCLR.Devices.Gpio, GHIElectronics.TinyCLR.Devices.Spi, GHIElectronics.TinyCLR.Pins

```cs
static void Enc28Test()
{
    var networkController = NetworkController.FromName
        ("GHIElectronics.TinyCLR.NativeApis.ENC28J60.NetworkController");

    var networkInterfaceSetting = new EthernetNetworkInterfaceSettings();

    var networkCommunicationInterfaceSettings = new
        SpiNetworkCommunicationInterfaceSettings();

    var cs = GHIElectronics.TinyCLR.Devices.Gpio.GpioController.GetDefault().
        OpenPin(GHIElectronics.TinyCLR.Pins.SC20260.GpioPin.PG12);

    var settings = new GHIElectronics.TinyCLR.Devices.Spi.SpiConnectionSettings()
    {
        ChipSelectLine = cs,
        ClockFrequency = 4000000,
        Mode = GHIElectronics.TinyCLR.Devices.Spi.SpiMode.Mode0,
        ChipSelectType = GHIElectronics.TinyCLR.Devices.Spi.SpiChipSelectType.Gpio,
        ChipSelectHoldTime = TimeSpan.FromTicks(10),
        ChipSelectSetupTime = TimeSpan.FromTicks(10)
    };

    networkCommunicationInterfaceSettings.SpiApiName =
        GHIElectronics.TinyCLR.Pins.SC20260.SpiBus.Spi3;

    networkCommunicationInterfaceSettings.GpioApiName =
        GHIElectronics.TinyCLR.Pins.SC20260.GpioPin.Id;

    
    networkCommunicationInterfaceSettings.SpiSettings = settings;
    networkCommunicationInterfaceSettings.InterruptPin = GHIElectronics.TinyCLR.Devices.Gpio.GpioController.GetDefault().
        OpenPin(GHIElectronics.TinyCLR.Pins.SC20260.GpioPin.PG6);
    networkCommunicationInterfaceSettings.InterruptEdge = GpioPinEdge.FallingEdge;
    networkCommunicationInterfaceSettings.InterruptDriveMode = GpioPinDriveMode.InputPullUp;
    networkCommunicationInterfaceSettings.ResetPin = GHIElectronics.TinyCLR.Devices.Gpio.GpioController.GetDefault().
        OpenPin(GHIElectronics.TinyCLR.Pins.SC20260.GpioPin.PI8);
    networkCommunicationInterfaceSettings.ResetActiveState = GpioPinValue.Low;


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

    System.Diagnostics.Debug.WriteLine("Network is ready to use");

    Thread.Sleep(-1);
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

## Event Handlers

NetworkController provides two events:

```cs
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
	var subnet = ipProperties.SubnetMask.GetAddressBytes();
	var gw = ipProperties.GatewayAddress.GetAddressBytes();

	var interfaceProperties = sender.GetInterfaceProperties();

	for (int i = 0; i < dnsCount; i++)
	{
		var dns = ipProperties.DnsAddresses[i].GetAddressBytes();
	}
}

```


