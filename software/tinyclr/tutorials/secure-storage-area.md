# Secure Storage Area
---
An internal 128 Kbyte region of flash that can be used for non-volatile storage of data. If you lock your device, this region is also great for storing sensitive information like security certificates and serial numbers.

> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Core, GHIElectronics.TinyCLR.Devices.Storage, GHIElectronics.TinyCLR.Native

```
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
