# Serialization
---
Serialization is the process of converting the state of an object into a form that can be persisted or transported. The complement of serialization is deserialization, which converts a stream into an object. Together, these processes allow data to be stored and transferred.

## Binary Serialization
Binary Serialization is a native, fast and lean way to serialize objects. To keep the serialized objects small and efficient, it is not compatible with the desktop's binary serialization. However, an implementation on the PC can be used to process the binary data if necessary.

```

```

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
