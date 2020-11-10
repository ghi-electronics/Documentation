# Hashing
---
## MD5


TinyCLR OS currently supports the very popular MD5 hash function. While MD5 is no longer used as a cryptographic hash function, it is still used as a checksum to guard against unintentional corruption of data. For example, our [Downloads](../downloads.md) page lists the MD5 hash value of each TinyCLR OS file. When you download one of these files, you can calculate the MD5 hash value of the downloaded file to make sure it matches the MD5 hash value we provide. This ensures the file was downloaded correctly and matches the original.

 The following commands will calculate the MD5 hash value of a byte array:

> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Core and GHIElectronics.TinyCLR.Cryptography

```cs
var md5 = GHIElectronics.TinyCLR.Cryptography.MD5.Create();
var hashValue = md5.ComputeHash(data); //data is a byte array.
```

There is also an overload of the `ComputeHash` method that takes an `offset` into the byte array and a `count` of how many bytes to process. 

## CRC16
TinyCLR OS also supports CRC16. Data can be read in its entirety for small amounts of data. Large amounts of data can be read in chunks and the hash is concatenated. 

```cs
ComputeHash(byte[] data, int offset, int count);
```

The parameter `offset` tells us where to begin in the array, while the parameter `count` tells us where to stop in the array.  

Calling `Reset` resets the seed value. If we don't reset the seed value, every time we call `ComputeHash` we will be adding to the hash from previous `ComputeHash` calls. 

In the example below the first `crcVal1` and `crcVal2` will match.

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
           
Debug.WriteLine(crcVal1 == crcVal2 ? "crc matches" : "crc doesn't match");

Thread.Sleep(Timeout.Infinite);
```