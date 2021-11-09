# Software Utility Drivers

---

## Azure SAS

This utility NuGet adds SAS generation used in Azure. See [Microsoft Azure](../tutorials/azure.md) tutorial for more info.

> [!TIP]
> Needed NuGet: GHIElectronics.TinyCLR.Drivers.Azure.SAS

## Basic Graphics

`BasicGraphics` driver is a simpler alternative that runs on all devices, including small devices without native display support. It contains many useful methods for adding simple graphics,including: `SetPixel`, `DrawLine`, `DrawRectangle`, `DrawCircle`, `DrawString`, and `DrawCharacter`. It also includes support for a micro 5px font through `DrawTinyCharacter` and `DrawTinyString`.

There are 2 differences between `DrawCharacter` and `DrawTinyCharacter`, beside the font size! DrawCharacter can accept scaling to enlarge the font, `DrawTinyCharacter` does not. Also, `DrawCharacter` will only set pixels and does not clear blanks. `DrawTinyCharacter` has the same behavior by default but it has a `clear` option to set the blanks to 0 (black).

There are two ways to use BasicGraphics, the first one is agnostic of what display is being used and simply works by calling `SetPixel` method that must be overridden by the user. The user has 2 options, either send the pixel directly to the display or buffer the pixels in a "Video RAM" working buffer and then flush to the screen when desired. Setting the pixels directly on the screen requires zero memory but it is extremely slow.

In the second way, which is the easier way, BasicGraphics will handle allocating the needed video buffer and handles the SetPixel. It already has 2 pixel options, 16BPP 5:6:5 and 1BPP.

> [!TIP]
> Needed NuGet: GHIElectronics.TinyCLR.Drivers.BasicGraphics

An example of the first options, that overrides the `SetPixel` and `Clear` methods. BasicGraphics will not allocate any memory.

```cs
public class BasicGraphicsImp : BasicGraphics{
    public override void SetPixel(int x, int y, uint color){
        // add code to buffer pixels or send directly to display
    }
    public override void Clear(){
       // add optional clear if buffer is used
    }
    // You may need to add this to send an optional buffer...
    public void Flush(){
        // ... for example
        lcd.DrawBufferNative(this.buffer);
    }
}
```

Now, the Basic Graphics driver can be used.

```cs
var basicGfx = new BasicGraphicsImp();
var colorBlue = BasicGraphics.ColorFromRgb(0,0,255);
var colorGreen = BasicGraphics.ColorFromRgb(0,255,0);
var colorRed = BasicGraphics.ColorFromRgb(255,0,0);
var colorWhite = BasicGraphics.ColorFromRgb(255,255,255);

basicGfx.Clear();

basicGfx.DrawString("TinyCLR OS!", colorGreen, 15, 15, 2, 1);
basicGfx.DrawString("SITCore", colorBlue, 35, 40, 2, 2);
basicGfx.DrawString("SC13xxx", colorRed, 35, 60, 2, 2);

Random color = new Random();
for (var i = 20; i < 140; i ++)
    basicGfx.DrawCircle((uint)color.Next(), i, 100, 15);

basicGfx.Flush();
```

This example uses the second option where a buffer is allocated automatically. This is the preferred option for using BasicGraphics.

```cs
var basicGfx = new BasicGraphics(160, 128, ColorFormat.Rgb565);
var colorBlue = BasicGraphics.ColorFromRgb(0,0,255);
var colorGreen = BasicGraphics.ColorFromRgb(0,255,0);
var colorRed = BasicGraphics.ColorFromRgb(255,0,0);
var colorWhite = BasicGraphics.ColorFromRgb(255,255,255);

basicGfx.Clear()

basicGfx.DrawString("TinyCLR OS!", colorGreen, 15, 15, 2, 1);
basicGfx.DrawString("SITCore", colorBlue, 35, 40, 2, 2);
basicGfx.DrawString("SC13xxx", colorRed, 35, 60, 2, 2);

Random color = new Random();
for (var i = 20; i < 140; i ++)
    basicGfx.DrawCircle((uint)color.Next(), i, 100, 15);

// now send to display, using the specific display driver.
MyDisplaySendBuffer(basicGfx.Buffer);
```
## Managed File System

This full FAT file system C# implementation includes SD SPI drivers and is made available for systems that do not have a native built in file system support or if using SD cares over SPI is desired.

```cs
var dataWrite = new byte[5] { 6, 7, 8, 9, 10 };
var dataRead = new byte[dataWrite.Length];

var spiController = SpiController.FromName(SC13048.SpiBus.Spi1);
var chipselect = GpioController.GetDefault().OpenPin(SC13048.GpioPin.PB2);

var managedFS = new ManagedFileSystem(spiController, chipselect);

managedFS.Mount();

Debug.WriteLine("Volumme: " + managedFS.VolumeLabel);
Debug.WriteLine("Total Size: " + managedFS.TotalSize);
Debug.WriteLine("Free: " + managedFS.TotalFreeSpace);

managedFS.CreateDirectory(@"\TEST1");

var fileWrite = managedFS.OpenFile(@"\TEST1\TEST2.txt", FileMode.Write | FileMode.CreateAlways);

managedFS.WriteFile(fileWrite, dataWrite, 0, (uint)dataWrite.Length);
managedFS.FlushFile(fileWrite);
managedFS.CloseFile(fileWrite);

var fileRead = managedFS.OpenFile(@"\TEST1\TEST2.txt", FileMode.Read);

managedFS.ReadFile(fileRead, dataRead, 0, (uint)dataRead.Length);
managedFS.CloseFile(fileRead);
``` 

## IR

Infrared remotes are very common and use multiple standards. NCR is very common and a driver is included. A remote with NCR standard will send an 8bit address and an 8bit command with every key press. A repeat signal will be sent as long as the key is continuously pressed.

> [!TIP]
> Needed NuGet: GHIElectronics.TinyCLR.Drivers.Infrared

```cs
var recievePin = GpioController.GetDefault().OpenPin(SC20260.GpioPin.PH6);
var ir = new NecIRDecoder(recievePin);

ir.OnDataReceivedEvent += Ir_OnDataRecievedEvent;            
ir.OnRepeatEvent += Ir_OnRepeatEvent;

private static void Ir_OnDataRecievedEvent(byte address, byte command) {
    // we have a new key press
}
private static void Ir_OnRepeatEvent() {
    // we have repeat
}
```

## Basic Network

Basic Network works with W5500 module.

> [!TIP]
> Needed NuGets: GHIElectronics.TinyCLR.Drivers.BasicNet, GHIElectronics.TinyCLR.Drivers.BasicNet.Sockets, GHIElectronics.TinyCLR.Drivers.WIZnet.W5500

```cs
var cs = GpioController.GetDefault().OpenPin(SC13048.GpioPin.PB2);
var reset = GpioController.GetDefault().OpenPin(SC13048.GpioPin.PB15);
var interrupt = GpioController.GetDefault().OpenPin(SC13048.GpioPin.PA0);

var spiController = SpiController.FromName(SC13048.SpiBus.Spi1);

var networkController = new W5500Controller(spiController, cs, reset, interrupt); 
var isReady = false;

networkController.NetworkAddressChanged += (a, b) =>
{
    isReady = networkController.Address.GetAddressBytes()[0] != 0 && networkController.Address.GetAddressBytes()[1] != 0;
};

NetworkInterfaceSettings networkSettings = new NetworkInterfaceSettings()
{
    Address = new IPAddress(new byte[] { 192, 168, 0, 200 }),
    SubnetMask = new IPAddress(new byte[] { 255, 255, 255, 0 }),
    GatewayAddress = new IPAddress(new byte[] { 192, 168, 0, 1 }),
    DnsAddresses = new IPAddress[] { new IPAddress(new byte[] { 75, 75, 75, 75 }), new IPAddress(new byte[] { 75, 75, 75, 76 }) },

    MacAddress = new byte[] { your mac },
    DhcpEnable = false,
    DynamicDnsEnable = false,                
};
            

networkController.SetInterfaceSettings(networkSettings);
networkController.Enable();

while (isReady == false) ; // wait for valid IP addrress. 

var dns = new Dns(networkController);
var host = dns.GetHostEntry("www.example.com");
var ep = new IPEndPoint(host.AddressList[0], 80);

// Streaming socket
var socket = new Socket(networkController, AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
socket.Connect(ep);


var content = "GET / HTTP/1.1\r\nHost: www.example.com\r\nConnection: close\r\n\r\n";
socket.Send(Encoding.UTF8.GetBytes(content));

var received = socket.Receive(SocketFlags.None);

if (received.Length > 0) {
    var recvdContent = new string(Encoding.UTF8.GetChars(received));
    Debug.WriteLine("Received : \r\n" + recvdContent);
}
```

## QR Code Generator

This driver converts a string to an image, which can be displays on screen for example.

No NuGet is provided but source code is found [here](https://github.com/ghi-electronics/TinyCLR-Drivers/tree/dev/Barcode).


## GPS Parser

This driver parses standard NEMA strings

```cs
// Find NEMA strings and parse (probably in a seperate thread)
// Read UART, find start and end and then send byte array to parser 
// strings start with $ and end with CR
new Thread(() =>
{
	
	while (true) {
		Parser.Parse(UTF8Encoding.UTF8.GetBytes("NEMA string"));
		Thread.Sleep(1);
	
	}
}
).Start();

// parsed data are available from the class
while (true) {
	
	if (Parser.RMCSentence.DataStatus == Parser.DataStatus.Valid) {
		//Do something
		

	}
	if (Parser.GLLSentence.DataStatus == Parser.DataStatus.Valid) {
		//Do something
	}
	// ...etc
	
	Thread.Sleep(1);
}
```


