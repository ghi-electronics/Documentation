# External Memory
---
External memories are typically not secures as they can be probed by hackers. However, external memories are large and required in some cases.

## External RAM
Systems with external ram have the option to utilize the memory as [Unmanaged Heap](unmanaged-heap.md) that uses in special cases only to keeps the system secure.

Developers have also the option to simply enable the external memory as a full heap. This feature is a trade off between security and convenience.

```
GHIElectronics.TinyCLR.Native.Memory.EnableExternalHeap()
```

## External Flash
High speed QSPI flash is available through the system's internal drivers. This memory is being evaluated for security and so not yet available to the user.

However, here is an example to directly write, read then compare data.

> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Devices.Storage

```
static void DoTestQSPI()
{

    const int TOTAL_SIZE = 16 * 1024 * 1024; // Total size 16MB
    const int SECTOR_SIZE = 4 * 1024;        // Sector size 4KB

    var dataWrite = new byte[SECTOR_SIZE];
    var dataRead = new byte[SECTOR_SIZE];

    var dataToWrite = System.Text.UTF8Encoding.UTF8.GetBytes("This is for test");

    var storeController = StorageController.FromName("GHIElectronics.TinyCLR.NativeApis.STM32H7.QspiStorageController\\0");

    var drive = storeController.Provider;

    drive.Open();

    for (var i = 0; i < SECTOR_SIZE; i += dataToWrite.Length) {
        Array.Copy(dataToWrite, 0, dataWrite, i, dataToWrite.Length);
    }

    var block = TOTAL_SIZE / SECTOR_SIZE;
    var index = 0 * SECTOR_SIZE;
    var countBlock = 0;

    while (block > 0)
    {
        // Erase
        drive.Erase(index, SECTOR_SIZE, TimeSpan.FromSeconds(100));

        // Write
        drive.Write(index, SECTOR_SIZE, dataWrite, 0, TimeSpan.FromSeconds(100));

        // Read
        drive.Read(index, SECTOR_SIZE, dataRead, 0, TimeSpan.FromSeconds(100));

        // Compare data after read
        for (var i = 0; i < SECTOR_SIZE; i++)
        {
            if (dataRead[i] != dataWrite[i])
            {                
                System.Diagnostics.Debug.WriteLine("Detect corupted data at sector: " + block);                
            }
        }

        countBlock++;
        block--;
        index += SECTOR_SIZE;
    }

    System.Diagnostics.Debug.WriteLine("Test all sectors passed");
}
```

