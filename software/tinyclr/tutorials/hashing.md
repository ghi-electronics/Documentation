# Hashing
---
> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Core and GHIElectronics.TinyCLR.Cryptography

## MD5
TinyCLR OS supports MD5 hash function.

 The following commands will calculate the MD5 hash value of a byte array:

> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Core and GHIElectronics.TinyCLR.Cryptography

```cs
var md5 = GHIElectronics.TinyCLR.Cryptography.MD5.Create();
var hashValue = md5.ComputeHash(data); //data is a byte array.
```
---

## CRC16
TinyCLR OS supports CRC16.

```cs
ComputeHash(byte[] data, int offset, int count);
```

Large amounts of data can be calculated in chunks and the hash is concatenated automatically. 

```cs
var crc16 = new Crc16();
var data = new byte[] { 1, 2, 3, 4, 5, 6, 7, 8 };
            
// Uses entire array to build the hash
var crcVal1 = crc16.ComputeHash(data, 0, data.Length);

// Uses chunks of the array to build the hash
var crc1 = crc16.ComputeHash(data, 0, 3);

var crc1_2 = crc16.ComputeHash(data, 3, 1, crc1);         

```
---

## SHA1
SHA-1 is most often used to verify that a file has been unaltered. This is done by producing a checksum before the file has been transmitted, and then again once it reaches its destination.

```cs
var data = new byte[] { 1, 2, 3, 4, 5 };
var sha1 = SHA1.Create();

var result = sha1.ComputeHash(data);
```

---

## HMAC-SHA1
HMACSHA1 is a type of keyed hash algorithm that is constructed from the SHA1 hash function and used as an HMAC, or hash-based message authentication code.

```cs
var data = new byte[] { 1, 2, 3, 4, 5 };
var hmacSha1 = new HMACSHA1();

var result = hmacSha1.ComputeHash(data);
```
---

## HMAC-SHA256
HMAC-SHA256 offers better security than standard SHA256. It is also required for SAS(Shared Access Signature), needed for [Microsoft Azure](azure.md).

```cs
var key = new byte[] { 1, 2, 3, 4, 5, 6 };
var hmacSha256 = new HMACSHA256(key);

var message = "this is for test";
var result = hmacSha256.ComputeHash(System.Text.UTF8Encoding.UTF8.GetBytes(message));
```


