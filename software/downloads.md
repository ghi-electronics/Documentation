# DUE Downloads

---

![Downloads](../images/downloads.png)

The downloads on this page are automated through the many available on-line services. They are also made available here for convenience. 

---

Software status legend:

Status | Meaning
--- | ---
Production (RTW) | Ready to be used commercially (ready to wear).
Release Candidate (RC) | Could become a production release if proven solid.
Preview | Preview of the next release, not quite ready for production use.

---

## Firmware

### SC13 (FEZ Flea, FEZ Pico, BrainPad Pulse)

File | Date | Status
--- | --- | ---
[v1.0.3](https://ghistorage.blob.core.windows.net/downloads/Due/Firmware/due_sc13_v103.ghi) | 2023-05-30 | RC
[v1.0.2](https://ghistorage.blob.core.windows.net/downloads/Due/Firmware/due_sc13_v102.ghi) | 2023-05-24 | RC
[v1.0.1](https://ghistorage.blob.core.windows.net/downloads/Due/Firmware/due_sc13_v101.ghi) | 2023-05-19 | RC


### SC007 (BrainPad Edge)

File | Date | Status
--- | --- | ---
[v1.0.3](https://ghistorage.blob.core.windows.net/downloads/Due/Firmware/due_sc007_v103.ghi) | 2023-05-30 | RC
[v1.0.2](https://ghistorage.blob.core.windows.net/downloads/Due/Firmware/due_sc007_v102.ghi) | 2023-05-24 | RC
[v1.0.1](https://ghistorage.blob.core.windows.net/downloads/Due/Firmware/due_sc007_v101.ghi) | 2023-05-19 | RC


---

## Library

### .NET NuGet Library

> [!Tip]
> These are hosted on NuGet.org. These downloads are optional.

File | Date | Status
--- | --- | ---
[v1.0.3](https://ghistorage.blob.core.windows.net/downloads/Due/Libraries/dotnet/GHIElectronics.DUELink.1.0.3.nupkg) | 2023-05-30 | RC
[v1.0.2](https://ghistorage.blob.core.windows.net/downloads/Due/Libraries/dotnet/GHIElectronics.DUELink.1.0.2.nupkg) | 2023-05-24 | RC
[v1.0.1](https://ghistorage.blob.core.windows.net/downloads/Due/Libraries/dotnet/GHIElectronics.DUELink.1.0.1.nupkg) | 2023-05-19 | RC



### Python Library

> [!Tip]
> These are hosted on pypi.org and can be fetched using `pip`. These download are optional.

File | Date | Status
--- | --- | ---
[v1.0.3](https://ghistorage.blob.core.windows.net/downloads/Due/Libraries/python/DUELink-1.0.3-py3-none-any.whl) | 2023-05-30 | RC
[v1.0.2](https://ghistorage.blob.core.windows.net/downloads/Due/Libraries/python/DUELink-1.0.2-py3-none-any.whl) | 2023-05-24 | RC
[v1.0.1](https://ghistorage.blob.core.windows.net/downloads/Due/Libraries/python/DUELink-1.0.1-py3-none-any.whl) | 2023-05-19 | RC

## Release Notes

### v1.0.3: 2023-05-30

* Firmware: Fixed issues with labels
* Library: Add DrawImage and DrawImageScale
* Library: Various improvements and changes

### v1.0.2: 2023-05-24

* Add support for single wire distance sensors
* Support NeoPixel on any pin
* Array initialization, with multi line support
* Added LcdImage(), use an array to sprites 
* Add support for Temp and Humidity sensors: DHT11 and DHT22
* Remove Sound and open Frequency to support accept pins
* Support Beep in Pulse buzzer
* Duty cycle range on Frequency is now 0 to 100
* Various improvements and changes

### v1.0.1: 2023-05-19

* Complete API overhaul, Replacing v1.0.0.

### v1.0.0: 2023-05-05

* Initial Release

