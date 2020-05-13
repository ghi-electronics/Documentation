# External Memory
---
External memory is typically not secure as it can be probed by hackers. However, external memory provides a large amount of storage that is required for some applications.

## External RAM
Systems with external RAM have the option of utilizing this memory as [Unmanaged Heap](unmanaged-heap.md). Unmanaged heap is great for storing large amounts of data, but it is not considered secure. Bitmaps and large buffers are automatically stored in unmanaged heap.

Developers also have the option of extending core managed heap into unsecure external memory, in which case there is not longer any unmanaged heap space. This feature is a trade off between security and convenience -- it provides a large amount of heap space, but data is stored outside of the microcontroller chip where it's less secure.

```
GHIElectronics.TinyCLR.Native.Memory.ExtendHeap()
```

## External Flash
High speed QSPI flash is available through the system's internal drivers. This memory is being evaluated for security and is not yet available to the user.

Here is an example that directly writes, reads, and then compares data in external flash.

> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Devices.Storage

```
static void TestQSPI() {

    const int TOTAL_SIZE = 16 * 1024 * 1024; //Total size 16MB
    const int SECTOR_SIZE = 4 * 1024;        //Sector size 4KB

    var dataWrite = new byte[SECTOR_SIZE];
    var dataRead = new byte[SECTOR_SIZE];

    var dataToWrite = System.Text.UTF8Encoding.UTF8.GetBytes("This is a test");

    var storeController = GHIElectronics.TinyCLR.Devices.Storage.StorageController.FromName
        (GHIElectronics.TinyCLR.Pins.SC20260.StorageController.QuadSpi);

    var drive = storeController.Provider;

    drive.Open();

    for (var i = 0; i < SECTOR_SIZE; i += dataToWrite.Length) {
        System.Array.Copy(dataToWrite, 0, dataWrite, i, dataToWrite.Length);
    }

    var block = TOTAL_SIZE / SECTOR_SIZE;
    var index = 0 * SECTOR_SIZE;
    var countBlock = 0;

    while (block > 0) {
        // Erase
        drive.Erase(index, SECTOR_SIZE, System.TimeSpan.FromSeconds(100));

        // Write
        drive.Write(index, SECTOR_SIZE, dataWrite, 0, System.TimeSpan.FromSeconds(100));

        // Read
        drive.Read(index, SECTOR_SIZE, dataRead, 0, System.TimeSpan.FromSeconds(100));

        // Compare data after read
        for (var i = 0; i < SECTOR_SIZE; i++) {
            if (dataRead[i] != dataWrite[i]) {
                System.Diagnostics.Debug.WriteLine
                    ("Corrupted data detected at sector: " + block);
            }
        }

        countBlock++;
        block--;
        index += SECTOR_SIZE;
    }

    System.Diagnostics.Debug.WriteLine("Test all sectors passed");
}
```

