# Release Notes
---
![TinyCLR Logo](images/tinyclr-logo-noborder.jpg)

## 2.0.0 - Release

### Released 2020-08-21
Fixed final bug, making it ready for production.

### Visual Studio Project System

#### Changes
- Updated version number 2.0.0

#### Known Issues
- None

### Libraries

#### Changes
- Updated version number 2.0.0

#### Known Issues
- Sometimes a longer delay than usual during deployment. (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/660)
- Debug breakpoints sometimes hang for 5-6 seconds before resuming normally (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/659)
- Exception filter causes lockup when exception thrown from instance method (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/652)
- GetChars throwing on certain byte values (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/651)
- Double ToString() show number incorrectly sometime  (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/629)
- Running out of stack kills Visual studio (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/586)
- JSON cannot deserialize long integers (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/540)
- Network operations on any thread block all threads  (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/525)
- String does not implement IEnumerable  (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/323)
- Equals() throws unsupported instruction exception  (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/502)
- CAN CanWriteMessage always return true (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/635)
- Power consumption is high in Shutdown mode (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/667)
- USB Host: Unmount FS may cause system hang in Disconnected event. See workaround: https://github.com/ghi-electronics/TinyCLR-Libraries/issues/665
- System time need to be more accurate (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/664)

### TinyCLR Config

#### Changes
- Updated version number 2.0.0
- Fixed text. 

#### Known Issues
- Erase all doesn't erase external flash.
- Sometimes fails to connect until board is reset.
    
### TinyCLR Font Converter

#### Changes
- None.

#### Known Issues
- None.

### Firmware

#### Changes
- None.

#### Known Issue
- None.

### Drivers

#### Changes
- Updated version number 2.0.0

#### Known Issues
 - SSD1351-Draw at position X may need offset = 10 to correct position. (https://github.com/ghi-electronics/TinyCLR-Drivers/issues/109)

---

---

## 2.0.0-rc2

### Released 2020-08-05
Fixed final bug, making it ready for production.

### Visual Studio Project System

#### Changes
- Fixed assemblies that contain resources with a lot of 0xFF, where the system mistook them for blank spaces.
- Prevent deploy if the size didn't fit in a region in some cases.

#### Known Issues
- None

### Libraries

#### Changes
- Support old NETMF Graphics API.
- Add Tiny File System.
- Add RTC calibration.
- Fixed XML EOF (End Of File) doesn't work.
- UI MessageBox support one button, instead of always two buttons.
- Graphic Color class now supports array convert between RGB565, ARGB8888, RGB888 and RGB323 and scale pattern color table.
- BitConverter now supports convert array with pattern index table.
- Fixed WiFi and ENC can't enable/disable multi-time.
- Fixed PWM Controller 1 doesn't work on SC20100.
- Fixed QSPI check blank failed after erase in some cases.

#### Known Issues
- Sometimes a longer delay than usual during deployment. (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/660)
- Debug breakpoints sometimes hang for 5-6 seconds before resuming normally (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/659)
- Exception filter causes lockup when exception thrown from instance method (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/652)
- GetChars throwing on certain byte values (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/651)
- Double ToString() show number incorrectly sometime  (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/629)
- Running out of stack kills Visual studio (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/586)
- JSON cannot deserialize long integers (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/540)
- Network operations on any thread block all threads  (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/525)
- String does not implement IEnumerable  (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/323)
- Equals() throws unsupported instruction exception  (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/502)
- CAN CanWriteMessage always return true (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/635)

### TinyCLR Config

#### Changes
- Update Application also update Firmware at the same time if both file are selected.
- Fixed Invalid Key message if without clicking the "Generate Key" button sometime.
- Fixed some minor GUI.
- Export tca file has smaller size.

#### Known Issues
- Erase all doesn't erase external flash.
- Sometimes fails to connect until board is reset.
    
### TinyCLR Font Converter

#### Changes
- None.

#### Known Issues
- None.

### Firmware

#### Changes
- Uart: Fixed can not release CTS, RTS pins when close UART
- Uart: Enable FIFO mode.
- Uart: Flush() will wait until last byte transfer completed.
- QSPI: Fixed total size was wrong.
- Disable some peripherals interrupt during deploy application.
- Fix freeze in some cases when update application by TinyCLR Config.

#### Known Issue
- None.

### Drivers

#### Changes
- LPD8806, WS2812, APA102C: Add SetBuffer(), Flush() to speed up transfer.
- Rename: LPD8806, WS2812, APA102C, OV9655, VS1053B, Msgeq7 to LPD8806Controller, WS2812Controller, APA102CController, OV9655Controller, VS1053BController, Msgeq7Controller.


#### Known Issues
 - SSD1351-Draw at position X may need offset = 10 to correct position. (https://github.com/ghi-electronics/TinyCLR-Drivers/issues/109)

---

---



## 2.0.0-rc1

### Released 2020-07-04
Complete software package prepping for production.

### Visual Studio Project System

#### Changes
- Fixed the issue where an application wouldn't start automatically when trying to `Start Without Debugging` (CTRL+F5).

#### Known Issues
- Debug breakpoints will sometimes hang for 5-6 seconds before resuming normally.
- There is sometimes a longer than usual delay during deployment at the "Found debugger" and "Waiting for device to initialize" steps.

### Libraries

#### Changes
- Fixed sockets blocking code execution while connecting.
- Added XTEA cryptography.
- Added CAN FD support.
- Added CAN hardware filters.
- UART: 
        - Added DE pin support.
        - Added ability to invert RX and TX polarity.
        - Added support for swapping TX and RX pins.
        - Added support generating a Break signal of user defined length.
        - Changed SetActiveSettings API.
- Changed SetActiveSettings API for USB client.
- Added XML support.       
- Added the SecureStorage class to support both the OTP and configuration storage areas.
- Added support for changing some processor peripheral registers through use of the Marshal class.
- Enabled garbage collection (GC) messages.
- Added ability to enable and disable global interrupts.
- Improved UI and fixed some UI bugs.
- Fixed issue where the WiFi Scan() method would return an array of SSIDs with the last element always empty.

#### Known Issues
- Running out of stack kills Visual Studio: https://github.com/ghi-electronics/TinyCLR-Libraries/issues/586.
- PNG file deployment issue: https://github.com/ghi-electronics/TinyCLR-Libraries/issues/557.
- JSON cannot deserialize long integers: https://github.com/ghi-electronics/TinyCLR-Libraries/issues/540.
- Network operations (except socket connection) on any thread blocks all other threads: https://github.com/ghi-electronics/TinyCLR-Libraries/issues/525.
- String does not implement IEnumerable: https://github.com/ghi-electronics/TinyCLR-Libraries/issues/323.
- Exceptions in event handlers leave the UI corrupted: https://github.com/ghi-electronics/TinyCLR-Libraries/issues/498.
- Project->Add->Class does not select the correct template: https://github.com/ghi-electronics/TinyCLR-Libraries/issues/500.
- Equals() throws an unsupported instruction exception: https://github.com/ghi-electronics/TinyCLR-Libraries/issues/502.
- Double.ToString() sometimes shows incorrect number. https://github.com/ghi-electronics/TinyCLR-Libraries/issues/629.
- CAN: CanWriteMessage always return true: https://github.com/ghi-electronics/TinyCLR-Libraries/issues/635
- Uart: Break Signal need to wait to last byte transfer complete https://github.com/ghi-electronics/TinyCLR-Libraries/issues/634

### TinyCLR Config

#### Changes
- Changed export key template. 
- Fixed progress bar no longer appearing once a firmware update fails.

#### Known Issues
- Sometimes fails to connect until board is reset.

### TinyCLR Font Converter

#### Changes
- None.

#### Known Issues
- None.

### Firmware

#### Changes
- Fixed issue of SPI locking up the system.
- Added protection for QSPI pins to prevent their use if external flash is enabled.
- Added WiFi activity and status LED support.
- Fixed issue with UART when using two stop bits.
- Fixed incorrect Ethernet RX/TX buffer allocation.
- Fixed USB disconnection causing crash on SC20100 series devices.
- Fixed use of ADC on PC3 pin throwing an invalid operator exception.
- Improved In-Field Update (IFU) by raising an exception if the application is too large to deploy to device.
- Fixed issue of an exception not being raised when attempting to write to a configuration storage block which is not blank.
- Fixed System Timer updating incorrectly.
- Fixed USBClient.Read() sometimes losing data.

#### Known Issue
- Networking won't work correctly if WiFi Scan() is called after Network.Enable().

### Drivers

#### Changes
- None.

#### Known Issues
- None.

---

---

![TinyCLR Logo](images/tinyclr-logo-noborder.jpg)

## 2.0.0-preview6

### Released 2020-05-20
This preview release implements all remaining functionality, fixes bugs, and improves the API.

### Visual Studio Project System

#### Changes
- Added support for secure assemblies.
- Removed Visual Basic template.

#### Known Issues
- Debug breakpoint will sometimes hang for 5-6 seconds before resuming normally.
- There is sometimes a longer than usual delay during deployment at the "Found debugger" and "Waiting for device to initialize" steps.

### Libraries

#### Changes
- MQTT keep alive timeout default has been changed to 60 seconds.
- "EnableExternalHeap" has been renamed to "ExtendHeap."
- Added OTP support to API.
- Added external flash support to API.
- Fixed Double.Compare incorrectly returning zero.
- Fixed intermittent crashing when using SPI with no chip select.

#### Known Issues
- String does not implement IEnumerable (GitHub issue #323).
- JSON cannot deserialize long integers (GitHub issue #540).
- Network operations on any thread block all other threads (GitHub issue #525).
- Network stack requires delays in order to work properly (GitHub issue #503).
- Equals() throws unsupported instruction exceptions (GitHub issue #502).
- On touch screens, moving off of a button does not release the button (GitHub issue #479).
- I2C raises timeout exception when using address 0x00 (GitHub issue #554).
- Several other bugs have been reported which have not yet been verified by GHI Electronics.

### TinyCLR Config

#### Changes
- Improved user experience during installation.
- Added Device Configuration window to enable extension of RAM (Extend heap) and extension of flash (Enable external flash) into external memories. Also added ability to disable the debug interface.
- Added Deployment Map.
- Added progress bar while erasing device.

#### Known Issues
- Sometimes fails to connect until board is reset.

### TinyCLR Font Converter

#### Changes
- None.

#### Known Issues
- None.

### Firmware

#### Changes
- Support for deployments in external QSPI flash in addition to internal flash.
- Deployment size has changed. Secure deployments can now be up to 640 KBytes in size, external deployments can be up to 8 MBytes.
- Added 64 KByte one time programmable (OTP) region.
- Improved Ethernet performance.
- Green Ethernet LED is now activity indicator instead of link indictor.
- MAC addressing has changed. Ethernet and ENC always require a MAC address, WiFi MAC address is optional, PPP needs no MAC address.
- Fixed Thread.Sleep() adding 2 ms when not debugging.
- Fixed USB and SD card not working at the same time.

#### Known Issues
- User can access QSPI pins even when QSPI is active for deployment.
- Networking won't work correctly if WiFi scan is called after `Network.Enable()`.
- WiFi scan always adds a blank SSID at the end of the list.
- Drawing on screen may be slower when network that uses SPI is running (WiFi, ENC28).
- In Visual Studio, the application doesn't start automatically when trying to `Start Without Debugging` (CTRL+F5). Resetting the board will start the application.
- The PJ0 interrupt configuration changes when the device is reset with the reset button, but there is no problem when power cycling the board.

### Drivers

#### Changes
- Fixed issue of intermittent noise coming from OV9655 camera modules.

#### Known Issues
- None.

---

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

![TinyCLR Logo](images/tinyclr-logo-noborder.jpg)

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
- Cannot send more than 64 KBytes in one SPI transaction. The workaround is to split the data so the transactions are smaller.
- When using static IP addressing, after disconnecting the device from an Ethernet network the old IP address will still be assigned instead of 0.0.0.0.
- Graphics.DrawString() with native displays on the SC20260B may stop WiFi.

---

---

![TinyCLR Logo](images/tinyclr-logo-noborder.jpg)

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
- Increased default free heap size from 300 KBytes to 364 KBytes (maximum size is still 512 KBytes).
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

![TinyCLR Logo](images/tinyclr-logo-noborder.jpg)

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

![TinyCLR Logo](images/tinyclr-logo-noborder.jpg)

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

![TinyCLR Logo](images/tinyclr-logo-noborder.jpg)

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
