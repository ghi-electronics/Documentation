# Serialization
---
Serialization is the process of converting the state of an object into a form that can be persisted or transported. The complement of serialization is deserialization, which converts a stream into an object. Together, these processes allow objects to be stored and transferred.

## Binary Serialization
Binary Serialization is a native, fast and lean way to serialize objects. To keep serialization fast and efficient on embedded devices, TinyCLR's serialization is not compatible with binary serialization on desktop PCs. However, an implementation on the PC can be used to process the serialized binary data if necessary.

> [!TIP]
> Needed NuGets: GHIElectronics.TinyCLR.Core and System.Reflection.

```
class Program {
    public enum MyEnum : short { A, B, C };

    private static void Main() {
        MySerializableClass original = new MySerializableClass(1, "ABCD", 3, MyEnum.B, 0.1f);

        System.Diagnostics.Debug.WriteLine("original: " + original.ToString());

        byte[] buffer = System.Reflection.Reflection.Serialize(original,
            typeof(MySerializableClass));

        MySerializableClass restored = (MySerializableClass)System.Reflection.Reflection.
            Deserialize(buffer, typeof(MySerializableClass));

        System.Diagnostics.Debug.WriteLine("restored: " + restored.ToString());
        System.Diagnostics.Debug.WriteLine("Number of bytes: " + buffer.Length.ToString());
    }

    [System.Serializable]
    public class MySerializableClass {
        public int a;
        public string b;
        private byte c;
        private MyEnum d;
        private float e;
        private System.DateTime dt;

        public MySerializableClass(int a, string b, byte c, MyEnum d, float e) {
            this.a = a;
            this.b = b;
            this.c = c;
            this.d = d;
            this.e = e;
            this.dt = this.dt = new System.DateTime(2007, 1, 22);
        }

        public override string ToString() {
            return "a=" + a.ToString() + ", b=" + b + ", c=" + c.ToString() + ", d=" +
                ((object)d).ToString() + ", e=" + e.ToString("F2");
        }
    }
}
```

> [!NOTE]
> Serialization in TinyCLR OS is not compatible with full .NET. That means you cannot deserialize an object with .NET on a PC from a byte stream that was created with TinyCLR OS and vice versa. There is a solution which allows Serialization in TinyCLR OS and the .NET Framework to be compatible. For details, look at the BinarySerializationDesktopSample here: **https://github.com/Apress/exp-.net-micro-framework/tree/master/source/Chapter09/BinarySerializationDesktopSample**

>[!WARNING]
> GHI Electronics does not own or have rights to the code in this repository: https://github.com/Apress/exp-.net-micro-framework. It is your responsibility to adhere to the license provided by the owner of this code.

## JSON

TinyCLR OS includes a built in JSON library.

> [!TIP]
> Needed NuGets: GHIElectronics.TinyCLR.Core, GHIElectronics.TinyCLR.Data.Json.

```cs
class Program {
    private static void Main() {
        var intArray = new int[] { 1, 3, 5, 7, 9 };

        var result = GHIElectronics.TinyCLR.Data.Json.JsonConverter.Serialize(intArray);

        var bson = result.ToBson();

        var compare = (System.Array)GHIElectronics.TinyCLR.Data.Json.JsonConverter.
            FromBson(bson, typeof(int[]));

        for (var i = 0; i < intArray.Length; i++) {
            if (intArray[i] != (int)compare.GetValue(i)) {
                System.Diagnostics.Debug.WriteLine("Array test failed");

                break;
            }
        }

        System.Diagnostics.Debug.WriteLine("Array test succeeded");
    }
}
```
