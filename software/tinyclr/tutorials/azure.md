# Microsoft Azure
---

The example below show how to use MQTT to send and receive messages from IoT Hub Azure

```csharp
static void DoTestAzureMqtt()
{
    var caCert = new X509Certificate(UTF8Encoding.UTF8.GetBytes("Add azure certificate here"));
            
    var iotHubName = "your IoT Hub name";
    var iotHubPort = 8883;

    // device/client information
    const string deviceId = "your device Id";

    var username = string.Format("{0}/{1}", iotHubName, deviceId);
    var password = "your password";

    // define topics
    var topicDeviceToServer = string.Format("devices/{0}/messages/events/", deviceId);
    var topicService2Device = string.Format("devices/{0}/messages/devicebound/#", deviceId);

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

        client.PublishReceivedChanged += (a, b) => { Debug.WriteLine("Received message: " + Encoding.UTF8.GetString(b.Data)); };
                
        var connectSetting = new MqttConnectionSetting
        {
            ClientId = deviceId,
            UserName = username,
            Password = password
        };

        var returnCode = client.Connect(connectSetting);

        ushort packetId = 1;

        client.Subscribe(new string[] { topicService2Device }, new QoSLevel[] { QoSLevel.ExactlyOnce }, packetId++);
        client.Subscribe(new string[] { topicDeviceToServer }, new QoSLevel[] { QoSLevel.ExactlyOnce }, packetId++);

        client.Publish(topicDeviceToServer, Encoding.UTF8.GetBytes("Your message"), QoSLevel.MostOnce, false, packetId++);
    }

    catch (Exception e)
    {
        throw;
    }
}
```
>[!NOTE]
> This example requires iotHubName, deviceId, and Password, which are available only when you register an Azure account.
> More detail about Microsoft Azure, please visit: https://azure.microsoft.com/en-us/
