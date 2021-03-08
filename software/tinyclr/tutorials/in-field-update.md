# In-Field Update
---
TinyCLR OS allows for secure, encrypted, In-Field Update (IFU). The new to-be-updated application or firmware are fetched through a [Stream](stream.md). Streams can be memory, storage file or network. The system requires a temporarily local buffer to hold new application (or firmware) for authentication and processing. Internal or external can be used when available. If not, external flash can be used as well.

The constructor for IFU takes the two stream and a flag to require IFU to use the external flash for buffering.
`InFieldUpdate(Stream applicationStream, Stream firmwareStream, bool useExternalFlash)`

When external flash is used for buffering, IFU will overwrite the flash, minus the first 2MB and the area reserved for extending the application deployment area, as explained under `External Flash` [External Memory](external-memory.md) page. A [Tiny File System](file-system.md) usage of the first 2MB of external flash will survive IFU even when `useExternalFlash` is enabled.

> [!Tip]
> The application and the firmware are buffered in external memories in encrypted fashion and has no security implication, keeping IFU done securely.

> [!Warning]
> Power interruption during `FlashAndReset` will cause the update to fail, requiring a manual update. However, it is safe during `Build`.


```cs
var fwBuf = YourFirmwareBuffer;
var appBuf = YourApplicationBuffer;

var memoryStreamFirmware = new MemoryStream(fwBuf);
var memoryStreamApplication = new MemoryStream(appBuf);
var useExternalFlash = true;

// key is generated along with the application from TinyCLR Config tool
var appKey = new byte[] { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };

updater = new InFieldUpdate(memoryStreamFirmware, memoryStreamApplication, appKey, useExternalFlash);

updater.Build(true, true); // Build both firmware and application

Debug.WriteLine("Firmware version: " + updater.FirmwareVersion);
Debug.WriteLine("Application version: " + updater.ApplicaltionVersion);

updater.FlashAndReset();
```

It might be desired to only `Build` one stream at a time, but if IFU is constructed with two streams then both `Build` must be completed before `FlashAndReset`.

```
updater.Build(true, false);
// do something
// ...
updater.Build(false, true);
```
> [!Tip]
> Running IFU in a thread is desired to keep the system running while IFU finish `Build`. But once `FlashAndReset` is called the system is locked till done and reset automatically.

---

## Without External Memory

When no external memories are present (Flash nor RAM), only the application can be updated and only using file stream.

> [!Note]
> Very tiny applications can be theoretically be updated using memory streams, assuming the memory is enough to hold the entire new application.

---

# Network Consideration
Network stream determines the end of file transfer after a specific timeout, defaulted to 5 seconds. This can be increased in a slower network or decreased in a controlled network.
```
updater.ReadDataTimeout = TimeSpan.FromSeconds(5); // 5 seconds
```

The server providing the data needs to consider that IFU will need time to `Build` one stream a time, which can take a while especially when external flash buffering is enabled. For example, a 6MB Application buffered to external flash will need about 2 minutes.

---

## IFU 2.0 to 2.1
Starting release 2.1, IFU is reworked to support complete firmware and application update using external flash (when available) or external RAM (when available). Unfortunately, using IFU to update from 2.1 to 2.2 is only possible if the deployment region was not extended to use external flash.

A work around to update 2.0 to 2.1 is by updating 2.0 to a new 2.1 temporary application that does not use external flash. Once this temp application is loaded then the final application with external flash can be deployed.

---

## Firmware and Application Matching

It is important that the loaded firmware is the same version expected by the application. It is usually best to update both when possible.