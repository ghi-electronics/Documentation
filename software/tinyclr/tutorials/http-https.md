# HTTP/HTTPS
---
Hyper Text Transport Protocol (HTTP) builds on top of the [Core Protocols](core-protocols.md) to provide a standard way to work with web servers.

```csharp
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

                        page = new String(System.Text.Encoding.UTF8.GetChars(result, 0, read));

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

Secure connections similarly work, through the built in [TLS](tls.md) support.

HTTPS can also be used to send data to a cloud, such as [Azure](azure.md).
