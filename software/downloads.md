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
[v1.1.4](https://ghistorage.blob.core.windows.net/downloads/Due/Firmware/due_sc13_v114.ghi) | 2023-10-09 | RC
[v1.1.3](https://ghistorage.blob.core.windows.net/downloads/Due/Firmware/due_sc13_v113.ghi) | 2023-09-21 | RC
[v1.1.2](https://ghistorage.blob.core.windows.net/downloads/Due/Firmware/due_sc13_v112.ghi) | 2023-09-18 | RC
[v1.1.0](https://ghistorage.blob.core.windows.net/downloads/Due/Firmware/due_sc13_v110.ghi) | 2023-08-08 | RC
[v1.0.3](https://ghistorage.blob.core.windows.net/downloads/Due/Firmware/due_sc13_v103.ghi) | 2023-05-30 | RC
[v1.0.2](https://ghistorage.blob.core.windows.net/downloads/Due/Firmware/due_sc13_v102.ghi) | 2023-05-24 | RC
[v1.0.1](https://ghistorage.blob.core.windows.net/downloads/Due/Firmware/due_sc13_v101.ghi) | 2023-05-19 | RC


### SC007 (BrainPad Edge)

File | Date | Status
--- | --- | ---
[v1.1.4](https://ghistorage.blob.core.windows.net/downloads/Due/Firmware/due_sc007_v114.ghi) | 2023-10-09 | RC
[v1.1.3](https://ghistorage.blob.core.windows.net/downloads/Due/Firmware/due_sc007_v113.ghi) | 2023-09-21 | RC
[v1.1.2](https://ghistorage.blob.core.windows.net/downloads/Due/Firmware/due_sc007_v112.ghi) | 2023-09-18 | RC
[v1.1.0](https://ghistorage.blob.core.windows.net/downloads/Due/Firmware/due_sc007_v110.ghi) | 2023-08-08 | RC
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
[v1.1.1](https://ghistorage.blob.core.windows.net/downloads/Due/Libraries/dotnet/GHIElectronics.DUELink.1.1.1.nupkg) | 2023-09-26 | RC
[v1.1.0](https://ghistorage.blob.core.windows.net/downloads/Due/Libraries/dotnet/GHIElectronics.DUELink.1.1.0.nupkg) | 2023-08-08 | RC
[v1.0.3](https://ghistorage.blob.core.windows.net/downloads/Due/Libraries/dotnet/GHIElectronics.DUELink.1.0.3.nupkg) | 2023-05-30 | RC
[v1.0.2](https://ghistorage.blob.core.windows.net/downloads/Due/Libraries/dotnet/GHIElectronics.DUELink.1.0.2.nupkg) | 2023-05-24 | RC
[v1.0.1](https://ghistorage.blob.core.windows.net/downloads/Due/Libraries/dotnet/GHIElectronics.DUELink.1.0.1.nupkg) | 2023-05-19 | RC


### Python Library

> [!Tip]
> These are hosted on pypi.org and can be fetched using `pip`. These download are optional.

File | Date | Status
--- | --- | ---
[v1.1.1](https://ghistorage.blob.core.windows.net/downloads/Due/Libraries/python/DUELink-1.1.1-py3-none-any.whl) | 2023-09-26 | RC
[v1.1.0](https://ghistorage.blob.core.windows.net/downloads/Due/Libraries/python/DUELink-1.1.0-py3-none-any.whl) | 2023-08-08 | RC
[v1.0.3](https://ghistorage.blob.core.windows.net/downloads/Due/Libraries/python/DUELink-1.0.3-py3-none-any.whl) | 2023-05-30 | RC
[v1.0.2](https://ghistorage.blob.core.windows.net/downloads/Due/Libraries/python/DUELink-1.0.2-py3-none-any.whl) | 2023-05-24 | RC
[v1.0.1](https://ghistorage.blob.core.windows.net/downloads/Due/Libraries/python/DUELink-1.0.1-py3-none-any.whl) | 2023-05-19 | RC


### JavaScript Library


File | Date | Status
--- | --- | ---
[v1.1.1](https://github.com/ghi-electronics/due-libraries/tree/main/javascript) | 2023-09-26 | RC
[v1.1.0](https://github.com/ghi-electronics/due-libraries/tree/main/javascript) | 2023-08-08 | RC
[v1.0.3](https://github.com/ghi-electronics/due-libraries/tree/main/javascript) | 2023-05-30 | RC

## Release Notes

### v1.1.4: 2023-10-09
* Firmware:
    - Improved SoftwarePwm
    - Add 20ms debouce for button
	
### v1.1.3: 2023-09-26
* Firmware:
    - Increased heap to 40K for SC13 and 6K for SC007
    - Fixed touch read x,y on SC007 need return -1
	- Fixed Touchread display doesn't work in Program mode
		
### v1.1.1: 2023-09-26
* Library:
    - Fix reading Temperture and huminity return bool value

### v1.1.0: 2023-08-08
* Firmware:
	- Added support for ST7735, ILI9341, ILI9342 SPI displays (on BrainPad Pulse)
	- Added support for 1bpp, 4bpp, 8bpp, 16bpp color depth to LcdStream
	- Fixed DH11 sensor
	- Add 5x5 font
	- Add onewire protocal
	- Add 'log' command which outputs to console. Print now outputs to screen only
	- Rework LCDConfig take four arguments
	- Several internal bugs and improvements
* Library:
	- Fixed Beep 'P' doesn't work.
	- Added TransferBlockDelay, TransferBlockSizeMax property (DUELinkController class)
	- Update API to match the firmware changs

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

