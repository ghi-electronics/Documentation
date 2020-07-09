# File System
---
The file system library is subset of the full .NET file system support. Most example should work with without minor changes. The internal drivers fully support FAT16 or FAT32 file systems, with no limitations beyond the FAT file system itself!

## USB Mass Storage
This allows file access on USB devices with MSC class, such as USB memory sticks. See the [USB](usb.md) page.

## SD Card
SD and MMC cards are fully supported as detailed on the [SD tutorial](sd-cards.md) page.

The example below requires the `GHIElectronics.TinyCLR.IO` and `GHIElectronics.TinyCLR.Devices.SecureStorage` libraries and a device with an SD card.

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
