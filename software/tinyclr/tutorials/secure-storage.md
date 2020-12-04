# Secure Storage
---
There are two secure storage areas you may find useful: the configuration storage area and the one-time programmable storage area.

## Configuration Storage
This 128 KByte secure storage area is organized as 4096 blocks of 32 bytes each. Configuration storage can be erased and modified. Performing an `erase all` in TinyCLR Config will wipe out this area. As this area is comprised of a single sector of flash memory, only the whole storage area can be erased. Partial erases are not possible.

> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Core, GHIElectronics.TinyCLR.Devices.SecureStorage

```cs
const uint STORAGE_SIZE = 32 * 1024;
var configStorage = new SecureStorageController(SecureStorage.Configuration);
var data = new byte[STORAGE_SIZE];

Debug.WriteLine("Configuration storage total size: " +
    configStorage.TotalSize.ToString() + " bytes.");

Debug.WriteLine("Configuration storage block size: " +
    configStorage.BlockSize.ToString() + " bytes.");

Debug.WriteLine("Checking if blank. . .");
var isBlank = true;

for (uint block = 0; block < configStorage.TotalSize / configStorage.BlockSize; block++) {
    if (!configStorage.IsBlank(block)) isBlank = false;
}

if (isBlank) {
    Debug.WriteLine("Configuration storage area is blank.");
}
else {
    Debug.WriteLine("Erasing entire configuration storage area...");
    configStorage.Erase();
}

Debug.WriteLine("Filling buffer...");

for (var i = 0; i < data.Length; i++) {
    data[i] = (byte)(i % 255);
}

Debug.WriteLine("Writing buffer...");
var dataBlock = new byte[configStorage.BlockSize];

for (uint block = 0; block < data.Length / configStorage.BlockSize; block++) {
    Array.Copy(data, (int)(block * configStorage.BlockSize), dataBlock, 0,
        (int)(configStorage.BlockSize));

    configStorage.Write(block, dataBlock);
}

Debug.WriteLine("Comparing buffer...");

for (uint block = 0; block < data.Length / configStorage.BlockSize; block++) {
    for (var byteIndex = 0; byteIndex < configStorage.BlockSize; byteIndex++) {
        configStorage.Read(block, dataBlock);

        if (data[block * configStorage.BlockSize + byteIndex] != dataBlock[byteIndex]) {
            Debug.WriteLine("Configuration storage data is corrupted!");
            Thread.Sleep(Timeout.Infinite);
        }
    }
}

Debug.WriteLine("Configuration storage is good to go!!!");
```

---

## One Time Programmable Area

> [!Note]
> If all 32 bytes of any OTP flash block contain 0xFF, the block is considered unused. If you write only 0xFF to the contents of a block, the block will be regarded as unused and you will be able to rewrite the block. 

The one time programmable (OTP) secure flash region is organized into 2048 blocks of 32 bytes each. Once you write to a block, that block can be read but never changed.

There is no way to modify written data. Erasing the entire device `Erase All` in TinyCLR Config will not erase or modify this area.

The API for OTP storage is the same as for the configuration storage area, except that instantiation takes a different argument and the `Erase` method is disabled.

OTP secure storage is instantiated as follows:

```cs
var otpStorage = new SecureStorageController(SecureStorage.Otp);
```
