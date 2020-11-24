# WiFi
---
First introduced over twenty years ago, WiFi has become the most popular wireless networking technology. Our SITCore line of products includes native support for the Microchip [ATWINC1500](https://www.microchip.com/wwwproducts/en/ATwinc1500) series of WiFi modules. These modules are available pre-certified from FCC, CE, and other regulatory agencies. For added security, WiFi module communication is handled through SPI, not through AT commands.

The sample code is meant for the FEZ Portal with it's built in WiFi module. If you want to use a bare ATWINC1500 module instead, you'll need to connect interrupt, reset, and chip select lines in addition to the SPI lines (MOSI, MISO, SCK).

This example uses the FEZ Portal with its built in ATWINC1500 WiFi module.

>[!TIP]
>Needed Nugets: GHIElectronics.TinyCLR.Core, GHIElectronics.TinyCLR.Devices.Gpio, GHIElectronics.TinyCLR.Devices.Network, GHIElectronics.TinyCLR.Devices.Spi, GHIElectronics.TinyCLR.Devices.Uart, GHIElectronics.TinyCLR.Native, GHIElectronics.TinyCLR.Networking, and GHIElectronics.TinyCLR.Pins.

```cs
using GHIElectronics.TinyCLR.Devices.Gpio;
using GHIElectronics.TinyCLR.Devices.Network;
using GHIElectronics.TinyCLR.Devices.Spi;
using GHIElectronics.TinyCLR.Pins;
using System;
using System.Diagnostics;
using System.Net;
using System.Threading;

static void Wifi_Example() {
    var enablePin = GpioController.GetDefault().OpenPin(SC20260.GpioPin.PI0);
    enablePin.SetDriveMode(GpioPinDriveMode.Output);
    enablePin.Write(GpioPinValue.High);

    SpiNetworkCommunicationInterfaceSettings netInterfaceSettings =
        new SpiNetworkCommunicationInterfaceSettings();

    var cs = GpioController.GetDefault().OpenPin(SC20260.GpioPin.PG12);

    var settings = new SpiConnectionSettings() {
        ChipSelectLine = cs,
        ClockFrequency = 4000000,
        Mode = SpiMode.Mode0,
        ChipSelectType = SpiChipSelectType.Gpio,
        ChipSelectHoldTime = TimeSpan.FromTicks(10),
        ChipSelectSetupTime = TimeSpan.FromTicks(10)
    };

    netInterfaceSettings.SpiApiName = SC20260.SpiBus.Spi3;

    netInterfaceSettings.GpioApiName = SC20260.GpioPin.Id;

    netInterfaceSettings.SpiSettings = settings;
    netInterfaceSettings.InterruptPin = GpioController.GetDefault().
        OpenPin(SC20260.GpioPin.PG6);

    netInterfaceSettings.InterruptEdge = GpioPinEdge.FallingEdge;
    netInterfaceSettings.InterruptDriveMode = GpioPinDriveMode.InputPullUp;
    netInterfaceSettings.ResetPin = GpioController.GetDefault().OpenPin(SC20260.GpioPin.PI8);
    netInterfaceSettings.ResetActiveState = GpioPinValue.Low;

    var networkController = NetworkController.FromName
        ("GHIElectronics.TinyCLR.NativeApis.ATWINC15xx.NetworkController");

    WiFiNetworkInterfaceSettings wifiSettings = new WiFiNetworkInterfaceSettings() {
        Ssid = "Your SSID",
        Password = "Your Password",
    };

    wifiSettings.Address = new IPAddress(new byte[] { 192, 168, 1, 122 });
    wifiSettings.SubnetMask = new IPAddress(new byte[] { 255, 255, 255, 0 });
    wifiSettings.GatewayAddress = new IPAddress(new byte[] { 192, 168, 1, 1 });
    wifiSettings.DnsAddresses = new IPAddress[] { new IPAddress(new byte[]
        { 75, 75, 75, 75 }), new IPAddress(new byte[] { 75, 75, 75, 76 }) };

    wifiSettings.MacAddress = new byte[] { 0x00, 0x4, 0x00, 0x00, 0x00, 0x00 };
    wifiSettings.IsDhcpEnabled = true;
    wifiSettings.IsDynamicDnsEnabled = true;
    wifiSettings.TlsEntropy = new byte[] { 0, 1, 2, 3 };

    networkController.SetInterfaceSettings(wifiSettings);
    networkController.SetCommunicationInterfaceSettings(netInterfaceSettings);
    networkController.SetAsDefaultController();

    networkController.NetworkAddressChanged += NetworkController_NetworkAddressChanged;

    networkController.NetworkLinkConnectedChanged +=
        NetworkController_NetworkLinkConnectedChanged;

    networkController.Enable();

    // Network is ready to use
    Thread.Sleep(Timeout.Infinite);
}

private static void NetworkController_NetworkLinkConnectedChanged
    (NetworkController sender, NetworkLinkConnectedChangedEventArgs e) {
    // Raise event connect/disconnect
}

private static void NetworkController_NetworkAddressChanged
    (NetworkController sender, NetworkAddressChangedEventArgs e) {
    var ipProperties = sender.GetIPProperties();
    var address = ipProperties.Address.GetAddressBytes();
    Debug.WriteLine("IP: " + address[0] + "." + address[1] + "." + address[2] +
        "." + address[3]);
}
```

> [!IMPORTANT] 
> There is an enable pin which needs to be pulled high on the WiFI 7 click module. 

```cs
var enablePin = GpioController.GetDefault().OpenPin(SC20260.GpioPin.PI0);
            
enablePin.SetDriveMode(GpioPinDriveMode.Output);
enablePin.Write(GpioPinValue.High);
```

## WINC1500 Utilities

We provide the static Winc15x0Interface class to access some of the native functions of the WINC1500 WiFi module. Commands for getting the WiFi module's MAC address, getting RSSI (Relative Signal Strength Indicator), scanning for access points, checking the firmware version, and over-the-air (OTA) firmware update are supported.

Unless you provide your own MAC address, the MAC address of the WiFi module will be used by default. More information about MAC addresses can be found [here](networking-core.md).

```cs
//Scan for WiFi access points:
string[] ssidList = Winc15x0Interface.Scan();

//Get Relative Signal Strength Indicator for the connected access point:
int signalStrength = Winc15x0Interface.GetRssi();

//Get the WiFi module's MAC address:
byte[] macAddress = Winc15x0Interface.GetMacAddress(); 

//Get the version of the installed WiFi firmware:
string fwVersion = Winc15x0Interface.GetFirmwareVersion();

//Print a list of WiFi firmware versions that have been tested with TinyCLR OS.
//   Note: Untested WiFi firmware versions may also work.
for (int i = 0; i < Winc15x0Interface.FirmwareSupports.Length; i++) {
    System.Diagnostics.Debug.WriteLine("Supported firmware version #" +
        (i + 1).ToString() + ": " + Winc15x0Interface.FirmwareSupports[i].ToString());
}

//Download and install firmware from an OTA download (web) server:
//   Must upload firmware file to root folder in server
//   (e.g.  http://192.168.0.137/m2m_ota_3a0.bin).
bool success = Winc15x0Interface.FirmwareUpdate(string url, int timeout);
```

## Multicast IP

There is no way to set-up Multicast IP directly within WINC1500 WiFi module API. In order to achieve this we need to convert a Multicast IP to a MAC Address using a converter tool found [here](http://dqnetworks.ie/toolsinfo.d/multicastaddressing.html). 

Assuming that the Multicast IP address needed is 239.255.255.254 enter this in the tool and convert to a Multicast MAC address

![ConverterTool](images/mac-address.jpg)

This is Multicast MAC address needed to setup the WiFi module for Multicast networking

```cs 
networkInterfaceSetting.MacAddress = new byte[] {​​​​​​​​ 0x01, 0x00, 0x5e, 0x7f, 0xff, 0xfe }​​​​​​​​;
```


