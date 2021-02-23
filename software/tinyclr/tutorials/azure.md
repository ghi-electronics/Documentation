# Microsoft Azure
---
This example shows how to communicate with Azure IoT Hub using MQTT. You'll also need to set up a Nework Interface connection on the device such as [WiFi](wifi.md) to Connect to Azure in your program.


>[!TIP]
>Needed NuGets: GHIElectronics.TinyCLR.Networking.Mqtt, GHIElectronics.TinyCLR.Drivers.Azure.SAS
>
>Add using statement:
> using System.Security.Cryptography.X509Certificates;
> using System.Security.Authentication;

```cs
var caCert = new X509Certificate("Need Azure certificate");

var iotHubName = "Your.azure-devices.net";
var iotHubPort = 8883;

// device/client information
const string deviceId = "your device id";

var username = string.Format("{0}/{1}", iotHubName, deviceId);

// Data time is important for calculate expire time
SystemTime.SetTime(new DateTime(2021, 2, 23));

var sas = new SharedAccessSignatureBuilder()
{
    Key = "your key",
    KeyName = "iothubowner",
    Target = "Your.azure-devices.net",
    TimeToLive = TimeSpan.FromDays(1) // at least 1 day.
};

// define topics
var topicDeviceToServer =
string.Format("devices/{0}/messages/events/", deviceId);

var topicService2Device =
string.Format("devices/{0}/messages/devicebound/#", deviceId);

try
{
    var clientSetting = new MqttClientSetting
    {
        BrokerName = iotHubName,
        BrokerPort = iotHubPort,
        ClientCertificate = null,
        CaCertificate = caCert,
        SslProtocol = System.Security.Authentication.SslProtocols.Tls12
    };

    var client = new Mqtt(clientSetting);

    client.PublishReceivedChanged += (p1, p2, p3, p4, p5, p6) => {
        Debug.WriteLine("Received message: " + Encoding.UTF8.GetString(p3));
    };

    var connectSetting = new MqttConnectionSetting
    {
        ClientId = deviceId,
        UserName = username,
        Password = sas.ToSignature()
    };

    var returnCode = client.Connect(connectSetting);

    if (returnCode != ConnectReturnCode.ConnectionAccepted)
        throw new Exception("Could not connect!");

    ushort packetId = 1;

    client.Subscribe(new string[] { topicService2Device }, new QoSLevel[]
        { QoSLevel.ExactlyOnce }, packetId++);

    client.Subscribe(new string[] { topicDeviceToServer }, new QoSLevel[]
        { QoSLevel.ExactlyOnce }, packetId++);

    client.Publish(topicDeviceToServer, Encoding.UTF8.GetBytes
        ("Your message"), QoSLevel.MostOnce, false, packetId++);
}
catch (Exception e)
{
    throw;
}
```

In the first line of code above, you need to add an Azure Certificate and place the certificate inside project resources and change the code to reflect the name of that certificate, in the example below the name is zura.

```cs
 var caCert = 
new X509Certificate(Resources.GetByte(Resources.BinaryResources.zura));
```

The example code also requires iotHubName and deviceId, which are available only when you open an Azure account. To create the iotHubName and deviceId you can follow these instructions found on their website.

[Create an IoT Hub & Device ID](https://docs.microsoft.com/en-us/azure/iot-hub/tutorial-connectivity)

We can also retrieve the Connection String for the newly created Device here too. We will use this key to generate a Shared Acccess Signature(SAS) which we will add to our code.

![Device Details](images/string.png)

Once we have the Connection String, there are several ways to generate an SAS:
## Azure IoT Explorer
Use [Azure IoT Explorer](https://docs.microsoft.com/en-us/azure/iot-pnp/howto-use-iot-explorer)

Paste the Connection String you obtained inside the Connection Information box, then click 'Update'. This will automatically generate the Key Name, Key Value and Target. You can select how many days the SAS you are generating will be good for. Finally click the 'Generate SAS' button. 

![Azure IoT Explorer](images/azure_explorer.jpg)
Copy the SAS text generated and set to variable 'password' in our code. As shown here:
```cs
var password = "SharedAccessSignature sr=yourDeviceId &sig=ddddddddddddQq3C13Q%3d&se=1633448319&skn=iothubowner";
```
>[!TIP]
>Values used above are for reference only and will not work in your code, you must create and generate your own connection string and SAS
>

## GHI SAS Nuget

```cs
// Data, time is important for calculate expire time.
SystemTime.SetTime(new DateTime(2021, 2, 23));

var sas = new SharedAccessSignatureBuilder()
{
    Key = "your key",
    KeyName = "iothubowner",
    Target = "Your.azure-devices.net",
    TimeToLive = TimeSpan.FromDays(1) // at least 1 day.
};

var password = sas.ToSignature();
```

Now we can send and receive data to our IoT device from the Azure IoT Explorer and see the results in the output window of Visual Studio and Azure IoT Explorer. To receive data from your IoT device, add a message to send in this line of the code.

```cs
client.Publish(topicDeviceToServer, Encoding.UTF8.GetBytes
("Your message"), QoSLevel.MostOnce, false, packetId++);
```
Select the 'Data' Tab in the Azure IoT Explorer program and push the 'Monitor' button.
Deploy the program or reset the device it will automatically send "Your message" to the Azure IoT Explorer. 

![Message Sent](images/azure_message_recieved.jpg)

To send a message from Azure to your IoT device, select the 'Messages To Device' tab in Azure IoT Explorer. Type your message in the Message Box and hit 'Send'. 

![Message Recieved](images/azure_message_sent.jpg)

Your message will appear in the 'Output' window of Visual Studio.

![VS Output Window](images/vs_output.jpg) 
