# HTTP/HTTPS
---
Hyper Text Transport Protocol (HTTP) builds on top of the [Core Protocols](core-protocols.md) to provide a standard way to work with web servers.

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

Secure connections work in a similar way through built in [TLS](tls.md) support.

HTTPS can also be used to send data to the cloud computing services such as [Azure](azure.md).
