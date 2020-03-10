# Serialization
---
Serialization is the process of converting the state of an object into a form that can be persisted or transported. The complement of serialization is deserialization, which converts a stream into an object. Together, these processes allow data to be stored and transferred.

## Binary Serialization
Binary Serialization is a native, fast and lean way to serialize objects. To keep the serialized objects small and efficient, it is not compatible with the desktop's binary serialization. However, an implementation on the PC can be used to process the binary data if necessary.

> [!TIP]
> Needed NuGet: System.Reflection

```
static void DoTestSerialization()
{

    MySerializableClass original = new MySerializableClass(1, "ABCD", 3, MyEnum.B, 0.1f);
    
    Debug.WriteLine("original: " + original.ToString());
    
    byte[] buffer = Reflection.Serialize(original, typeof(MySerializableClass));
    
    MySerializableClass restored = (MySerializableClass)Reflection.Deserialize(buffer, typeof(MySerializableClass));
    
    Debug.WriteLine("restored: " + restored.ToString());
    Debug.WriteLine("Number of bytes: " + buffer.Length.ToString());
}
```

Here is which is used for the example above:

```
public enum MyEnum : short { A, B, C };

[Serializable]
public class MySerializableClass
{
    public int a;
    public string b;
    private byte c;
    private MyEnum d;
    private float e;
    private DateTime dt;

    public MySerializableClass(int a, string b, byte c, MyEnum d, float e)
    {
        this.a = a;
        this.b = b;
        this.c = c;
        this.d = d;
        this.e = e;
        this.dt = this.dt = new DateTime(2007, 1, 22);
    }

    public override string ToString()
    {
        return "a=" + a.ToString() + ", b=" + b + ", c=" + c.ToString() + ", d=" + ((object)d).ToString() +
               ", e=" + e.ToString("F2");
    }
}
```
> [!NOTE]
> Serialization on TinyCLR OS is not compatible with the full .NET Framework. That means you cannot deserialize an object with the full .NET Framework from a byte stream that was created with the TinyCLR OS and vice versa. But there is a solution which will allow Serialization on TinyCLR OS and .NET Framework are compatible each other. For detail, look at at example BinarySerializationdesktopSample from the link below: https://github.com/Apress/exp-.net-micro-framework/tree/master/source/Chapter09/BinarySerializationDesktopSample

>[!WARNING]
> By using https://github.com/Apress/exp-.net-micro-framework/tree/master/source/Chapter09/BinarySerializationDesktopSample, which is not owned by GHI Electronics, you may need to contact author for license.

## JSON

TinyCLR OS includes a built in JSON library.

> [!TIP]
> Needed NuGet: GHIElectronics.TinyCLR.Data.Json

```cs
static void DoTestSerialize()
{
    var intArray = new int[] { 1, 3, 5, 7, 9 };

    var result = JsonConverter.Serialize(intArray);

    var bson = result.ToBson();

    var compare = (Array)JsonConverter.FromBson(bson, typeof(int[]));

    for (var i = 0; i < intArray.Length; i++)
    {
        if (intArray[i] != (int)compare.GetValue(i))
        {
            Debug.WriteLine("Array test failed");

            break;
        }
    }

    Debug.WriteLine("Array test succeeded");
}
```
