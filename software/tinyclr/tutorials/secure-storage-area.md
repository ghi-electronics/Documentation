# Secure Storage Area
---
There are two secure storage areas you may find helpful. There is an internal 128 Kbyte region of flash that can be used for non-volatile storage of data. If you lock your device, this region is also great for storing sensitive information like security certificates and serial numbers.

There is also an internal 64 Kbyte one time programmable (OTP) region of memory that is organized into 32 byte blocks. Once you write to one of these blocks, it can never be changed or erased.

## 128 Kbyte Secure Storage Area
> [!Tip]
> The 128 Kbyte secure storage area is only erased when a device erase is performed by executing the `E` command in [**bootloader**](../bootloader.md) mode.

> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Core, GHIElectronics.TinyCLR.Devices.Storage, GHIElectronics.TinyCLR.Native

```cs
using GHIElectronics.TinyCLR.Devices.Storage;
using System;
using System.Diagnostics;
using System.Threading;

class Program {
    private static void Main() {
        const uint STORAGE_SIZE = 128 * 1024;

        var data = new byte[STORAGE_SIZE];

        var realStorageSize = Configuration.Size;

        bool isErased = Configuration.IsErased(0, realStorageSize);

        if (isErased == false) {
            Debug.WriteLine("Configuration is not empty");

            Debug.WriteLine("Erasing...");

            bool erased = Configuration.Erase(0, realStorageSize);

            Debug.WriteLine("Erased ? " + erased);
        }


        Debug.WriteLine("Fill buffer....");

        for (var i = 0; i < data.Length; i++) {
            data[i] = (byte)(i % 255);
        }

        Debug.WriteLine("Writing buffer....");

        Configuration.Write(data, 0, 0, (uint)data.Length);

        Debug.WriteLine("Clear buffer....");

        Array.Clear(data, 0, data.Length);

        Debug.WriteLine("Read configuration....");

        Configuration.Read(data, 0, 0, realStorageSize);

        Debug.WriteLine("Compare buffer....");

        for (var i = 0; i < data.Length; i++) {
            if (data[i] != (byte)(i % 255)) {
                Debug.WriteLine("Configuration corrupted");

                Thread.Sleep(-1);
            }
        }

        Debug.WriteLine("The Configuration driver is good to go!!!!");

        Thread.Sleep(-1);
    }
}
```

## 64 Kbyte OTP Secure Storage Area
The one time programmable (OTP) secure flash region is organized into 2048 blocks of 32 bytes each. Once you write to a block, that block can be read but never changed. 

The static GHIElectronics.TinyCLR.Native.Flash class has methods to read and write OTP flash blocks and also to see if blocks are blank.

### Writing an OTP Block
To write a block of 32 bytes to the OTP region of flash memory, use the following command:
```
GHIElectronics.TinyCLR.Native.Flash.OtpWrite(uint blockIndex, byte[] data);
```

The byte array of data must be exactly 32 bytes in length or an `ArgumentOutOfRangeException` will be thrown.

### Reading an OTP Block

To read a block from the OTP region of flash memory, use the following command:
```
GHIElectronics.TinyCLR.Native.Flash.OtpRead(uint blockIndex, byte[] data);
```
A byte array 32 bytes long will be returned.

### Checking if an OTP Block is Blank
> [!Note]
> If all 32 bytes of any OTP flash block are equal to 0xFF, the block is considered unused. If you write only 0xFF to the contents of a block, the block will be regarded as unused. Depending on the data you are saving, you may want to reserve one byte in the block as a write indicator, by writing anything other than 0xFF to that byte when the block is written.

To see if a block is blank:
```
GHIElectronics.TinyCLR.Native.Flash.OtpIsBlank(uint blockIndex);
```
Returns a boolean value that is true if the block is blank.