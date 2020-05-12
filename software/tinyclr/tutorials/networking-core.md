# Networking Core
---
Networking support in TinyCLR OS is a subset of Microsoft's .NET Framework networking stack. More details will be added to this tutorial in the future. You might want to look at the [Microsoft Sockets Class]( https://docs.microsoft.com/en-us/dotnet/api/system.net.sockets.socket?view=netframework-4.8) documentation to get started -- it should very closely resemble the TinyCLR sockets class.

## MAC Addresses
SITCore's built in PHY and ENC28 Ethernet networking ship with a default MAC address that is preset by GHI Electronics. This is fine for internal testing, but this is not a unique MAC address suitable for use inside a commercial product.

You will need to set a valid and unique MAC address before shipping your product. If you do not have access to an appropriate MAC address, you can either use an online MAC address generator, which is not ideal, or you can use a MAC address from an old computer or network card that is no longer used.

Not having a unique MAC address can be a problem. If two devices with the same MAC address are present on the same local network subnet, neither device will be able to communicate properly.

The WINC1500 WiFi module supported by SITCore devices ships with a manufacturer assigned unique MAC address. While you can set whatever MAC address you want, it is better to read the manufacturer assigned MAC address and then pass it on to the stack.

## Secure Sockets
TLS is natively support. See the [TLS page](tls.md) for details.

## .NET Sockets
TinyCLR OS's support of sockets is very similar to .NET socket support. Most .NET socket code should run with little modification. Socket support is provided as part of the TinyCLR OS core. Tiny CLR sockets work similar to .NET sockets -- most .NET examples are applicable to TinyCLR.

## TCP/UDP
TCP and UDP are the core of the Internet protocols and are supported through standard .NET Sockets. The web is full of examples on using TCP and UDP Sockets that should work as is or with minor changes.

## DHCP
TinyCLR OS supports both static and dynamic IP addressing. Note that static IP addressing does not work with [PPP](ppp.md).

The following line of code enables dynamic DHCP. For static IP, set `IsDhcpEnabled` to `false`.

```cs
networkInterfaceSetting2.IsDhcpEnabled = true;
```

With static IP addressing, you must provide the following settings. These settings will be ignored if dynamic DHCP is enabled.

```cs
networkInterfaceSetting.Address = new IPAddress(new byte[] { 192, 168, 1, 122 });
networkInterfaceSetting.SubnetMask = new IPAddress(new byte[] { 255, 255, 255, 0 });
networkInterfaceSetting.GatewayAddress = new IPAddress(new byte[] { 192, 168, 1, 1 });
networkInterfaceSetting.DnsAddresses = new IPAddress[] { new IPAddress(new byte[]
    { 75, 75, 75, 75 }), new IPAddress(new byte[] { 75, 75, 75, 76 }) };
```


## DNS
The TinyCLR Dns class can be used to resolve a URL into its IP address by using the following code:

```cs
var hostEntry = Dns.GetHostEntry(hostName);

if ((hostEntry != null) && (hostEntry.AddressList.Length > 0)) {
    var i = 0;
    
    while (hostEntry.AddressList[i] == null) i++;
    
    remoteIpAddress = hostEntry.AddressList[i];
}

else {
    throw new Exception("Server not found."); ;
}
```
