# Encoding & Decoding
---
TinyCLR OS provides the following methods for converting data and handling strings.

## Encoding

The Encoding class is used to convert between strings, character arrays, and byte arrays. For example, to convert from a byte array to a string:

```cs
var string = System.Text.Encoding.UTF8.GetString(new byte[] { 65, 66, 67, 68, 69 });
//string = "ABCDE"
```

### Encoding Overloads

#### Convert From String to Byte Array

```cs
System.Text.Encoding.UTF8.GetBytes(string s)

//The following method returns an integer for the number of bytes converted.
//The resulting bytes are returned within the byte[] array.
System.Text.Encoding.UTF8.GetBytes(string s, int charIndex, int charCount, byte[] bytes,
    int byteIndex)
```

#### Convert From Byte Array to Character Array

```cs
System.Text.Encoding.UTF8.GetChars(byte[] bytes)
System.Text.Encoding.UTF8.GetChars(byte[] bytes, int byteIndex, int byteCount)
```

#### Convert From Byte Array to String

```cs
System.Text.Encoding.UTF8.GetString(byte[] bytes)
System.Text.Encoding.UTF8.GetString(byte[] bytes, int index, int count)
```

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


