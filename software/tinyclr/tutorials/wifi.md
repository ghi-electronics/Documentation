# WiFi
---
SITCore line of products includes native support for the Microchip [ATWINC1500](https://www.microchip.com/wwwproducts/en/ATwinc1500) series of WiFi modules. These modules are available pre-certified from FCC, CE, and other regulatory agencies. For added security, WiFi module communication is handled through SPI, not through AT commands.

>[!IMPORTANT]
>To take security to the next level, all network cryptography and security are done internally inside SITCore and not inside the WiFi module, meaning the data going over SPI is all encrypted and secure.

# Supported Modules
ATWINC1500 & 1510 both work identically with SITCore, except the 1510 has more memory that SITCore doesn't need. The part number with the correct firmware that has been tested with TinyCLR is ATWINC1500-MR210PB. A module with a different firmware version can still be used, but a firmware update becomes necessary. Using the exact version eliminates the need for this step. 

# Sample Code
The sample code is meant for the FEZ Portal with it's built in WiFi module. If you want to use a bare ATWINC1500 module instead, you'll need to connect interrupt, reset, and chip select lines in addition to the SPI lines (MOSI, MISO, SCK).

> [!IMPORTANT] 
> If using WiFi 7 click module, there is an enable pin which needs to be pulled high.


>[!TIP]
>Needed NuGets: GHIElectronics.TinyCLR.Core, GHIElectronics.TinyCLR.Devices.Gpio, GHIElectronics.TinyCLR.Devices.Network, GHIElectronics.TinyCLR.Devices.Spi, GHIElectronics.TinyCLR.Devices.Uart, GHIElectronics.TinyCLR.Native, GHIElectronics.TinyCLR.Networking, and GHIElectronics.TinyCLR.Pins.

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
    var enablePin = GpioController.GetDefault().OpenPin(SC20260.GpioPin.PA8);
    enablePin.SetDriveMode(GpioPinDriveMode.Output);
    enablePin.Write(GpioPinValue.High);

    SpiNetworkCommunicationInterfaceSettings netInterfaceSettings =
        new SpiNetworkCommunicationInterfaceSettings();

    var cs = GpioController.GetDefault().OpenPin(SC20260.GpioPin.PA6);

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
        OpenPin(SC20260.GpioPin.PF10);

    netInterfaceSettings.InterruptEdge = GpioPinEdge.FallingEdge;
    netInterfaceSettings.InterruptDriveMode = GpioPinDriveMode.InputPullUp;
    netInterfaceSettings.ResetPin = GpioController.GetDefault().OpenPin(SC20260.GpioPin.PC3);
    netInterfaceSettings.ResetActiveState = GpioPinValue.Low;

    var networkController = NetworkController.FromName
        (SC20260.NetworkController.ATWinc15x0);

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
    wifiSettings.DhcpEnable = true;
    wifiSettings.DynamicDnsEnable = true;

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
---
## WINC1500 Utilities

The Winc15x0Interface class provides to access some of the native functions of the WINC1500 WiFi module. Such as getting the WiFi module's MAC address, getting RSSI (Relative Signal Strength Indicator), scanning for access points, checking the firmware version, and over-the-air (OTA) firmware update.

Unless provided, the MAC address of the WiFi module will be automatically used by default.

>[!TIP]
>Needed NuGets: GHIElectronics.TinyCLR.Drivers.Microchip.Winc15x0

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
---
## Multicast IP

Multicast works as expected on all other network interfaces; however, in order to achieve this on WiFi, we need to convert a Multicast IP to a multicast MAC Address. Any online tool like [this](http://dqnetworks.ie/toolsinfo.d/multicastaddressing.html) can be used.

This capture shows Multicast IP address 239.255.255.254 for example.

![ConverterTool](images/mac-address.jpg)

This Multicast MAC address is then used as below.

```cs 
Winc15x0Interface.AddMulticastMacAddress(new byte[] {​​​​​​​​ 0x01, 0x00, 0x5e, 0x7f, 0xff, 0xfe }​​​​​​​​);
```

If more than one Multicast MAC address is needed, just call AddMulticastMacAddress multiple time.

There is also an API allows remove multicast mac address from the list as well.

```cs 
Winc15x0Interface.RemoveMulticastMacAddress(new byte[] {​​​​​​​​ 0x01, 0x00, 0x5e, 0x7f, 0xff, 0xfe }​​​​​​​​);
```

>[!TIP]
>Needed NuGets: GHIElectronics.TinyCLR.Drivers.Microchip.Winc15x0

---

## AccessPoint
SITCore devices can be set up as a WiFi `AccessPoint`. This creates a 1-to-1 connection between SITCore and other hardware devices through WiFi without the need to connect to a switch. An example might be, connecting a phone directly to the SITCore hardware. This may be necessary in some situations where access to a network isn't possible and a user needs to connect to the device directly. 

>[!TIP]
>AccessPoint only supports connecting to one device at a time.

Setting up a device as an access point works just like the default `Station` mode except the `Ssid` and now the one the device is broadcasting.

```cs
var networkInterfaceSetting = new WiFiNetworkInterfaceSettings() {
    Ssid = "Your SSID",
    Password = "Your Password",
    Mode = WiFiMode.AccessPoint,
};

```

>[!TIP]
>Only WEP password security is supported. Do not set the `Password` for an open network.

`AccessPoint` can provide an IP address to the connected device when `networkInterfaceSetting.DhcpEnabled = true;` through a simple internal DHCP server. If desired, an event is triggered on completion.

```cs
WiFiNetworkInterfaceSettings wifiSettings = new WiFiNetworkInterfaceSettings() {
    Ssid = "Your SSID",
    Password = "Your Password",
};
//...
WiFiNetworkInterfaceSettings wifiSettings.AccessPointClientConnectionChanged += (a, b, c) => {
    Debug.WriteLine("Provided IP = " + b.ToString());
    Debug.WriteLine("Connected device's MAC Address = " + c);
};
```
The usual connection event is fired just like in `Station` mode, except in this case it is fired when an external device is connected `NetworkController.NetworkLinkConnectedChanged`.


