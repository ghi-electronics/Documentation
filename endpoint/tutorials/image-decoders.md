# Image Decoders
---
TinyCLR OS provides methods for converting JPG, BMP, and GIF files into bitmaps that can be used in your application. The image can be added to your project as a [resource](resources.md), or the image can be loaded from a byte array, like from and SD card.

> [!Tip]
> BMP supports 256 colors and 24bit.
> GIF does not support animated images.

```cs
var screen = Graphics.FromImage(new Bitmap(displayController.ActiveConfiguration.Width,
    displayController.ActiveConfiguration.Height));

//Image is in a resource file named "jpegImageFile":
var imageBitmap = Resources.GetBitmap(Resources.BitmapResources.jpegImageFile);

var b1 = new Bitmap(dataArray, BitmapImageType.Jpeg);
var b2 = new Bitmap(dataArray, BitmapImageType.Gif);
var b3 = new Bitmap(dataArray, BitmapImageType.Bmp);  

var imageX = 0;
var imageY = 0;

screen.DrawImage(imageBitmap, imageX, imageY);
```

## Saving Bitmaps 
Image class supports saving Bitmaps in a file stream format using the following code sample:

```cs
var bm = new Bitmap(data, width, height);
bm.Save(yourFilestream, System.Drawing.Imaging.ImageFormat.Bmp);
```

## Video playback
Video playback can be achieved through [Motion JPEG](mjpeg-video.md).
