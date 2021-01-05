# In-Field Update
---
TinyCLR OS allows for secure, encrypted, In-Field Update (IFU). The new to-be-updated application or firmware are fetched through a [Stream](stream.md). Streams can be memory, storage file or network. The system requires a temporarily local buffer to hold new application (or firmware) for authentication and processing. Internal or external can be used when available. If not, external flash can be used as well.

The constructor for IFU takes the two stream and a flag to require IFU to use the external flash for buffering.
`InFieldUpdate(Stream applicationStream, Stream firmwareStream, bool useExternalFlash)`

When external flash is used for buffering, IFU will overwrite the flash, minus the first 2MB and the area reserved for extending the application deployment area, as explained under `External Flash` [External Memory](external-memory.md) page. A [Tiny File System](file-system.md) usage of the first 2MB of external flash will survive IFU even when `useExternalFlash` is enabled.

> [TIP!]
> The application and the firmware are buffered in external memories in encrypted fashion and has no security implication, keeping IFU done securely.

```cs
var fwBuf = YourFirmwareBuffer;
var appBuf = YourApplicationBuffer;

var memoryStreamFirmware = new MemoryStream(fwBuf);
var memoryStreamApplication = new MemoryStream(appBuf);
var useExternalFlash = true;

// key is generated along with the application from TinyCLR Config tool
var appKey = new byte[] { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };

updater = new InFieldUpdate(memoryStreamFirmware, memoryStreamApplication, appKey, useExternalFlash);

updater.Build(true, true);  

Debug.WriteLine("Firmware version: " + updater.FirmwareVersion);
Debug.WriteLine("Application version: " + updater.ApplicaltionVersion);

updater.FlashAndReset();
```

> [!Warning]
> Power interruption during `FlashAndReset` will cause the update to fail making it necessary to manually update your board. However, it is safe during `Build`.

## Without external memory

When no external memories are present (Flash nor RAM), only the application can be updated and only using file stream.

> [NOTE!]
> Very tiny applications can be theoretically be updated using memory streams, assuming the memory is enough to hold the entire new application.

---
## Firmware and Application Matching

It is important that the loaded firmware is the same version expected by the application. It is usually best to update both when possible.