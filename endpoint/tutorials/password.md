# Password
---

## One Time Password

The library supports TOTP Time-based One-Time Password, which is a password that is only valid for a specific duration of time. And also HOPT Hash-based One-Time Password, which is made from a given token.

>[!Note] 
>As this is "time based", the server and client must have the proper time.

>[!TIP]
>Needed NuGet: GHIElectronics.TinyCLR.Drivers.OneTimePassword

```cs
var otp = new OneTimePassword("JBSWY3DPEHPK3PXP");

//TimeBased Password that is good for 2 days (48 hours*60minutes*60seconds)
var t = otp.Generate(DateTime.Now.Utc, TimeSpan.FromMilliseconds(172800*1000));

// Token Based password
var token = 123;
var t = otp.Generate(token);
```