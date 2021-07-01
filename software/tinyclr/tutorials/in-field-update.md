# In-Field Update

---
TinyCLR OS allows for secure, encrypted, In-Field Update (IFU). Simply, the IFU feature buffers the new 'to-be-updated' application (and/or firmware) into RAM or FLASH. Once the entire application (or firmware) is buffered, the IFU will do a full security check before it updates the system. Having enough flash or RAM (typically external) is needed to buffer up the application and the firmware.

The IFU service is started with `var updater = new InFieldUpdate(QuadSpiController)` when using external flash, or simply with `var updater = new InFieldUpdate()` when using RAM. It is important to note that the firmware application is buffered temporarily externally in its encrypted format, keeping security intact. All decrypted data is handled internally inside the chip, away from intruders!

The IFU system supports data coming from any source. An update, for example, can come from a file, network, or even CAN bus!

Loading an application requires a key, which is loaded using `updater.LoadApplicationKey(appKey)` and then the application can then be loaded in chunks using `updater.LoadApplicationChunk(data, 0, count)`. And similarly, the firmware can be loaded through `updater.LoadFirmwareChunk(data, 0, count)`. Internally, IFU keeps track of chunk count and size. The passed argument is for the user's provided data and not the internal chunk/data counters. In case of an error, the user can reset the internal chunk counters `updater.ResetChunks()`, which resets both application and firmware counters.

Once the entire firmware or application chunks are loaded, they can be verified and a version number is returned back, or an exception is raised if the loaded firmware/application did not pass authentication.

```cs
var firmwareVersion = updater.VerifyFirmware();
var applicationVersion = updater.VerifyApplication();
```

The system is now ready for flash and reset `updater.FlashAndReset()`. It is critical that the system is not reset or power is lost during reset. Depending on the application size, this can take a few seconds. A power loss will result in a nonfunctional device that needs to be manually update.

> [!Note]
> When update uses external flash (QSPI) as temporary buffer, the block size must be 1K, 2K, 4K, 8K...etc. We recommend using 1K as the firmware and tca files are always multiple of 1K.

## Memory Requirements

Firmware update needs to have a temp buffer that is the size of the firmware itself. For applications, the temporary buffer needs to be the size of the internal deployment, plus the external deployment if implemented, by "extending deployment". Systems with large external RAM will usually select RAM update. For systems without external RAM, an external QSPI flash becomes necessary. When external flash is used for buffering, IFU will overwrite the entire flash, minus the first 2MB and the area reserved for extending the application deployment area, as explained under `External Flash` on the [External Memory](external-memory.md) page. A [Tiny File System](file-system.md) usage of the first 2MB of external flash will survive IFU even when `useExternalFlash` is enabled.

## Activity Pin

As update can take a while, an activity pin can be enabled to help in determining when the update is finished. Using an LED as an indicator is an excellent example.

```cs
var indicatorLed = GpioController.GetDefault().OpenPin(SC20260.GpioPin.PB0);
updater.ActivityPin = indicatorLed;
```

## Example Code

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

## ApplicationUpdate

When no external memories are present (Flash nor RAM) and standard IFU is not an options, the application (not firmware) can still be updated from a file located on SD card or USB memory.

```cs
// Open a file stream to an application file on an SD card or USB memory
// ...
var updater = new ApplicationdUpdate(filestream, appKey)
var applicationVersion = updater.Verify();
updater.ActivityPin = indicatorPin; // optional
updater.FlashAndReset();
```

---

## IFU 2.0 to 2.1

Starting release 2.1, IFU is reworked to support complete firmware and application update using external flash (when available) or external RAM (when available). Unfortunately, using IFU to update from 2.1 to 2.2 is only possible if the deployment region was not extended to use external flash.

A work around to update 2.0 to 2.1 is by updating 2.0 to a new 2.1 temporary application that does not use external flash. Once this temp application is loaded then the final application with external flash can be deployed.

---

## Firmware and Application Matching

It is important that the loaded firmware is the same version expected by the application. It is usually best to update both when possible.