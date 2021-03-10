# Hashing
---
## MD5
TinyCLR OS supports MD5 hash function.

 The following commands will calculate the MD5 hash value of a byte array:

> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Core and GHIElectronics.TinyCLR.Cryptography

```cs
var md5 = GHIElectronics.TinyCLR.Cryptography.MD5.Create();
var hashValue = md5.ComputeHash(data); //data is a byte array.
```

## CRC16
TinyCLR OS supports CRC16.

```cs
ComputeHash(byte[] data, int offset, int count);
```

Large amounts of data can be calculated in chunks and the hash is concatenated automatically. Calling `Reset` resets the seed value.

```cs
var crc16 = new Crc16();
var data = new byte[] { 1, 2, 3, 4, 5, 6, 7, 8 };
            
// Uses entire array to build the hash
crc16.Reset(); // reset seed = 0;
var crcVal1 = crc16.ComputeHash(data, 0, data.Length);

// Uses chunks of the array to build the hash
crc16.Reset(); // reset seed = 0;
var crcSeed1 = crc16.ComputeHash(data, 0, 3);
var crcSeed2 = crc16.ComputeHash(data, 3, 1);         
var crcVal2 = crc16.ComputeHash(data, 4, 4); 

// `crcVal1` and `crcVal2` will match.
```

## HMAC-SHA256
HMAC-SHA256 offers better security than standard SHA, and is utilized inside the SAS(Shared Access Signature) NuGet, used by [Microsoft Azure](azure.md)

```cs
var key = new byte[] { 1, 2, 3, 4, 5, 6 };
var message = "this is for test";
var hash = new HMACSHA256(key);
var result = hash.ComputeHash(System.Text.UTF8Encoding.UTF8.GetBytes(message));
```

