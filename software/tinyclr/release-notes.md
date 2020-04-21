# Release Notes
---
![TinyCLR Logo](images/tinyclr-logo-noborder.jpg)

## 2.0.0-preview5

### Released 2020-04-21
This preview release moves us closer to a commercially viable product with new and updated features and some API improvements.

### Visual Studio Project System

#### Changes
- Updated to preview5

#### Known Issues
- None

### Libraries

#### Changes
- Added rotation to display and touch.
- Added endianness argument to SPI API.
- Removed data bit length from SPI API.
- Changed SPI chip select argument type from integer to GpioPin.
- AssemblySigner has been removed.
- Updated user interface keyboard resource image.
- Added support for USB keyboards, mice, and raw device library to USB host class.
- SignalGenerator now always uses a carrier frequency of 38 kHz.
- Added missing QSPI pins to GHIElectronics.TinyCLR.Pins.
- Improved JSON support.
- Changed GeneratePulse() to Trigger() in SignalGenerator, SignalCapture, and PulseFeedback APIs.
- Simplified formatting of RFC dates.
- Fixed TextBox misalignment in UI library.
- Made CheckBoxes consistent with XAML API in UI library.
- Fixed problem with building libraries.
- Added PWM15 pin definition.

#### Known Issues
- The ToString() method fails on structs, including Guid and enum.
- Equals() throws an CLR_E_UNSUPPORTED_INSTRUCTION exception.
- Dropdowns in user interface do not respond to direct touches.
- In networking, Socket.Connect blocks all threads until it finishes.

### TinyCLR Config

#### Changes
- Added a progress bar and result highlighting.

#### Known Issues
- TinyCLR Config forces device reboot several times when reconnecting to the device. Does not happen during firmware update.

### TinyCLR Font Converter

#### Changes
- None.

#### Known Issues
- None.

### Firmware

#### Changes
- Removed GetDefault() from the API of peripherals that have more than one controller or channel.
- Reworked the SPI API.
- Added screen rotation.
- Added USB host keyboard, mouse, and raw device.
- Fixed PulseFeedback DrainDuration mode.
- Fixed file information calls returning a Not Implemented exception.
- Fixed incorrect reporting of static IP addresses when there is no connection.
- Fixed inability to set socket timeout.
- Changed serial deploy/debug port from UART5 to UART1 on 100 pin devices. SC20260B still uses UART5.
- The RTC will run approximately one second slower every 4-6 hours.
- Drawing on display becomes slower if there is network activity.

#### Known Issues
- In Visual Studio, the application doesn't start automatically when trying to `Start Without Debugging` (CTRL+F5). Resetting the board will start the application.
- The PJ0 interrupt configuration changes when the device is reset with the reset button, but there is no problem when power cycling the board.

### Drivers

#### Changes
- Added support for display rotation to the FT5x06 Touch driver
- Reworked the MSGEQ7 graphic equalizer API.
- Fixed incorrect color rendition in the WS2812 LED driver.

#### Known Issues
- When drawing to SSD1351 displays, you may have to add ten to the x coordinate for the screen position to be correct.
- The OV9655 camera can intermittently have a noisy picture. Resetting the board should fix the problem.

---

---

## 2.0.0-preview4

### Released 2020-03-10
This preview release includes many bug fixes, a few new and updated features, and some API improvements.

### Visual Studio Project System

#### Changes
- Updated with the latest core libraries.

#### Known Issues
- None

### Libraries

#### Changes
- Fixed missing UART dependency when adding Network NuGet.
- Fixed ADC that was incorrectly mapped to wrong controller.
- Added serialization.
- Reworked power management API.
- DisplayController is now only used with parallel interface displays.
- Graphics.Clear() no longer takes an argument.
- Added NeoPixel WS2812 driver.
- Added SSD1351 display driver.
- Changed MJPEG driver to return raw jpeg data instead of internally flushing data to display.
- Fixed dependency for OV9655 driver and sped up screen refresh rate.
- Reworked the SSD1306 and ST7735 display drivers so they no longer inherit from DisplayController.

#### Known Issues
- JSON does not work in some cases.
- When drawing to SSD1351 displays, you may have to add ten to the x coordinate for the screen position to be correct.
- The OV9655 camera can intermittently have a noisy picture. Resetting the board should fix the problem.

### TinyCLR Config

#### Changes
- Fixed occasional crashes during firmware updates.

#### Known Issues
- None

### TinyCLR Font Converter

#### Changes
- None.

#### Known Issues
- None.

### Firmware

#### Changes
- Signal generator has been improved and can now generate signals of up to 1.25 MHz in frequency.
- Fixed SPI locking up networking.
- Fixed bug when sharing SPI bus with multiple devices.
- Fixed incorrect timestamping of events.
- Added support for microcontroller temperature sensor.
- Added support for Vbat voltage monitoring.
- Added support for ADC internal reference voltage.
- Fixed I2C bug with messages larger than 255 bytes.
- Corrected I2C clock bug.
- Added support for wake up from RTC alarm.
- Reworked power management with support for stopping processor during Thread.Sleep().
- Added pin PC1 as analog input on SC20100S.
- Fixed crashing when deploying application over UART.
- Improved Ethernet
- Fixed networking bug when using static IP Addressing.

#### Known Issues
- In Visual Studio, the application doesn't start automatically when trying to `Start Without Debugging` (CTRL+F5). Resetting the board will start the application.
- The PJ0 interrupt configuration changes when the device is reset with the reset button, but there is no problem when power cycling the board.
- ToString() does not work if the argument is an Enum.
- PulseFeedback DrainDuration does not work correctly.
- Cannot send more than 64 kBytes in one SPI transaction. The workaround is to split the data so the transactions are smaller.
- When using static IP addressing, after disconnecting the device from an Ethernet network the old IP address will still be assigned instead of 0.0.0.0.
- Graphics.DrawString() with native displays on the SC20260B may stop WiFi.

---

---

## 2.0.0-preview3

### Released 2020-02-20
Our third preview includes bug fixes, added features, and increases performance.

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
