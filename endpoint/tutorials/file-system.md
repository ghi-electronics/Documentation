[IN PROGRESS](error.md) 
# File System
---
The file system library is a subset of the full .NET file system support. Most examples should work with only minor changes. The internal drivers fully support FAT16 or FAT32 file systems, with no limitations beyond the FAT file system itself!

> [!Note]
> The USB drive must have an MBR record, not a GPT table.
> FAT16 and FAT32 file systems are supported.

## Fat File System

### USB Mass Storage
This allows file access on USB devices with MSC class, such as USB memory sticks. See the [USB](usb.md) page.

### SD Card
SD and MMC cards are fully supported. Additionally, SPI SD drivers are also supported through the `ManagedFileSystem` software utility [Endpoint Config](../configuration.md) 

The example below requires the `GHIElectronics.TinyCLR.IO` and `GHIElectronics.TinyCLR.Devices.Storage` libraries and a device with an SD card.

```cs
var sd = StorageController.FromName(SC20100.StorageController.SdCard);
var drive = FileSystem.Mount(sd.Hdc);

//Show a list of files in the root directory
var directory = new DirectoryInfo(drive.Name);
var files = directory.GetFiles();

foreach (var f in files) {
    System.Diagnostics.Debug.WriteLine(f.Name);
}

//Create a text file and save it to the SD card.
var file = new FileStream($@"{drive.Name}Test.txt", FileMode.OpenOrCreate);
var bytes = Encoding.UTF8.GetBytes(DateTime.UtcNow.ToString() +
    Environment.NewLine);

file.Write(bytes, 0, bytes.Length);

file.Flush();

FileSystem.Flush(sd.Hdc);

```





### Low-level Access
You can access the raw underlying data of the storage provider by using the `Provider` property of the controller. Be careful when using this interface, however, as it bypasses any file system present and writes directly to the device. This is useful for implementing your own or otherwise unsupported file systems.

```cs
var controller = StorageController.FromName
        (SC20100.StorageController.SdCard);

controller.Provider.Open(); // open
controller.Provider.Read(address, buffer, 0, buffer.Length, TimeSpan.FromSeconds(5));
controller.Provider.Close(); // close

```

---

## Tiny File System (TFS)

Tiny File System(TFS) can be used to access any memory storage as a file system. All that is needed is a basic driver to Read, Write, and Erase these storages. 

Below is an example that uses the external flash through TFS.

> [!Note]
> This example requires the `GHIElectronics.TinyCLR.IO.TinyFileSystem`

```cs
const int CLUSTER_SIZE = 1024;

var tfs = new TinyFileSystem(new QspiMemory(), CLUSTER_SIZE);
            
if (!tfs.CheckIfFormatted()) {
    //Do Format if necessary 
    tfs.Format();
}
else {
    // Mount tiny file system
    tfs.Mount();
}

//Open to write
using (var fsWrite = tfs.Create("settings.dat")) {
    using (var wr = new StreamWriter(fsWrite)) {
        wr.WriteLine("This is TFS test");
        wr.Flush();
        fsWrite.Flush();
    }
}

//Open to read
using (var fsRead = tfs.Open("settings.dat", FileMode.Open)) {
    using (var rdr = new StreamReader(fsRead)) {
        System.String line;
        
        while ((line = rdr.ReadLine()) != null) {
                Debug.WriteLine(line);
        }
    }
}
```
Below is a basic driver implementation utilizing QSPI external flash. It automatically sets the size appropriately depending on whether the deployment is extended or not. It however gives you the option to fix the size to 2MB, as the remaining 8MB can optionally be used by [InField Update](in-field-update.md).

```cs
public sealed class QspiMemory : IStorageControllerProvider
{
    public StorageDescriptor Descriptor => this.descriptor;
    const int SectorSize = 4 * 1024;

    private StorageDescriptor descriptor = new StorageDescriptor()
    {
        CanReadDirect = false,
        CanWriteDirect = false,
        CanExecuteDirect = false,
        EraseBeforeWrite = true,
        Removable = true,
        RegionsContiguous = true,
        RegionsEqualSized = true,
        RegionAddresses = new long[] { 0 },
        RegionSizes = new int[] { SectorSize },
        RegionCount = (2 * 1024 * 1024) / (SectorSize)
    };

    private IStorageControllerProvider qspiDrive;

    public QspiMemory() : this(2 * 1024 * 1024)
    {

    }

    public QspiMemory(uint size)
    {
        var maxSize = Flash.IsEnabledExtendDeployment ? (10 * 1024 * 1024) : (16 * 1024 * 1024);

        if (size > maxSize)
            throw new ArgumentOutOfRangeException("size too large.");

        if (size <= SectorSize)
            throw new ArgumentOutOfRangeException("size too small.");

        if (size != descriptor.RegionCount * SectorSize)
        {
            descriptor.RegionCount = (int)(size / SectorSize);
        }

        qspiDrive = StorageController.FromName(SC20260.StorageController.QuadSpi).Provider;

        this.Open();
    }

    public void Open()
    {
        qspiDrive.Open();
    }

    public void Close()
    {
        qspiDrive.Close();
    }

    public void Dispose()
    {
        qspiDrive.Dispose();
    }

    public int Erase(long address, int count, TimeSpan timeout)
    {
        return qspiDrive.Erase(address, count, timeout);
    }

    public bool IsErased(long address, int count)
    {
        return qspiDrive.IsErased(address, count);
    }

    public int Read(long address, int count, byte[] buffer, int offset, TimeSpan timeout)
    {
        return qspiDrive.Read(address, count, buffer, offset, timeout);
    }

    public int Write(long address, int count, byte[] buffer, int offset, TimeSpan timeout)
    {
        return qspiDrive.Write(address, count, buffer, offset, timeout);
    }

    public void EraseAll(TimeSpan timeout)
    {
        for (var sector = 0; sector < this.Descriptor.RegionCount; sector++)
        {
            qspiDrive.Erase(sector * this.Descriptor.RegionSizes[0], this.Descriptor.RegionSizes[0], timeout);
        }
    }
}
```

 
