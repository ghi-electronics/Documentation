# HTTP/HTTPS
---
Hyper Text Transport Protocol (HTTP) builds on top of the [Core Protocols](core-protocols.md) to provide a standard way to work with web servers.

### HTTP Client

>[!TIP]
>Needed Nugets: GHIElectronics.TinyCLR.Devices.Network, GHIElectronics.TinyCLR.Networking.Http

```cs
static void DoTestHttp()
{
    var url = "http://www.bing.com/robots.txt";

    int read = 0, total = 0;
    byte[] result = new byte[512];

    try
    {
        using (var req = HttpWebRequest.Create(url) as HttpWebRequest)
        {
            req.KeepAlive = false;                    
            req.ReadWriteTimeout = 2000;

            using (var res = req.GetResponse() as HttpWebResponse)
            {
                using (var stream = res.GetResponseStream())
                {
                    do
                    {
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
    catch
    {
                
    }
}

```

### HTTP Server

TinyCLR OS also provides HttpListener class which needs for Http Server as well. 

```cs
static void DoTestHttpServer()
{            
    // Create a listener.
    HttpListener listener = new HttpListener("http", 80);
    
    listener.Start();
    Debug.WriteLine("Listening...");

    var clientRequestCount = 0;
    
    // Note: The GetContext method blocks while waiting for a request. 
    while (true)
    {
        HttpListenerContext context = listener.GetContext();

        // Obtain a response object.
        HttpListenerResponse response = context.Response;
        
        // Construct a response.                
        var responseString = string.Format("<HTML><BODY> I am TinyCLR OS Server. Client request count: {0}</BODY></HTML>", ++clientRequestCount);                
        
        byte[] buffer = System.Text.Encoding.UTF8.GetBytes(responseString);
        
        // Get a response stream and write the response to it.
        response.ContentLength64 = buffer.Length;
        var output = response.OutputStream;

        output.Write(buffer, 0, buffer.Length);
        
        // You must close the output stream.
        output.Close();
    }

    listener.Stop();
}
```

From your client devices (smartphone, PC...), enter server ip address into the web browse. Our case 192.168.1.6. The response will be shown as below:

![ ](images/http-server.png)

> [!Tip]
> To run this example, client and server devices must connect to same local network.

Secure connections work in a similar way through built in [TLS](tls.md) support.

HTTPS can also be used to send data to cloud computing services such as [Azure](azure.md).
