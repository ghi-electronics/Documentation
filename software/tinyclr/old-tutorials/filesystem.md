# File System
---
The file system library can be used to read and write files. FAT16 and FAT32 are supported.

## USB Mass Storage
This allows file access on USB devices with MSC class, such as USB memory sticks. The support for USB drives is still not publicly available.

## SD Card
The below example requires the `GHIElectronics.TinyCLR.IO` and `GHIElectronics.TinyCLR.Storage` libraries and a device with an SD card.

```csharp
using GHIElectronics.TinyCLR.Devices.Storage;
using GHIElectronics.TinyCLR.IO;
using System;
using System.IO;
using System.Text;

namespace FileSystem {
    public class Program {
        private static void Main() {
            var sd = StorageController.FromName(@"GHIElectronics.TinyCLR.NativeApis.STM32F4.SdCardStorageController\0");
            var drive = FileSystem.Mount(sd.Hdc);

            var file = new FileStream($@"{drive.Name}Test.txt", FileMode.OpenOrCreate);
            var bytes = Encoding.UTF8.GetBytes(DateTime.UtcNow.ToString() + Environment.NewLine);

            file.Write(bytes, 0, bytes.Length);

            file.Flush();

            FileSystem.Flush(sd.Hdc);
        }
    }
}

```

## Low-level Access
You can access the raw underlying data of the storage provider using the `Provider` property of the controller. Be careful when using this interface, however, as it bypasses any file system present and writes directly to the device. This is useful for implementing your own or otherwise unsupported file systems.

```csharp
var controller = StorageController.FromName(@"GHIElectronics.TinyCLR.NativeApis.STM32F4.SdCardStorageController\0");
controller.Provider.Read(address, buffer, 0, buffer.Length, -1);
```