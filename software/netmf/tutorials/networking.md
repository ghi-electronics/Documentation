# Networking
---
Introduction
Networks are an essential part of our everyday lives. Almost every home is connected to a network (the Internet) and most businesses can't function without an internal network (LAN or Wi-Fi) that is connected to an external network (the Internet). All these networks have a standard for communication: TCP/IP. There are actually a few protocols that handle different tasks in the network: DNS, DHCP, IP, ICMP, TCP, UDP, PPP, and others.

In code, you create what is called a socket. A socket allows communication between your computer and one or more other endpoints (usually remote computers). Sockets can be TCP, UDP, and others. Socket support in NETMF is very similar to the full .NET Framework.
 
> [!Tip]
> When working with networking, you may sometimes receive socket exceptions that look like "10054". NETMF uses the same error codes as WinSock on the desktop, so a quick search can tell you what that code means. For example,10054 means connection reset.

## Getting started with WiFi
Since GHI Electronics's devices can provide multiple network interfaces (only one can be used at a time, however), you must initialize the interface you wish to use. To do so, you must create the interface object, open it, configure any network settings, and, in the case of WiFi, join a network. In the below example, you can see that we are using DHCP and dynamic DNS. This allows a lot of the configuration to be done automatically, depending on your network setup. (Static IP and static DNS also work.) Once you join a network and have been issued a valid IP Address, the network is ready to use.

Make sure you enter your network key in the proper format. WPA/WPA2 keys are the literal string value while WEP keys are the hex digits without the leading 0x.

The following code requires the GHI.Networking, Microsoft.SPOT.Hardware, and Microsoft.SPOT.Net assemblies. Make sure that you update the pins in the constructor to match your hardware setup.

```cs
using GHI.Networking;
using Microsoft.SPOT;
using Microsoft.SPOT.Hardware;
using Microsoft.SPOT.Net.NetworkInformation;
using System;
using System.Net;
using System.Threading;

public class Program
{
    private static WiFiRS9110 netif;

    public static void Main()
    {
        NetworkChange.NetworkAvailabilityChanged += NetworkChange_NetworkAvailabilityChanged;
        NetworkChange.NetworkAddressChanged += NetworkChange_NetworkAddressChanged;

        netif = new WiFiRS9110(SPI.SPI_module.SPI1, Cpu.Pin.GPIO_Pin1, Cpu.Pin.GPIO_Pin2, Cpu.Pin.GPIO_Pin3);
        netif.Open();
        netif.EnableDhcp();
        netif.EnableDynamicDns();
        netif.Join("SSID", "Password");

        while (netif.IPAddress == "0.0.0.0")
        {
            Debug.Print("Waiting for DHCP");
            Thread.Sleep(250);
        }
        //The network is now ready to use.
    }

    private static void NetworkChange_NetworkAddressChanged(object sender, Microsoft.SPOT.EventArgs e)
    {
        Debug.Print("Network address changed");
    }

    private static void NetworkChange_NetworkAvailabilityChanged(object sender, NetworkAvailabilityEventArgs e)
    {
        Debug.Print("Network availability: " + e.IsAvailable.ToString());
    }
}
```

## Wired Ethernet
If you want to use a physical Ethernet connection, you can use our SPI based ENC28 or the built in Ethernet adapter. Initializing the network is similar to WiFi in either case, except you do not join a network as seen below.

```cs
netif = new EthernetENC28J60(SPI.SPI_module.SPI1, Cpu.Pin.GPIO_Pin1, Cpu.Pin.GPIO_Pin2, Cpu.Pin.GPIO_Pin3);
netif.Open();
netif.EnableDhcp();
netif.EnableDynamicDns();

while (netif.IPAddress == "0.0.0.0")
{
    Debug.Print("Waiting for DHCP");
    Thread.Sleep(250);
}

//The network is now ready to use.
```

```cs
netif = new EthernetBuiltIn();
netif.Open();
netif.EnableDhcp();
netif.EnableDynamicDns();

while (netif.IPAddress == "0.0.0.0")
{
    Debug.Print("Waiting for DHCP");
    Thread.Sleep(250);
}

//The network is now ready to use.
```
## HTTP communication
Once you configure a network interface, you probably want to start communicating over the network. One of the easiest ways to do this is through HTTP. After you have received an IP Address (as shown above), you can create an HTTP request to a URL and then receive its response. What you do with that data is up to you. Make sure the result buffer is larger enough to hold the response or process the data as you read it.

```cs
byte[] result = new byte[65536];
int read = 0;

using (var req = HttpWebRequest.Create("url to query") as HttpWebRequest)
{
    using (var res = req.GetResponse() as HttpWebResponse)
    {
        using (var stream = res.GetResponseStream())
        {
            do
            {
                read = stream.Read(result, 0, result.Length);

                Thread.Sleep(20);
            } while (read != 0);
        }
    }
}

//The result array now contains the data received from the remote server.
```

## mIP
For those who want greater control over the networking stack, there is the mIP C# library available at http://mip.codeplex.com/ It is a full networking stack allowing you to modify it to suit your needs, something not easily done with the built in stack.

## PPP
You can use the provided PPP class to communicate with serial PPP devices such as cellular or regular modems that provide access to the internet. After you configure your device over a serial port (potentially using AT commands that differ for every device), you pass that port and any authentication parameters to our PPP class and then, once the PPP connection is established with the device, you can use the regular NETMF networking functionality to access the internet or your network.

The below example shows the basic initialization, AT commands, and PPP commands needed to access the network using a SIM908 cellular modem. You must provide your own SIM card and correctly set the APN and COM port based on your setup. The code requires the GHI.Networking, Microsoft.SPOT.SerialPort, and Microsoft.SPOT.Net assemblies. Different AT commands will be needed for different modems.

```cs
using GHI.Networking;
using Microsoft.SPOT.Net.NetworkInformation;
using System.IO.Ports;
using System.Text;
using System.Threading;

public class Program
{
    private static AutoResetEvent evt;

    private static void Main()
    {
        evt = new AutoResetEvent(false);

        NetworkChange.NetworkAvailabilityChanged += NetworkChange_NetworkAvailabilityChanged;

        using (var port = new SerialPort("YOUR COM PORT", 115200, Parity.None, 8, StopBits.One))
        {
            port.Open();

            port.DiscardInBuffer();
            port.DiscardOutBuffer();

            SendATCommand(port, "AT+CGDCONT=2,\"IP\",\"YOUR APN\"");
            SendATCommand(port, "ATDT*99***2#");

            using (var netif = new PPPSerialModem(port))
            {
                netif.Open();
                netif.Connect(PPPSerialModem.AuthenticationType.Pap, "", "");

                evt.WaitOne();

                //The network is now ready to use.
            }
        }
    }

    private static void NetworkChange_NetworkAvailabilityChanged(object sender, NetworkAvailabilityEventArgs e)
    {
        if (e.IsAvailable)
            evt.Set();
    }

    private static void SendATCommand(SerialPort port, string command)
    {
        var sendBuffer = Encoding.UTF8.GetBytes(command + "\r");
        var readBuffer = new byte[256];
        var read = 0;

        port.Write(sendBuffer, 0, sendBuffer.Length);

        while (true)
        {
            read += port.Read(readBuffer, read, readBuffer.Length - read);

            var response = new string(Encoding.UTF8.GetChars(readBuffer, 0, read));

            if (response.IndexOf("OK") != -1 || response.IndexOf("CONNECT") != -1)
                break;
        }
    }
}
```

## SSL
SSL allows you to secure the communications between your device and a remote server. Currently only SSL2, SSL3, and TLS1.0 are supported. Your NETMF device must have the proper time set for SSL to function.

Unlike your PC, NETMF devices do not maintain a database of root certificates which are used to verify a remote server is who it says it is. As a result, you must manually include the root certificate for the site you are connecting to in your project.

One easy way to accomplish this is to go to the site in your browser, click the padlock icon near the address bar, view the certificate, and then go to the Certification Path tab, click the top most (the root) certificate entry, view it, then under Details, copy it to a file, making sure to use base 64 encoding. Add that file as a resource to your project.

Unfortunately, this will not always work. Some sites present different certificates based on who it detects it asking for them. Additionally, some certificates may be cross signed where there is another root you must use. You can try to search online for the actual root certificate or use Wireshark or a similar program. To use Wireshark, capture the traffic from the device when you try to connect to the desired site. It should fail since you do not have the correct certificate. Early in the conversation, after the "Server Hello" packet, find a "Certificate" packet. Under the SSL > Handshake Protocol > Certificates, find the very last entry. Make sure it is its own issuer. If not, you must use the issuer as the root certificate. For example, when connecting to https://www.google.com/, the very last certificate is GeoTrust Global CA. In the browser, it is issued by itself. In Wireshark from our device however, it is actually issued by Equifax Secure Certificate Authority.

Once you have added it to your project, you can use the below code to communicate with that site: just pass in the URL you want to download and the root certificate. It requires the Microsoft.SPOT.Native and System.Http assemblies. When connecting to different sites, make sure to repeat the same process and get their root certificate as well. You are also required to update the SSL seed using MFDeploy or FEZ Config any time you update the firmware.

```cs
void DownloadOverSsl(string url, byte[] certificate) {
    using (var request = HttpWebRequest.Create(url) as HttpWebRequest) {
        request.HttpsAuthentCerts = new X509Certificate[] { new X509Certificate(certificate) };
        request.KeepAlive = false;

        using (var response = request.GetResponse()) {
            using (var stream = response.GetResponseStream()) {
                var result = string.Empty;
                var buffer = new byte[4096];
                var read = 0;

                stream.ReadTimeout = 5000;

                for (var left = response.ContentLength; left > 0; ) {
                    Thread.Sleep(1000);

                    try {
                        read = stream.Read(buffer, 0, buffer.Length);
                    }
                    catch {
                        continue;
                    }

                    left -= read;

                    result += new string(Encoding.UTF8.GetChars(buffer, 0, read));
                }

                Debug.Print(result);
            }
        }
    }
}
```
If you do not want to use the HTTP classes, you can use a raw socket. After you have called Connect on the desired socket, pass it to the constructor of SslStream found in System.Net.Security. You then have to call AuthenticateAsClient on it. The first parameter is the common name. Often that is the host portion of the URL, such as "www.ghielectronics.com", but it is not always. To find the common name of the site, look at the "Issued To" field on the certificate details window. The next parameter is null, followed by an X509Certificate array containing the root certificate. The last two parameters need to be SslVerification.CertificateRequired and SslProtocols.Default. Once that call completes, you can read and write to that stream.

Calls to Read will not always succeed, especially if called in rapid succession. You should wait a bit between calls. Waits up to 1 second can be expected depending on your exact network characteristics. We recommend testing different lengths and calibrating the wait for your needs.

