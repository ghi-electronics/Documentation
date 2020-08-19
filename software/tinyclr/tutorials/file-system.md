# File System
---
The file system library is subset of the full .NET file system support. Most example should work with without minor changes. The internal drivers fully support FAT16 or FAT32 file systems, with no limitations beyond the FAT file system itself!

## USB Mass Storage
This allows file access on USB devices with MSC class, such as USB memory sticks. See the [USB](usb.md) page.

## SD Card
SD and MMC cards are fully supported as detailed on the [SD tutorial](sd-cards.md) page.

The example below requires the `GHIElectronics.TinyCLR.IO` and `GHIElectronics.TinyCLR.Devices.Storage` libraries and a device with an SD card.

> [!Note]
> Make sure the namespace statement in the following code is changed to match the namespace of your project.

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

## Low-level Access
You can access the raw underlying data of the storage provider by using the `Provider` property of the controller. Be careful when using this interface, however, as it bypasses any file system present and writes directly to the device. This is useful for implementing your own or otherwise unsupported file systems.

```cs
var controller = StorageController.FromName
        (SC20100.StorageController.SdCard);

controller.Provider.Read(address, buffer, 0, buffer.Length, -1);
```

# Tiny File System (TFS)

While TinyCLR OS fully supports SD cards and USB thumb drives through native File System(FS) which is fast and standard, it also provides a Tiny File System(TFS) to access any memory storage as a file system. TFS is managed code, slower than FS, but works with any storage. All we need is, to provide a basic driver to Read, Write, and Erase these storages.
Below is an example to that uses 16MB of builtin QSPI as file system.

> [!Note]
> This example requires the `GHIElectronics.TinyCLR.IO.TinyFileSystem`

```
static void DoTestTFS()
{
    var _tfs = new TinyFileSystem(new QspiMemory());           

    if (_tfs.CheckIfFormatted())
    {
        Debug.WriteLine("Filesystem OK. Mounting...n.");
        _tfs.Mount();
        Debug.WriteLine("Mounted. Now reading settings.dat file...");
        if (!_tfs.Exists("settings.dat")) return;
        using (Stream fs = _tfs.Open("settings.dat", FileMode.Open))
        using (var rdr = new StreamReader(fs))
        {
            System.String line;
            while ((line = rdr.ReadLine()) != null)
            {
                Debug.WriteLine(line);
            }
        }     

        TinyFileSystem.DeviceStats aa = _tfs.GetStats();
        Debug.WriteLine("Stats : " + aa.BytesFree);
    }
    else
    {
        Debug.WriteLine("Formatting");
        var start = DateTime.Now;
        _tfs.Format();
        var end = DateTime.Now;
        Debug.WriteLine($"Formatting done, seconds elapsed : {(end - start).TotalSeconds}");

        Debug.WriteLine("Creating file");
        using (Stream fs1 = _tfs.Create("settings.dat"))
        {
            using (var wr = new StreamWriter(fs1))
            {
                wr.WriteLine("<settings>");
                wr.WriteLine("InitialPosX=200");
                wr.WriteLine("InitialPosY=150");
                wr.WriteLine("</settings>");
                wr.Flush();
                fs1.Flush();
            }
        }
        
        Debug.WriteLine("FileCreated");
    }
}
```

As explained above, we need to provide a basic driver to Read, Write, and Erase QSPI. In this case we use QspiMemory.cs, as shown below:

```
using System;
using GHIElectronics.TinyCLR.Devices.Storage;
using GHIElectronics.TinyCLR.Devices.Storage.Provider;
using GHIElectronics.TinyCLR.IO.TinyFileSystem;
using GHIElectronics.TinyCLR.Pins;

public sealed class QspiMemory : StorageDriver
{
    public override int Capacity => 0x1000000;
    public override int PageSize => 0x1000;
    public override int SectorSize => 0x1000;
    public override int BlockSize => 0x1000;

    private StorageController qspiController;
    private IStorageControllerProvider qspiDrive;

    public QspiMemory()
    {
        qspiController = StorageController.FromName(SC20260.StorageController.QuadSpi);
        qspiDrive = qspiController.Provider;
        qspiDrive.Open();
    }

    public override void EraseBlock(int block, int count)
    {
        if ((block + count) * BlockSize > Capacity) throw new ArgumentException("Invalid block + count");

        var address = block * BlockSize;

        for (var i = 0; i < count; i++)
        {
            qspiDrive.Erase(address, BlockSize, TimeSpan.FromSeconds(100));
            address += BlockSize;
        }
    }
    
    public override void EraseChip()
    {
        var block = this.Capacity / this.SectorSize;
        var address = 0;
                
        // qspiDrive.Erase(address, this.Capacity, TimeSpan.FromSeconds(100));
        
        while (block > 0)
        {
            qspiDrive.Erase(address, SectorSize, TimeSpan.FromSeconds(100));
            address += SectorSize;
            block--;
        }
    }
    
    public override void EraseSector(int sector, int count)
    {
        if ((sector + count) * SectorSize > Capacity) throw new ArgumentException("Invalid sector + count");

        var address = sector * SectorSize;

        for (var i = 0; i < count; i++)
        {
            qspiDrive.Erase(address, BlockSize, TimeSpan.FromSeconds(100));
            address += SectorSize;
        }
    }
   
    public override void ReadData(int address, byte[] data, int index, int count)
    {
        qspiDrive.Read(address, count, data, index, TimeSpan.FromSeconds(1));
    }
    
    public override void WriteData(int address, byte[] data, int index, int count)
    {
        qspiDrive.Write(address, count, data, index, TimeSpan.FromSeconds(1));
    }

    public void DetectParameters()
    {

    }
}
```

 