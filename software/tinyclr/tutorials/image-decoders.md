# Image Decoders
---
TinyCLR OS provides methods for converting JPG, BMP, and GIF files into bitmaps that can be used in your application. The image can be added to your project as a [resource](resources.md), or the image can be stored in a byte array.

```cs
var screen = Graphics.FromImage(new Bitmap(displayController.ActiveConfiguration.Width,
    displayController.ActiveConfiguration.Height));

//Image is in a resource file named "jpegImageFile":
var imageBitmap = Resource1.GetBitmap(Resource1.BitmapResources.jpegImageFile);

var b1 = new Bitmap(dataArray, BitmapImageType.Jpeg);
var b2 = new Bitmap(dataArray, BitmapImageType.Gif);
var b3 = new Bitmap(dataArray, BitmapImageType.Bmp);  

var imageX = 0;
var imageY = 0;

screen.DrawImage(imageBitmap, imageX, imageY);
```

## Video playback
Animated GIFs are not supported, but [Motion JPEG](mjpeg-video.md) will soon be supported.
