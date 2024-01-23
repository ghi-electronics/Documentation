[IN PROGRESS](error.md) 
# Serialization
---
Serialization is the process of converting the state of an object into a form that can be persisted or transported. The complement of serialization is deserialization, which converts a stream into an object. Together, these processes allow objects to be stored and transferred.

## Binary Serialization
Binary Serialization is a native, fast and lean way to serialize objects. To keep serialization fast and efficient on embedded devices, TinyCLR's serialization is not compatible with binary serialization on desktop PCs. However, an implementation on the PC can be used to process the serialized binary data if necessary.

> [!TIP]
> Needed NuGets: GHIElectronics.TinyCLR.Core and System.Reflection.

```cs
public enum MyEnum : short { A, B, C };

private static void Main() {
    MySerializableClass original = new MySerializableClass(1, "ABCD", 3, MyEnum.B, 0.1f);

    Debug.WriteLine("original: " + original.ToString());

    byte[] buffer = Reflection.Serialize(original,
        typeof(MySerializableClass));

    MySerializableClass restored = (MySerializableClass)Reflection.
        Deserialize(buffer, typeof(MySerializableClass));

    Debug.WriteLine("restored: " + restored.ToString());
    Debug.WriteLine("Number of bytes: " + buffer.Length.ToString());
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
```

> [!NOTE]
> Serialization in TinyCLR OS is not compatible with full .NET. That means you cannot deserialize an object with .NET on a PC from a byte stream that was created with TinyCLR OS and vice versa. There is a solution which allows Serialization in TinyCLR OS and the .NET Framework to be compatible. For details, look at the BinarySerializationDesktopSample here: **https://github.com/Apress/exp-.net-micro-framework/tree/master/source/Chapter09/BinarySerializationDesktopSample**

>[!WARNING]
> GHI Electronics does not own or have rights to the code in this repository: https://github.com/Apress/exp-.net-micro-framework. It is your responsibility to adhere to the license provided by the owner of this code.

---

## JSON

TinyCLR OS includes a built in JSON library.

> [!TIP]
> Needed NuGets: GHIElectronics.TinyCLR.Core, GHIElectronics.TinyCLR.Data.Json.

```cs
var intArray = new int[] { 1, 3, 5, 7, 9 };
var result = JsonConverter.Serialize(intArray);
var bson = result.ToBson();

var compare = (System.Array).Json.JsonConverter.
    FromBson(bson, typeof(int[]));

for (var i = 0; i < intArray.Length; i++) {
    if (intArray[i] != (int)compare.GetValue(i)) {
        Debug.WriteLine("Array test failed");
        break;
    }
}
Debug.WriteLine("Array test succeeded");
```

---

## XML
TinyCLR OS supports both the writing and reading of XML (eXtensible Markup Language) files through its XmlReader and XmlWriter classes. Full documentation of XML is beyond the scope of this document, but for more information Microsoft's [.NET XML documentation](https://docs.microsoft.com/en-us/dotnet/api/system.xml.xmldocument?view=netcore-3.1) is a good place to start. Please note that the TinyCLR implementation of XML is not fully .NET compatible, for example the asynchronous API is not supported.


> [!Note]
> XmlReader and XmlWriter both implement the IDisposable interface.

The following example shows the creation and reading of an XML file to and from a memory stream:
> [!TIP]
> Needed NuGets: GHIElectronics.TinyCLR.Core and GHIElectronics.TinyCLR.Data.Xml.

```cs
MemoryStream stream = new MemoryStream();

XmlWriter writer = XmlWriter.Create(stream);

writer.WriteProcessingInstruction("xml", "version=\"1.0\" encoding=\"utf-8\"");
writer.WriteComment("This is just a comment");
writer.WriteRaw("\r\n");
writer.WriteStartElement("NETMF_DataLogger"); //Root element
writer.WriteString("\r\n\t");
writer.WriteStartElement("FileName");         //Child element
writer.WriteString("Data");
writer.WriteEndElement();
writer.WriteRaw("\r\n\t");
writer.WriteStartElement("FileExt");
writer.WriteString("txt");
writer.WriteEndElement();
writer.WriteRaw("\r\n\t");
writer.WriteStartElement("SampleFeq");
writer.WriteString("10");
writer.WriteEndElement();
writer.WriteRaw("\r\n");
writer.WriteEndElement();                     //End of root element

writer.Flush();
writer.Close();

//Display the XML data.
byte[] byteArray = stream.ToArray();
char[] characterArray = UTF8Encoding.UTF8.GetChars(byteArray);
Debug.WriteLine(new string(characterArray) + "\r\n\r\n");
stream.Dispose();

//Read the XML data.
stream = new MemoryStream(byteArray);

XmlReaderSettings settings = new XmlReaderSettings();
settings.IgnoreWhitespace = true;
settings.IgnoreComments = false;

XmlReader reader = XmlReader.Create(stream, settings);

while (!reader.EOF) {
    reader.Read();

    switch (reader.NodeType) {
        case XmlNodeType.Element:
            Debug.WriteLine("Element: " + reader.Name);
            break;

        case XmlNodeType.Text:
            Debug.WriteLine("Text: " + reader.Value);
            break;

        case XmlNodeType.XmlDeclaration:
            Debug.WriteLine("Declaration: " + reader.Name + ", " + reader.Value);
            break;

        case XmlNodeType.Comment:
            Debug.WriteLine("Comment: " + reader.Value);
            break;

        case XmlNodeType.EndElement:
            Debug.WriteLine("End element");
            break;

        case XmlNodeType.Whitespace:
            Debug.WriteLine("White space");
            break;

        case XmlNodeType.None:
            Debug.WriteLine("None");
            break;

        default:
            Debug.WriteLine(reader.NodeType.ToString());
            break;
    }
}
```


