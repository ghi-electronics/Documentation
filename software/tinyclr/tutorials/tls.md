# TLS
---

TLS is how the Internet securely works, for banks, airports and security systems. We support TLS 1.3, a global security standard. All encryption, decryption and certification are done a secure internal memory.

Below is simple example show to connect https://www.google.com 

>[!TIP]
>Need Nugets: GHIElectronics.TinyCLR.Devices.Network, GHIElectronics.TinyCLR.Networking.Http

```csharp
static void DoTestHttps()
{
    var url = "https://www.google.com";

    var certificates = Resources.GetBytes(Properties.Resources.BinaryResources.GlobalSign);

    X509Certificate[] certx509 = new X509Certificate[] { new X509Certificate(certificates) };

    int read = 0, total = 0;
    byte[] result = new byte[512];

    try
    {
        using (var req = HttpWebRequest.Create(url) as HttpWebRequest)
        {
            req.KeepAlive = false;
            req.HttpsAuthentCerts = certx509;
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

                        var page = new String(System.Text.Encoding.UTF8.GetChars(result, 0, read));

                        System.Diagnostics.Debug.WriteLine("Response : " + page);
                    }
                    while (read != 0);
                }
            }
        }

    }
    catch { }
            
}
```

You need a root certificate to access secure websites. TinyCLR OS accepts certificates in both text and binary formats. The following instructions show how to download certificates:

![How to dowload certificate](images/download_google_certificate.png)

