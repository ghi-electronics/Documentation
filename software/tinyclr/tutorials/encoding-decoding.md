# Encoding & Decoding
---
There are two built in libraries to help in encoding data, bit converter and string handling.

## BitConverter
The BitConverter class is used to convert from one data type to another. For example, to convert an integer into a byte array:

```cs
var byteArray = System.BitConverter.GetBytes(23);
//byteArray[0] = 23, byteArray[1] = 0, byteArray[2] = 0, byteArray[3] = 0

byteArray = System.BitConverter.GetBytes(65536);
//byteArray[0] = 0, byteArray[1] = 0, byteArray[2] = 1, byteArray[3] = 0
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
System.BitConverter.ToBoolean(byte[] value, int startIndex)
System.BitConverter.ToChar(byte[] value, int startIndex)
System.BitConverter.ToDouble(byte[] value, int startIndex)
System.BitConverter.ToInt16(byte[] value, int startIndex)
System.BitConverter.ToInt32(byte[] value, int startIndex)
System.BitConverter.ToInt64(byte[] value, int startIndex)
System.BitConverter.ToSingle(byte[] value, int startIndex)
System.BitConverter.ToString(byte[] value)
System.BitConverter.ToString(byte[] value, int startIndex)
System.BitConverter.ToString(byte[] value, int startIndex, int length)
System.BitConverter.ToUInt16(byte[] value, int startIndex)
System.BitConverter.ToUInt32(byte[] value, int startIndex)
System.BitConverter.ToUInt64(byte[] value, int startIndex)
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

System.Diagnostics.Debug.WriteLine(sb.ToString()); //Will output "0123456789"
```


