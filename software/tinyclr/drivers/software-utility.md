# Software Utility Drivers
---

## Azure SAS
This utility NuGet adds SAS generation used in Azure. See [Microsoft Azure](../tutorials/azure.md) tutorial for more info.

>[!TIP]
>Needed NuGet: GHIElectronics.TinyCLR.Drivers.Azure.SAS

## Basic Graphics

Basic Graphics driver is used when deployment space is needed for projects and simple graphics are only needed. 

Basic Graphics contains many useful methods for adding simple graphics. Included in the driver are `SetPixel`,`DrawLine`,`DrawRectangle`,`DrawCircle`,`DrawString`,`DrawText`, and `DrawCharacter`.

The driver is agnostic of what display is being used and simply works by calling `SetPixel` method that must be overridden by the user. The user has 2 options, either send the pixel directly to the display or buffer the pixels in a "Video RAM" working buffer and then flush to the screen when desired. Setting th pixels directly on the screen requires zero memory but it is extremely slow.

>[!Note]
>The Basic Graphic driver supports pixel multiplier. Meaning a 160x128 display can be treated as an 80x64 display. It is lower resolution but 10kb vs 40kb of RAM. More about pixel multiplier can be found in the [SPI](../tutorials/spi.md) tutorial 

An example on how to override the SetPixel method:

>[!TIP]
>Needed NuGet: GHIElectronics.TinyCLR.Drivers.BasicGraphic

```cs
public class BasicGraphicDemo : BasicGraphic{
    public override void SetPixel(int x, int y, uint color){
        // add code to buffer pixels or send directly to display
    }
    public void Flush(){
        // add code to send the buffer to the display
        lcd.DrawBufferNative(this.buffer);
    }
}
```

Now, the Basic Graphics driver can be used.

```cs
var basicGfx = new BasicGraphicDemo(1, 1);
var colorBlue = 0x00FF0000U;
var colorGreen = 0x0000FF00U;
var colorRed = 0x00000FFU;
var colorWhite = 0x00FFFFFFU;

basicGfx.Clear()

basicGfx.DrawText("Hi Insiders!", colorGreen, 15, 15, 2, 1);
basicGfx.DrawText("SITCore", colorBlue, 35, 40, 2, 2);
basicGfx.DrawText("SC13xxx", colorRed, 35, 60, 2, 2);

Random color = new Random();
for (var i = 20; i < 140; i ++)
    basicGfx.DrawCircle((uint)color.Next(), i, 100, 15);

basicGfx.Flush();

Thread.Sleep(Timeout.Infinite);
```

while each display is different, here is en example that renders SetPixel to 16BPP 5:6:5 to a buffer

```cs
public override void SetPixel(int x, int y, uint color){
    if (x < 0 || y < 0 || x >= this.Width || y >= this.Height) return;
    var idx = (y * this.Width + x) * 2;
    var clr = color;
    this.buffer[idx + 0] = (byte)(((clr & 0b0000_0000_0000_0000_0001_1100_0000_0000) >> 5) | ((clr & 0b0000_0000_0000_0000_0000_0000_1111_1000) >> 3));
    this.buffer[idx + 1] = (byte)(((clr & 0b0000_0000_1111_1000_0000_0000_0000_0000) >> 16) | ((clr & 0b0000_0000_0000_0000_1110_0000_0000_0000) >> 13));
}
```

This example renders SetPixel to a 1BPP to a buffer

```cs
public override void SetPixel(int x, int y, uint color){
    if (x < 0 || y < 0 || x >= this.Width || y >= this.Height) return;
    var index = (y / 8) * this.Width + x;
    if (color != 0){
        this.buffer[index] |= (byte)(1 << (y % 8));
    }
    else{
        this.buffer[index] &= (byte)(~(1 << (y % 8)));
    }
}
```

## IR

Infrared remotes are very common and use multiple standards. NCR is very common and a driver is included. A remote with NCR standard will send an 8bit address and an 8bit command with every key press. A repeat signal will be sent as long as the key is continuously pressed.

>[!TIP]
>Needed NuGet: GHIElectronics.TinyCLR.Drivers.Infrared.NecIR

```cs
static void Main() {

    var recievePin = GpioController.GetDefault().OpenPin(SC20260.GpioPin.PH6);
    var ir = new NecIRDecoder(recievePin);

    ir.OnDataReceivedEvent += Ir_OnDataRecievedEvent;            
    ir.OnRepeatEvent += Ir_OnRepeatEvent;
}

private static void Ir_OnDataRecievedEvent(byte address, byte command) {
    // we have a new key press
}
private static void Ir_OnRepeatEvent() {
    // we have repeat
}


```
## QR Code Generator
This driver converts a string to an image, which can be displays on screen for example.

>[!TIP]
>Needed NuGet:

```cs
To be added
```

## GPS Parser
>[!TIP]
>Needed NuGet:

```cs
To be added
```
