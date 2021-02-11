# Encoding & Decoding
---
TinyCLR OS provides many internal fast methods to handle many encoding and decoding tasks.

## Strings and Arrays

The Encoding class is used to convert between strings, character arrays, and byte arrays. For example, to convert from a byte array to a string:

```cs
var string = System.Text.Encoding.UTF8.GetString(new byte[] { 65, 66, 67, 68, 69 });
//string = "ABCDE"
```

Convert From String to Byte Array

```cs
System.Text.Encoding.UTF8.GetBytes(string s)

//The following method returns an integer for the number of bytes converted.
//The resulting bytes are returned within the byte[] array.
System.Text.Encoding.UTF8.GetBytes(string s, int charIndex, int charCount, byte[] bytes,
    int byteIndex)
```

Convert From Byte Array to Character Array

```cs
System.Text.Encoding.UTF8.GetChars(byte[] bytes)
System.Text.Encoding.UTF8.GetChars(byte[] bytes, int byteIndex, int byteCount)
```

Convert From Byte Array to String

```cs
System.Text.Encoding.UTF8.GetString(byte[] bytes)
System.Text.Encoding.UTF8.GetString(byte[] bytes, int index, int count)
```

---

## Base64
Base64 is a standard way to convert binary data into readable ASCII readable.

```
var base64EncodedString = System.Convert.FromBase64String(string);
var base64EncodedChar = System.Convert.FromBase64CharArray(char[]);
var convertedFromBase64 = System.Convert.ToBase64String(byte[]);
```
RFC4648 Base64 standard is supported by adding `Convert.UseRFC4648Encoding = true;`.

---

## BitConverter
The BitConverter class is used to convert from one data type to another. For example, to convert an integer into a byte array:

```cs
var byteArray = System.BitConverter.GetBytes(23);
//byteArray[0] = 23, byteArray[1] = 0, byteArray[2] = 0, byteArray[3] = 0

byteArray = System.BitConverter.GetBytes(65536);
//byteArray[0] = 0, byteArray[1] = 0, byteArray[2] = 1, byteArray[3] = 0
```

You can also convert from a byte array to a string, but the results are different than the results from the Encoding class:

```cs
var string = System.BitConverter.ToString(new byte[] { 65, 66, 67, 68, 69 });
//string = "41-42-43-44-45" (hexadecimal values delimited by hyphens).

var string = System.Text.Encoding.UTF8.GetString(new byte[] { 65, 66, 67, 68, 69 });
//string = "ABCDE"
```

### BitConverter Overloads

#### Convert to a Byte Array

```cs
System.BitConverter.GetBytes(char value)
System.BitConverter.GetBytes(double value)
System.BitConverter.GetBytes(float value)
System.BitConverter.GetBytes(int value)
System.BitConverter.GetBytes(long value)
System.BitConverter.GetBytes(short value)
System.BitConverter.GetBytes(uint value)
System.BitConverter.GetBytes(ulong value)
System.BitConverter.GetBytes(ushort value)
System.BitConverter.GetBytes(bool value)
```

#### Convert from a Byte Array

```cs
System.BitConverter.ToBoolean(byte[] bytes, int startIndex)
System.BitConverter.ToChar(byte[] bytes, int startIndex)
System.BitConverter.ToDouble(byte[] bytes, int startIndex)
System.BitConverter.ToInt16(byte[] bytes, int startIndex)
System.BitConverter.ToInt32(byte[] bytes, int startIndex)
System.BitConverter.ToInt64(byte[] bytes, int startIndex)
System.BitConverter.ToSingle(byte[] bytes, int startIndex)
System.BitConverter.ToString(byte[] bytes)
System.BitConverter.ToString(byte[] bytes, int startIndex)
System.BitConverter.ToString(byte[] bytes, int startIndex, int length)
System.BitConverter.ToUInt16(byte[] bytes, int startIndex)
System.BitConverter.ToUInt32(byte[] bytes, int startIndex)
System.BitConverter.ToUInt64(byte[] bytes, int startIndex)
```

#### Convert Between Double and Long

```cs
System.BitConverter.DoubleToInt64Bits(double value)
System.BitConverter.Int64BitsToDouble(long value)
```

#### Swap Endianness

```cs
System.BitConverter.SwapEndianness(byte[] data, int groupSize)
```

---

## String Handling

### ToString() Supported Conversions

As TinyCLR OS is a subset of the full desktop .NET development system, not all desktop .NET features are supported. The following `ToString()` arguments are supported:
```cs
Debug.WriteLine(123.ToString("N4")); //Outputs 123.0000
Debug.WriteLine(123.ToString("F4")); //Outputs 123.0000
Debug.WriteLine(123.ToString("D4")); //Outputs 0123
Debug.WriteLine(123.ToString("G4")); //Outputs 123
Debug.WriteLine(123.ToString("X4")); //Outputs 007B
```

The following `ToString()` arguments are not supported and will raise an exception:
```cs
Debug.WriteLine(123.ToString("E4")); //'E' option not supported
Debug.WriteLine(123.ToString("R4")); //'R' option not supported
Debug.WriteLine(123.ToString("P4")); //'P' option not supported
Debug.WriteLine(123.ToString("C2")); //'C' option not supported
```


### StringBuilder

As strings are immutable, manipulating strings, especially in a tight loop, can impact system performance and increase memory usage and fragmentation. Because strings cannot be changed, every time you manipulate a string a new string is created and the original string becomes garbage. The StringBuilder class uses a string buffer to improve the performance of string manipulation, allowing you to manipulate strings instead of creating new strings.

The following example changes the content of a string without creating a new string.

```cs
var sb = new System.Text.StringBuilder("PA0 is the pin to use.");

sb[1] = 'B';

System.Diagnostics.Debug.WriteLine(sb.ToString()); //Will output "PB0 is the pin to use."
```

StringBuilder is also great when you want to build strings by concatenating characters or other strings. Without StringBuilder, each time you add a character to a string, a new string is created and the old string becomes garbage. The following code creates a string one character at a time without creating all the garbage strings.

```cs
var sb = new System.Text.StringBuilder();

for (int i=48; i<58; i++) {
    sb.Append((char)i);
}

Debug.WriteLine(sb.ToString()); //Will output "0123456789"
```

### Color Space
Internally TinyCLR uses the 5:6:5 RGB 16BPP color space, requiring two bytes per pixel. Users may find the need to use a different color space.

```
 Convert(byte[] inArray, byte[] outArray, ColorFormat colorFormat, RgbFormat rgbFormat, byte alpha, byte[] colorTable)
```

Users must create `outArray` of a length that is determined based on the `ColorFormat` the user is converting to. The table below will help in determining `outArray` buffer size.

| Color Space Desired    | size of `outArray` buffer|
|------------------------|---------------------------|
| **3:5:2**              | `inArray.Length` x 0.5   |
| **4:4:4**              | `inArray.Length` x 0.75  |
| **5:6:5**              | `inArray.Length` x 1     |
| **8:8:8**              | `inArray.Length` x 1.5   |
| **8:8:8:8**            | `inArray.Length` x 2.0   |

`RgbFormat` is used to swap colors is necessary.

> [!TIP] Converting to from 5:6:5 to 5:6:5 doesn't convert the color space but it is useful to change the `RgbFormat` or scale using  `colorTable`.


 or scalinis an available option, which is already TinyCLR's default format. This is because the overload of the function allows for swapping the order of the RGB channels. It also allows for the use of a custom color table created by the user. 

The 64 values in `colorTable` maps each RGB original colors (6bit max from 5:6:5) to a new scaled color (up to 8bit in 8:8:8). This is optional as `Convert` will be default simply shift 6 bit up into 8 bits. This is an example of `colorTable` with more ideal results

```cs
var ColorTable565To888 = new byte[64]{ 0,2,4,8,12,16,20,24,28,32,36,40,44,48,52,56,60,64,68,72,76,80,85,89,93,97,101,105,109,113,117,121,125,129,133,137,141,145,149,153,157,161,165,170,174,178,182,186,190,194,198,202,206,210,214,218,222,226,230,234,238,242,246,250 };
```

> [!TIP] 
> The custom color table option is only available in 5:6:5, 8:8:8, and 8:8:8:8 color spaces.

The `alpha` is only used with the 8:8:8:8 color space to set the alpha channel value, between 0(transparent) to 255(opaque).

### 1Bpp

The `ConvertTo1Bpp` function converts the internal 5:6:5 color space to 1BPP. ANy color will result in 1 and only black will result in 0.

```
ConvertTo1Bpp(byte[] inArray, byte[] outArray, uint width)
```
`width` is the pixel-width of the image that was used to create `inArray`. The `outArray` buffer size is = `inArray.Length` x 0.0625

By default, `ConvertTo1Bpp` groups each 8 pixels vertically, which is what most 1BPP display use. There is an overload that include `BitFormat` to change to horizontal if desired.

```
ConvertTo1Bpp(byte[] inArray, byte[] outArray, uint width, BitFormat bitFormat)
```


