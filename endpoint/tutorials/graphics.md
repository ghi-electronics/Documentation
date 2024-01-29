[IN PROGRESS](error.md) 
# Graphics

---
The `GHIElectronics.Endpoint.Devices.Display` NuGet package includes the backbone for all graphics needs. It uses [SkiaSharp](https://learn.microsoft.com/en-us/xamarin/xamarin-forms/user-interface/graphics/skiasharp/) Graphics library their API can be found [here](https://learn.microsoft.com/en-us/dotnet/api/skiasharp?view=skiasharp-2.88)


---
Once a display has been [initialized and configured](../tutorials/displays.md) it is ready to start adding graphics using SkiaSharp. Add the elements inside the ```SKCanvas```

## SkiaSharp Canvas

The follow code initialize the SkiaSharp canvas this where the SkiaSharp element are placed.

```cs
SKBitmap bitmap = new SKBitmap(screenWidth, screenHeight, SKImageInfo.PlatformColorType, SKAlphaType.Premul);
bitmap.Erase(SKColors.Transparent);

while (true){
    // Initialize the SkiaSharp Canvas
    using (var screen = new SKCanvas(bitmap)){

        ///////////////////////////////////////////
        // Place SkiaSharp Graphics content here //
        ///////////////////////////////////////////

     // Flush to screen
        var data = bitmap.Copy(SKColorType.Rgb565).Bytes;
        displayController.Flush(data);
        Thread.Sleep(1);
    }
}
```




> [!Note]
> SkiaSharp elements are displayed in hierarchical order with the each item being stacked on top of the previous item. 

---

## Drawing Text

The example below displays text on the screen using SkiaSharp built in ```SKFont```

There a several different attributes that can be set using the [SkiaSharp API](https://learn.microsoft.com/en-us/dotnet/api/skiasharp).

```cs
// Draw text
using (SKPaint text = new SKPaint()){
    text.Color = SKColors.Blue; //Uses built-in color value
    //text.Color = SKColor.Parse("#FF0977aa"); //Uses Hex value for Color
    text.IsAntialias = true;
    text.StrokeWidth = 2;
    text.Style = SKPaintStyle.Fill;
    text.TextSize = 12;
    SKFont sKFont = new SKFont();
    sKFont.Size = 22;
    SKTextBlob textBlob = SKTextBlob.Create("Hello Endpoint", sKFont);
    screen.DrawText(textBlob, 50, 120, text);
}
```
---

## Using TrueType Fonts

Any TrueType font can be used, it just needs to be added as a [resource](resources.md). To add a font change the extension from **.tft** to **.bin**. This will save the font in **resources** as a byte, the format SkiaSharp needs to display. 

```cs
byte[] fontfile = Resources.ArialBlack;
Stream stream = new MemoryStream(fontfile);

using (SKPaint text = new SKPaint())
using (SKTypeface tf = SKTypeface.FromStream(stream)){
    text.Color = SKColors.Red;
    text.IsAntialias = true;
    text.StrokeWidth = 2;
    text.Style = SKPaintStyle.Fill;

    SKFont font = new SKFont();
    font.Size = 90;
    font.Typeface = tf;
    SKTextBlob textBlob = SKTextBlob.Create("Hello Endpoint", font);
    screen.DrawText(textBlob, 160, 155, text);
}
```
---

## Drawing Images

The example below displays an image on the screen using [resources](resources.md). 

> [!Tip]
> Images need to be saved as .bin files in the Resoures.resx window.

```cs
// Draw image from resource
var img = logo;
var info = new SKImageInfo(300, 200); 
var sk_img = SKBitmap.Decode(img, info);
screen.DrawBitmap(sk_img, 0, 0);
```

---