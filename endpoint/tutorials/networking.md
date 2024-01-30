# Networking Core

---

Between .NET and the underlaying OS, Endpoint provides full networking support. From simple socket handling to full cloud support.

## Configuration

The network needs to be configured properly before it can be used. For WiFi, SSID and password need to be set for example.

WiFi is currently only supported through USB WiFi dongles containing the RTL8188 chipset.


```cs
using GHIElectronics.Endpoint.Devices.Network;
//...

var networkType = NetworkInterfaceType.WiFi;
var networkSetting = new WiFiNetworkInterfaceSettings
{
    Ssid = "Endpoint",
    Password = "xxxxxxx",
    DhcpEnable = true,
};

var network = new NetworkController(networkType, networkSetting);

network.NetworkLinkConnectedChanged += (a, b) =>
{
    if (b.Connected)
    {
        Console.WriteLine("Connected");

    }
    else
    {
        Console.WriteLine("Disconnected");
    }
};

network.NetworkAddressChanged += (a, b) =>
{
    Console.WriteLine(string.Format("Address: {0}\n gateway: {1}\n DNS: {2}\n MAC: {3} ", b.Address, b.Gateway, b.Dns[0], b.MACAddress));
};

network.Enable();
```

## MQTT

MQTT, and other common protocols, are supported through one of the many available NuGet packages. `DotNetty.Codecs.Mqtt` is the one used by Azure SDK for example.
