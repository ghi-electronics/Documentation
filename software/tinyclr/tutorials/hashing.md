# Hashing
---
TinyCLR OS currently supports the very popular MD5 hash function. While MD5 is no longer used as a cryptographic hash function, it is still used as a checksum to guard against unintentional corruption of data. For example, our [Downloads](../downloads.md) page lists the MD5 hash value of each TinyCLR OS file. When you download one of these files, you can calculate the MD5 hash value of the downloaded file to make sure it matches the MD5 hash value we provide. This ensures the file was downloaded correctly and matches the original.

 The following commands will calculate the MD5 hash value of a byte array:

> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Core and GHIElectronics.TinyCLR.Cryptography

```cs
var md5 = GHIElectronics.TinyCLR.Cryptography.MD5.Create();
var hashValue = md5.ComputeHash(data); //data is a byte array.
```

There is also an overload of the `ComputeHash` method that takes an `offset` into the byte array and a `count` of how many bytes to process. 