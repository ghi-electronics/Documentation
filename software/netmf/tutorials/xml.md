# XML
---

##Introduction
Extensible Markup Language (XML) is a standard for containing data. When you want to transfer some info between two devices, you can set some rules on how the data is to be packed and sent from device A. On the other side, device B receives the data and knows how to unpack it. Before XML, this created some difficulties. What if you were sending the data to a system implemented by a different designer? You would have to explain how you packed your data so the other designer can unpack it. With XML, the design is transmitted with the data.

XML is extensively used. For example, when a website's shopping cart wants to know the shipping cost on a certain package, it will pack the shipment details in XML format and then send to FedEx. The FedEx website will read the info and send the cost info back in XML format as well.

The usefulness of XML can also be utilized in other ways. Let's say you are designing a data logger. Let's also assume the end users will need to configure the data logger to fit their needs. When a user configures the device, you need to store the info internally somehow. You can save the data with your own format which requires extra coding and debugging, or better just use XML. All GHI Electronics NETMF devices have a built-in XML reader and writer (packer and un-packer ).

Here is an example XML file that will help in our data logger design.

```
<?xml version="1.0" encoding="utf-8" ?>
<NETMF_DataLogger>
  <FileName>Data</FileName>
  <FileExt>txt</FileExt>
  <SampleFreq>10</SampleFreq>
</NETMF_DataLogger>
```

This XML example includes a root element and three child elements. XML is very flexible, for instance all info in the example could have been defined as root elements. The root element "NETMF_DataLogger" contains three pieces of info that are important for our logger. It contains the file name, the file extension and a frequency of our saved data. With this example, the logger will create a file called Data.txt and then will log data into that file 10 times every second.

Spaces and layout do not mean anything to XML, we (humans) need them to make things easier to read. The previous example can be stored without the spaces and layout like this.

```
<?xml version="1.0" encoding="utf-8" ?><NETMF_DataLogger><FileName>Data</FileName>
<FileExt>txt</FileExt><SampleFreq>10</SampleFreq></NETMF_DataLogger>
```

See why spaces are important to us human being! You can also add comments inside XML files, comments do not mean anything to XML but can help in manual reading of the files

```
<?xml version="1.0" encoding="utf-8"?>
<!--This is just a comment-->
<NETMF_DataLogger>
  <FileName>Data</FileName>
  <FileExt>txt</FileExt>
  <SampleFreq>10</SampleFreq>
</NETMF_DataLogger>
```

Finally, XML support attributes. An attribute is an extra info given to an element. Alternatively, you can add another element to describe the extra information. The choice is yours. Attributes are not explained in this document; there are many excellent tutorials and examples on the internet.

GHI Electronics' NETMF devices support reading and writing XML format. Reading and writing XML files work over streams which means any stream you already have or implement can work with XML. For example, we will use the built-in MemoryStream and FileStream.

 The examples shown below require the following assemblies: System.IO, System.Xml, MFDpwsExtensions.

## XML in Memory
This code shows how to make an XML document in memory, it implements the XML presented above.

```cs
using System.IO;
using System.Xml;
using System.Ext.Xml;
using Microsoft.SPOT;

public class Program
{
    public static void Main()
    {
        MemoryStream ms = new MemoryStream();

        XmlWriter xmlwrite = XmlWriter.Create(ms);

        xmlwrite.WriteProcessingInstruction("xml",
              "version=\"1.0\" encoding=\"utf-8\"");
        xmlwrite.WriteComment("This is just a comment");
        xmlwrite.WriteStartElement("NETMF_DataLogger");//root element
        xmlwrite.WriteStartElement("FileName");//child element
        xmlwrite.WriteString("Data");
        xmlwrite.WriteEndElement();
        xmlwrite.WriteStartElement("FileExt");
        xmlwrite.WriteString("txt");
        xmlwrite.WriteEndElement();
        xmlwrite.WriteStartElement("SampleFeq");
        xmlwrite.WriteString("10");
        xmlwrite.WriteEndElement();
        xmlwrite.WriteEndElement();//end the root element

        xmlwrite.Flush();
        xmlwrite.Close();
        //////// display the XML data ///////////
        byte[] byteArray = ms.ToArray();
        char[] cc = System.Text.UTF8Encoding.UTF8.GetChars(byteArray);
        string str = new string(cc);
        Debug.Print(str);
    }
}
```

When you try to add an assembly you will notice that there are two assemblies for XML, the "System.Xml" and "System.Xml.Legacy". Do not use the "legacy" driver, it is there for older NETMF devices with systems that did not have built-in support for XML.

If  the "Unsupported Exception" is raised on an older device, replace the System.Xml assembly with System.Xml.Legacy

## Readable Output
When running the example above, we will see the output XML data at the end. The data is correct but it is not formatted to be "human" friendly. Note that we are reading and writing XML files on a very small system so the less info (spaces/formatting) the better it is. So it is actually better not to have any extra spaces or formatting but for the sake of making things look pretty, we will add new lines as follows

```cs
using System.IO;
using System.Xml;
using System.Ext.Xml;
using Microsoft.SPOT;

public class Program
{
    public static void Main()
    {
        MemoryStream ms = new MemoryStream();

        XmlWriter xmlwrite = XmlWriter.Create(ms);

        xmlwrite.WriteProcessingInstruction("xml",
            "version=\"1.0\" encoding=\"utf-8\"");
        xmlwrite.WriteComment("This is just a comment");
        xmlwrite.WriteRaw("\r\n");
        xmlwrite.WriteStartElement("NETMF_DataLogger");//root element
        xmlwrite.WriteString("\r\n\t");
        xmlwrite.WriteStartElement("FileName");//child element
        xmlwrite.WriteString("Data");
        xmlwrite.WriteEndElement();
        xmlwrite.WriteRaw("\r\n\t");
        xmlwrite.WriteStartElement("FileExt");
        xmlwrite.WriteString("txt");
        xmlwrite.WriteEndElement();
        xmlwrite.WriteRaw("\r\n\t");
        xmlwrite.WriteStartElement("SampleFeq");
        xmlwrite.WriteString("10");
        xmlwrite.WriteEndElement();
        xmlwrite.WriteRaw("\r\n");
        xmlwrite.WriteEndElement();//end the root element

        xmlwrite.Flush();
        xmlwrite.Close();

        //////// display the XML data ///////////
        byte[] byteArray = ms.ToArray();
        char[] cc = System.Text.UTF8Encoding.UTF8.GetChars(byteArray);
        string str = new string(cc);
        Debug.Print(str);
    }
}
```

## Reading and Parsing
Creating XML files is actually easier than parsing (reading) them. There are many ways to read the XML file but basically you can just go through the file and read one piece at the time till you reach the end. This code example creates an XML data and it reads it back.

```cs
using System.IO;
using System.Xml;
using System.Ext.Xml;
using Microsoft.SPOT;
 
public class Program
{
    public static void Main()
    {
        MemoryStream ms = new MemoryStream();
 
        XmlWriter xmlwrite = XmlWriter.Create(ms);
 
        xmlwrite.WriteProcessingInstruction("xml", 
           "version=\"1.0\" encoding=\"utf-8\"");
        xmlwrite.WriteComment("This is just a comment");
        xmlwrite.WriteRaw("\r\n");
        xmlwrite.WriteStartElement("NETMF_DataLogger");//root element
        xmlwrite.WriteString("\r\n\t");
        xmlwrite.WriteStartElement("FileName");//child element
        xmlwrite.WriteString("Data");
        xmlwrite.WriteEndElement();
        xmlwrite.WriteRaw("\r\n\t");
        xmlwrite.WriteStartElement("FileExt");
        xmlwrite.WriteString("txt");
        xmlwrite.WriteEndElement();
        xmlwrite.WriteRaw("\r\n\t");
        xmlwrite.WriteStartElement("SampleFeq");
        xmlwrite.WriteString("10");
        xmlwrite.WriteEndElement();
        xmlwrite.WriteRaw("\r\n");
        xmlwrite.WriteEndElement();//end the root element
 
        xmlwrite.Flush();
        xmlwrite.Close();
 
        //////// display the XML data ///////////
        byte[] byteArray = ms.ToArray();
        char[] cc = System.Text.UTF8Encoding.UTF8.GetChars(byteArray);
        string str = new string(cc);
        Debug.Print(str);
 
        ///////////read xml
        MemoryStream rms = new MemoryStream(byteArray);
 
        XmlReaderSettings ss = new XmlReaderSettings();
        ss.IgnoreWhitespace = true;
        ss.IgnoreComments = false;
        //XmlException.XmlExceptionErrorCode.
        XmlReader xmlr = XmlReader.Create(rms,ss);
        while (!xmlr.EOF)
        {
            xmlr.Read();
            switch (xmlr.NodeType)
            {
                case XmlNodeType.Element:
                    Debug.Print("element: " + xmlr.Name);
                    break;
                case XmlNodeType.Text:
                    Debug.Print("text: " + xmlr.Value);
                    break;
                case XmlNodeType.XmlDeclaration:
                    Debug.Print("decl: " + xmlr.Name + ", " + xmlr.Value);
                    break;
                case XmlNodeType.Comment:
                    Debug.Print("comment " +xmlr.Value);
                    break;
                case XmlNodeType.EndElement:
                    Debug.Print("end element");
                    break;
                case XmlNodeType.Whitespace:
                    Debug.Print("white space");
                    break;
                case XmlNodeType.None:
                    Debug.Print("none");
                    break;
                default:
                    Debug.Print(xmlr.NodeType.ToString());
                    break;
            }
        }
    }
}
```