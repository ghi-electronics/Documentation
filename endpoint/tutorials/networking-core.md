[IN PROGRESS](error.md) 
# Networking Core
---
Networking support in TinyCLR OS is a subset of Microsoft's .NET Framework networking stack. More details will be added to this tutorial in the future. You might want to look at the [Microsoft Sockets Class]( https://docs.microsoft.com/en-us/dotnet/api/system.net.sockets.socket?view=netframework-4.8) documentation to get started -- it should very closely resemble the TinyCLR sockets class.

## MAC Addresses
Before using SITCore's built in PHY and ENC28 Ethernet networking, you have to set a MAC address or an exception will be raised. While you may not need a unique MAC address for internal testing, you will need to set a valid and unique MAC address before shipping your product. If you do not have access to an appropriate MAC address, you can either use an online MAC address generator, which is not ideal, or you can use a MAC address from an old computer or network card that is no longer used.

Not having a unique MAC address can be a problem. If two devices with the same MAC address are present on the same local network subnet, neither device will be able to communicate properly.

The WINC1500 WiFi module supported by SITCore devices ships with a manufacturer assigned unique MAC address. This address is used by default, although you can provide your own MAC address if desired.

---

## Secure Sockets
TLS is natively supported. See the [TLS page](tls.md) for details.

---

## .NET Sockets
TinyCLR OS's support of sockets is very similar to .NET socket support. Most .NET socket code should run with little modification. Socket support is provided as part of the TinyCLR OS core. Tiny CLR sockets work similar to .NET sockets -- most .NET examples are applicable to TinyCLR.

---

## TCP/UDP
TCP and UDP are the core of the Internet protocols and are supported through standard .NET Sockets. The web is full of examples on using TCP and UDP Sockets that should work as is or with minor changes.

TCP example:
```cs
var s = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp)){               
    try {
        var ip = IPAddress.Parse("192.168.1.87");                 
        s.Connect(new IPEndPoint(ip, 80));           
        s.Send(System.Text.UTF8Encoding.UTF8.GetBytes("I am SITCore\n\r"));
    }
    catch {
    }               
}
```

UDP example:
```cs
var socket = new System.Net.Sockets.Socket(AddressFamily.InterNetwork, SocketType.Dgram, ProtocolType.Udp);
var ip = new IPAddress(new byte[] { 192, 168, 1, 87 });
var endPoint = new IPEndPoint(ip, 2000);

socket.Connect(endPoint);

byte[] bytesToSend = Encoding.UTF8.GetBytes(msg);

while (true) {
    socket.SendTo(bytesToSend, bytesToSend.Length, SocketFlags.None, endPoint);
    while (socket.Poll(2000000, SelectMode.SelectRead)){
        if (socket.Available > 0){
            byte[] inBuf = new byte[socket.Available];
            var recEndPoint = new IPEndPoint(IPAddress.Any, 0);
            socket.ReceiveFrom(inBuf, ref recEndPoint);
            if (!recEndPoint.Equals(endPoint))// Check if the received packet is from the 192.168.0.2
                continue;
            Debug.WriteLine(new String(Encoding.UTF8.GetChars(inBuf)));
        }
    }
    Thread.Sleep(100);
}     
```

---

## IP Assignment
TinyCLR OS supports both static and dynamic IP addressing. With either method, an event is fired providing the local IP settings.

```cs
networkController.NetworkAddressChanged += NetworkController_NetworkAddressChanged;
// ...
private static void NetworkController_NetworkAddressChanged
    (NetworkController sender, NetworkAddressChangedEventArgs e) {
    var ipProperties = sender.GetIPProperties();
}
```


### Static IP

With static IP addressing, the following settings must be provided.

```cs
networkInterfaceSetting.DhcpEnabled = false;
networkInterfaceSetting.Address = new IPAddress(new byte[] { 192, 168, 1, 122 });
networkInterfaceSetting.SubnetMask = new IPAddress(new byte[] { 255, 255, 255, 0 });
networkInterfaceSetting.GatewayAddress = new IPAddress(new byte[] { 192, 168, 1, 1 });
networkInterfaceSetting.DnsAddresses = new IPAddress[] { new IPAddress(new byte[]
    { 75, 75, 75, 75 }), new IPAddress(new byte[] { 75, 75, 75, 76 }) };
```
### Dynamic IP

The following line of code enables dynamic IP, which start by trying to lease an IP from a DHCP server. If that fails, the system will self-assign an IP address through AutoIP mechanism. This can take a while but an event is fired when an IP is available.

```cs
networkInterfaceSetting.DhcpEnabled = true;
```

> [!Tip]
> AutoIP addresses always fall within the 169.254.x.x range to determine if an IP was generated using AutoIP

---

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
---
## mDNS
Multicast DNS is a local name resolution service over local networks. Please note that not all operating systems support mDNS.

```cs
networkInterfaceSetting.MulticastDnsEnable = true;

networkController.Enable();

MulticastDns.Start("MyServer", TimeSpan.FromSeconds(1*60*60));    // TTL set to 1 hour

```