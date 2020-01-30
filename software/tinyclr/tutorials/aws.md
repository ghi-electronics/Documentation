# Amazon Web Services
---
This example shows how to communicate with AWS.

>[!TIP]
>Needed Nugets: GHIElectronics.TinyCLR.Networking.Mqtt

```csharp
static void DoTestAwsMqtt()
{
    var iotArnString = "Need your ARN string";
    var iotPort = 8883;
    var deviceId = "Need your Device ID";

    var topicShadowUpdate = string.Format("$aws/things/{0}/shadow/update", deviceId);
    var topicShadowGet = string.Format("$aws/things/{0}/shadow/get", deviceId);

    var message = "{\"state\":{\"desired\":{\"My message\":\"From my test \"}}}";

    var caCertSource = UTF8Encoding.UTF8.GetBytes("Need AWS root CA certificate");
    var clientCertSource = UTF8Encoding.UTF8.GetBytes("Need your AWS client CA certificate");
    var privateKeyData = UTF8Encoding.UTF8.GetBytes("Need your AWS private key");

    X509Certificate CaCert = new X509Certificate(caCertSource);
    X509Certificate ClientCert = new X509Certificate(clientCertSource);

    ClientCert.PrivateKey = privateKeyData;    

    var clientSetting = new MqttClientSetting
    {
        BrokerName = iotArnString,
        BrokerPort = iotPort,
        CaCertificate = CaCert,
        ClientCertificate = ClientCert,
        SslProtocol = System.Security.Authentication.SslProtocols.Tls12
    };

    var iotClient = new Mqtt(clientSetting);

    iotClient.PublishReceivedChanged += (a, b) => { Debug.WriteLine
        ("Received message: " + Encoding.UTF8.GetString(b.Data)); };

    iotClient.SubscribedChanged += (a, b) => { Debug.WriteLine("Subscribed"); };

    var connectSetting = new MqttConnectionSetting
    {
        ClientId = deviceId,
        UserName = null,
        Password = null
    };

    var connectCode = iotClient.Connect(connectSetting);

    ushort packetId = 1;

    iotClient.Subscribe(new string[] { topicShadowGet }, new QoSLevel[]
        { QoSLevel.LeastOnce }, packetId++);
            
    iotClient.Publish(topicShadowUpdate, Encoding.UTF8.GetBytes(message),
        QoSLevel.MostOnce, false, packetId++);
}
```
This example requires iotArnString, deviceId, CA certificate, client certificates, and a private key, which are available when you register an AWS account.

Check out the AWS tutorial at: https://aws.amazon.com/
