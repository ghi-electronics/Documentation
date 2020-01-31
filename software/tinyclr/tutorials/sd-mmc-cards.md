# SD/MMC Cards
---
The below example requires the `GHIElectronics.TinyCLR.IO` and `GHIElectronics.TinyCLR.Storage` libraries and a device with an SD card.

```cs
using GHIElectronics.TinyCLR.Devices.Storage;
using GHIElectronics.TinyCLR.IO;
using System;
using System.IO;
using System.Text;

namespace FileSystem {
    public class Program {
        private static void Main() {
            var sd = StorageController.FromName(@"GHIElectronics.TinyCLR.NativeApis.STM32H7.SdCardStorageController\0");
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