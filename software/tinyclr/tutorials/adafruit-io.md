# Adafruit IO
---
The Adafruit cloud, Adafruit IO, is a cloud service primarily aimed at the maker market. While Adafruit IO is more limited than the major players in cloud services, it is very easy to use and there's a free option making this a great way to test IoT proofs of concept and prototypes.

To run the sample code on this page, you will need to create an Adafruit account and setup a dashboard with a gauge named "Temperature" and a toggle named "Digital." For the toggle, you will need to change the `Button On Text` to "1" and the `Button Off Text` to "0."

## Using HTML

Your IoT device can communicate with Adafruit IO using simple HTTP GET and POST commands. However, to respond to input on your Adafruit IO dashboard you must repeatedly execute HTTP GET requests to poll the input. If you would rather use event driven input from Adafruit IO, MQTT is a better choice than HTML.

The following code uses an HTTP POST request to send a value to an Adafruit IO feed named "Temperature" which is represented by a gauge on an Adafruit IO dashboard. It uses a secure connection, so you must have the Adafruit certificate loaded as a [resource](resources.md). There must be a working Internet connection for this code to work.

```cs
var url = "http://io.adafruit.com/api/feeds/temperature/data.json";

var postData = "{\"value\":\"20\"}"; //Sending a temperature of 20 degrees.

var byteArray = System.Text.Encoding.UTF8.GetBytes(postData);

var cert = Resources.GetBytes(Resources.BinaryResources.DigiCertGlobalRootG2);

certx509 = new X509Certificate[] { new X509Certificate(cert) };

int read = 0, total = 0;
byte[] result = new byte[512];

try {
    using (var postRequest = HttpWebRequest.Create(url) as HttpWebRequest) {
        postRequest.KeepAlive = false;
        postRequest.HttpsAuthentCerts = certx509;
        postRequest.ReadWriteTimeout = 2000;
        postRequest.Headers.Add("x-aio-key: your_adafruit_io_key_goes_here");
        postRequest.ContentType = "application/json";
        postRequest.Method = "POST";
        postRequest.ContentLength = byteArray.Length;

        System.IO.Stream dataStream = postRequest.GetRequestStream();
        dataStream.Write(byteArray, 0, byteArray.Length);
        dataStream.Close();

        using (var res = postRequest.GetResponse() as HttpWebResponse) {
            using (var stream = res.GetResponseStream()) {
                do {
                    read = stream.Read(result, 0, result.Length);
                    total += read;

                    System.Diagnostics.Debug.WriteLine("read : " + read);
                    System.Diagnostics.Debug.WriteLine("total : " + total);

                    String page = "";

                    page = new String(System.Text.Encoding.UTF8.GetChars
                        (result, 0, read));

                    System.Diagnostics.Debug.WriteLine("Response : " + page);
                }

                while (read != 0);
            }
        }
    }
}
catch {

}
```

You can use an HTTP GET request to read the status of an Adafruit IO feed. The following code reads that status of a toggle block called "Digital." You will need the rename the toggle's `Button On Text` to "1" and the `Button Off Text` to "0" on the Adafruit IO dashboard. There must be a working Internet connection for this code to work.

```cs
url = "https://io.adafruit.com/api/v2/adafruit_io_username/
    feeds/digital/data?include=value&limit=1";

var cert = Resources.GetBytes(Resources.BinaryResources.DigiCertGlobalRootG2);

certx509 = new X509Certificate[] { new X509Certificate(cert) };

using (var getRequest = HttpWebRequest.Create(url) as HttpWebRequest) {
    getRequest.KeepAlive = false;
    getRequest.HttpsAuthentCerts = certx509;
    getRequest.ReadWriteTimeout = 2000;
    getRequest.Headers.Add("x-aio-key: your_adafruit_io_key_goes_here");
    getRequest.Method = "GET";

    using (var response = getRequest.GetResponse() as HttpWebResponse){
        using (var stream = response.GetResponseStream()) {
            do {
                read = stream.Read(result, 0, result.Length);
                total += read;

                System.Diagnostics.Debug.WriteLine("read : " + read);
                System.Diagnostics.Debug.WriteLine("total : " + total);

                String page = "";

                page = new String(System.Text.Encoding.UTF8.GetChars
                    (result, 0, read));

                System.Diagnostics.Debug.WriteLine("Response : " + page);
            }
            while (read != 0);
        }
    }
}
```

## Using MQTT

MQTT is a simple messaging protocol that is widely supported. See our [MQTT page](mqtt.md) for more information. Using MQTT with Adafruit IO allows you to subscribe to an MQTT topic that represents a block on the Adafruit IO dashboard, allowing for event driven response.

This sample code connects to Adafruit IO using their MQTT API. It publishes a value to a gauge named "Temperature" on an Adafruit IO dashboard. It also subscribes to an Adafruit IO toggle named "Digital." You will need the rename the toggle's `Button On Text` to "1" and the `Button Off Text` to "0" on the Adafruit IO dashboard. It uses a secure connection, so you must have the Adafruit certificate loaded as a [resource](resources.md). You will also need a working Internet connection for this code to work.

```cs
var certx509 = new
    X509Certificate(Resources.GetBytes(Resources.BinaryResources.DigiCertGlobalRootG2));

var mqttHost = "io.adafruit.com";
var mqttPort = 8883; //Default SSL port is 8883, default insecure port is 1883.
var deviceId = "";
var username = "adafruit_io_username";
var password = "adafruit_io_key";
var topic = "adafruit_io_username/feeds/digital";

try {
    var clientSetting = new MqttClientSetting {
        BrokerName = mqttHost,
        BrokerPort = mqttPort,
        ClientCertificate = null,
        CaCertificate = certx509,
        SslProtocol = System.Security.Authentication.SslProtocols.Tls12,
    };

    var client = new Mqtt(clientSetting);

    var connectSetting = new MqttConnectionSetting {
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

    client.PublishReceivedChanged += Client_PublishReceivedChanged;

    // Publish a topic
    client.Publish("joelriley/feeds/temperature", Encoding.UTF8.GetBytes("0"),
        QoSLevel.MostOnce, false, (ushort)packetId); //Sets temperature to zero.
}

catch (Exception e) {

}

private static void Client_PublishReceivedChanged(object sender, MqttPacket packet) {
    if (packet.Data[0] == '1') //Toggle is set to '1'
    if (packet.Data[0] == '0') //Toggle is set to '0'
}

```