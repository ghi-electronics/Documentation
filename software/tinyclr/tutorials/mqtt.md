# MQTT
---

MQTT is a light weight messaging protocol for sensors that is supported by all major cloud services. See the following cloud provider pages for further details: [Azure](azure.md), [AWS](aws.md) and [Google Cloud](google-cloud.md).

The following is a simple example of MQTT:

>[!TIP]
>Needed Nugets: GHIElectronics.TinyCLR.Networking.Mqtt

```csharp
static void DoTestMqtt()
{
    var caCertificate = new X509Certificate(UTF8Encoding.UTF8.GetBytes("Your certificate"));

    var mqttHost = "your_host";
    var mqttPort = 8883; //default 8883
    var deviceId = "your_device_id";

    var username = "your_username";
    var password = "your_password";
    var topic = "your_topic";

    try
    {
        var clientSetting = new MqttClientSetting
        {
            BrokerName = mqttHost,
            BrokerPort = mqttPort,
            ClientCertificate = null,
            CaCertificate = caCertificate,
            SslProtocol = System.Security.Authentication.SslProtocols.Tls12
        };

        var client = new Mqtt(clientSetting);

        var connectSetting = new MqttConnectionSetting
        {
            ClientId = deviceId,
            UserName = username,
            Password = password
        };

        // Connect to host
        var returnCode = client.Connect(connectSetting);

        var packetId = 1;
                
        // Subscribe to a topic
        client.Subscribe(new string[] { topic }, new QoSLevel[] { QoSLevel.ExactlyOnce },
            (ushort)packetId++);

        // Publish a topic
        client.Publish(topic, Encoding.UTF8.GetBytes("your message"), QoSLevel.MostOnce,
            false, (ushort)packetId);
    }
    catch (Exception e) 
    { 

    }
}
```

>[!NOTE]
> The MQTT driver in TinyCLR OS supports client mode only.

# Event Handler

Mqtt driver provides five events:

```csharp
client.PublishReceivedChanged += (a,b) => { Debug.WriteLine("Publish Received Changed.");  };
client.PublishedChanged += (a, b, c) => { Debug.WriteLine("Published Changed."); }; ;
client.SubscribedChanged += (a, b) => { Debug.WriteLine("Subscribed Changed."); };
client.ConnectedChanged += (a) => { Debug.WriteLine("Connected Changed."); };
client.UnsubscribedChanged += (a, b) => { Debug.WriteLine("Unsubscribed Changed."); };
```

