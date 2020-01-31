# Encoding & Decoding
---
There are two built in libraries to help in encoding data, bit converter and string handling.

## BitConverter
The BitConverter class is used to convert from one data type to another. For example, to convert an integer into a byte array:

```cs
var byteArray = BitConverter.GetBytes(23);
//byteArray[0] = 23, byteArray[1] = 0, byteArray[2] = 0, byteArray[3] = 0

byteArray = BitConverter.GetBytes(65536);
//byteArray[0] = 0, byteArray[1] = 0, byteArray[2] = 1, byteArray[3] = 0
```

### BitConverter Overloads

#### Convert to a Byte Array

```cs
BitConverter.GetBytes(char value)
BitConverter.GetBytes(double value)
BitConverter.GetBytes(float value)
BitConverter.GetBytes(int value)
BitConverter.GetBytes(long value)
BitConverter.GetBytes(short value)
BitConverter.GetBytes(uint value)
BitConverter.GetBytes(ulong value)
BitConverter.GetBytes(ushort value)
BitConverter.GetBytes(bool value)
```

#### Convert from a Byte Array

```cs
BitConverter.ToBoolean(byte[] value, int startIndex)
BitConverter.ToChar(byte[] value, int startIndex)
BitConverter.ToDouble(byte[] value, int startIndex)
BitConverter.ToInt16(byte[] value, int startIndex)
BitConverter.ToInt32(byte[] value, int startIndex)
BitConverter.ToInt64(byte[] value, int startIndex)
BitConverter.ToSingle(byte[] value, int startIndex)
BitConverter.ToString(byte[] value)
BitConverter.ToString(byte[] value, int startIndex)
BitConverter.ToString(byte[] value, int startIndex, int length)
BitConverter.ToUInt16(byte[] value, int startIndex)
BitConverter.ToUInt32(byte[] value, int startIndex)
BitConverter.ToUInt64(byte[] value, int startIndex)
```

#### Convert Between Double and Long

```cs
BitConverter.DoubleToInt64Bits(double value)
BitConverter.Int64BitsToDouble(long value)
```

#### Swap Endianness

```cs
BitConverter.SwapEndianness(byte[] data, int groupSize)
```
