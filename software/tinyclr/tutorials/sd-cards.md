# SD/MMC Cards
---
SD and MMC cards are fully supported through the [File System](file-system.md) libraries.

This is a sample on how setup the SD driver.

```cs
var sd = StorageController.FromName(SC20100.StorageController.SdCard);

var drive = FileSystem.Mount(sd.Hdc);
```

Additionally, SPI SD drivers are also supported through the `ManagedFileSystem` software utility [drivers](../drivers/software-utility.md).