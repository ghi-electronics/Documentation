# Release Notes
---
![TinyCLR Logo](images/tinyclr-logo-noborder.jpg)

## 2.0.0-preview3

### Released 2020-02-20

### Visual Studio Project System

#### Changes
- None

#### Known Issues
- None

### Libraries

#### Changes
- Added missing USB host controller definition.
- Added missing UART controller definition.
- Removed Network Stream timeout.
- Removed Streams.
- Removed GHIElectronics.TinyCLR.Devices NuGet package.
- Fixed HTTP exception that sometimes occurs when parsing data.
- Added Button, ListBoxHighLightItem, ProgressBar, CheckBox, Radio Button, and Drop-Down List elements to UI.
- Added ability to get current WiFi MAC Address.
- Added simple MJPEG driver that supports decoding of MJPEG files.
- Added simple WAV driver that supports decoding of WAV files.

#### Known Issues
- JSON doesn't work in some cases.
- Ov9655 camera can randomly have a noisy picture. Reset the board as a workaround.      

### TinyCLR Config

#### Changes
- Fixed display of incorrect version number.
- Fixed crashing when trying to connect to bootloader.
- Fixed Connect button not returning to Enable after firmware update is done.

#### Known Issues
- None.

### TinyCLR Font Converter

#### Changes
- None.

#### Known Issues
- None.

### Firmware

#### Changes
- Increased Performance by 15%.
- Added RSA cryptography.
- Added MD5 hash.
- Fixed One-Wire exceptions and inconsistent operation.
- Added Network Suspend/Resume to support changing back and forth between a modem's PPP data frame mode and AT command mode.
- Added Enable External Memory for heap (heap can be 32 MBytes).
- Fixed SPI from using PA0 for chip select if no chip select pin is specified.
- Fixed SPI4 and SPI5 clock errors.
- Increased default free heap size from 300 kBytes to 364 kBytes (maximum size is still 512 kBytes).
- Fixed USB client reading only a single byte of each packet.
- Fixed system crashing when there are missing network configuration settings.
- Added support for hardware random number generator.
- Fixed SPI throwing exceptions when drawing on N18 display.

#### Known Issues
- In Visual Studio the application doesn't start automatically when trying to `Start Without Debugging` (Ctrl+F5). Pressing the reset button will start the application.
- The PJ0 interrupt configuration changes when the device is reset with the reset button, but there is no problem when resetting by power cycling the board. 
- ToString() doesn't work if the argument is an Enum.
- PulseFeedback DrainDuration does not work correctly.

---

---

## 2.0.0-preview2 update

### Released 2020-01-31
A refresh release of the firmware only with improved performance.

#### Changes
- Considerably faster execution speed.

#### Known Issues
- See the 2.0.0-preview2 release notes.
- This 2.0.0.21000 release activates all accelerators which might cause some bugs. If you have any strange behavior, please load the previous 2.0.0.20000 release and see if that fixes your issue. Both firmware versions are identical otherwise, and both run with same 2.0.0-preview2 NuGet packages.

---

---

## 2.0.0-preview2

### Released 2020-01-22
Initial insider release for SITCore hardware.

### Visual Studio Project System

#### Changes
- First release to private insiders with major changes.

#### Known Issues
- Cannot change boards or connect an additional board to your PC while Visual Studio is open, or Visual Studio will get confused and deployment will stop working. Do not switch devices while Visual Studio is open.
- Not digitally signed.

### Libraries

#### Changes
- First release to private insiders with major changes.

#### Known Issues
- None, still going through final testing.
- Cryptography and hashing are currently only supported through TLS. We are still planning how to securely expose this functionality.
- Not digitally signed.

### TinyCLR Config

#### Changes
- First release to private insiders with major changes.

#### Known Issues
- TinyCLR may not work when connecting over UART. Use Tera Term to update firmware when in UART mode.
- Not digitally signed.

### TinyCLR Font Converter

#### Changes
- None.

#### Known Issues
- None.
- Not digitally signed.

### Firmware

#### Changes
- First release to private insiders with major changes.

#### Known Issues
- TinyCLR OS is not yet optimized for full performance as this release is focused on stability.
- Conversion from enum to string (enumObject.ToString()) may fail.
- PulseFeedback DrainDuration does not work when going from low to high.
- Not digitally signed.

---

---

## 2.0.0-preview1

### Released 2019-12-09
A preview of the new API and available features.

### Libraries

#### Changes
- Major changes.

#### Known Issues
- Still going through complete testing.

### Firmware

#### Changes
- Major changes.

#### Known Issues
- Internal use only.

### TinyCLR Config

#### Changes
- None.

#### Known Issues
- Random crash.
