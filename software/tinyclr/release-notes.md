# Release Notes
---

## 2.1.0.6200 - Release

### Released 2021-09-14

### Visual Studio Project System

#### Changes

- None.

#### Known Issues

- Sometimes a longer delay than usual during deployment. (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/660)
- Debug breakpoints sometimes hang for 5-6 seconds before resuming normally (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/659)

### Libraries

#### Changes

- None.

#### Known Issues

- https://github.com/ghi-electronics/TinyCLR-Libraries/issues?q=is%3Aissue+is%3Aopen+label%3Abug

### Firmware

#### Changes

##### SC20xxx:

- Fix Ethernet not working on some modules.
- Fix SPI thrown exception sometime.
- Improve LCD high frequency clock to support HDMI.
- Fix CAN stop receiving message after full buffer if error event not subscribed.

##### SC13xxx

- Fix UART event buffer full never called.
- Fix CAN event buffer full never called.
- Fix CAN stop receiving after buffer full.
- Fix UART / CAN out of memory if many error events occurs.
- Free more ~8K for heap.
- Add RTC backup ram.
- Fix PWM has big delay when changed to low frequencies.
 
#### Known Issues

- None.

### Drivers

#### Changes

- Add TFP410 driver support HDMI
- Fixed BasicGraphics DrawTextEx x, y position is doubled.
- No longer support WiFi update by buffer.

#### Known Issues

- None.

### TinyCLR Config

#### Changes

- No warning if detect compatable firmware.

#### Known Issues

- Erase all does not erase external flash.
- Sometimes fails to connect until board is reset.
    
### TinyCLR Font Converter

#### Changes

- None.

#### Known Issues

- None.

---

![TinyCLR Logo](images/tinyclr-logo.png)

## 2.1.0 - Release

### Released 2021-06-30

### Visual Studio Project System

#### Changes

- Fixed deploying sometime stop 20-30 seconds.
- Added warning when deploy an assembly larger than regions size.

#### Known Issues

- Sometimes a longer delay than usual during deployment. (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/660)
- Debug breakpoints sometimes hang for 5-6 seconds before resuming normally (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/659)

### Libraries

#### Changes

- Fixed USBClient WinUSB, Cdc failed when sending multiple of 64 bytes.
- Fixed UART crashed when enable handshaking on SC13xxx
- Fixed enabling SoftwarePWM cause Timer 16 stop working on SC13xxx


#### Known Issues

- https://github.com/ghi-electronics/TinyCLR-Libraries/issues?q=is%3Aissue+is%3Aopen+label%3Abug

### Firmware

#### Changes

##### SC20xxx:

- None.

##### SC13xxx

- Increased secure storage from 2K to 8K

 
#### Known Issues

- None.

### Drivers

#### Changes

- Added BasicNet.
- Add Rotary Encoder.
- Improved BasicGraphics performance.

#### Known Issues

- None.

### TinyCLR Config

#### Changes

- None.

#### Known Issues

- Erase all does not erase external flash.
- Sometimes fails to connect until board is reset.
    
### TinyCLR Font Converter

#### Changes

- None.

#### Known Issues

- None.

---

## 2.1.0 - RC2

### Released 2021-06-04

### Visual Studio Project System

#### Changes

- Fixed VS crashed sometime.
- Add C#9 template.

#### Known Issues

- Sometimes a longer delay than usual during deployment. (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/660)
- Debug breakpoints sometimes hang for 5-6 seconds before resuming normally (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/659)

### Libraries

#### Changes

- Added temperature sensor.
- SwapEndianness: Added support offset, count.
- Rewrite thread-safe Software I2C API.
- RTC: Added flag to detect internal RC used.
- Fixed Alarm wake up immediately if set period time more than 24 hours.
- Fixed Ethernet doesn't work on some modules.
- Improved ENC.
- Fixed UART event doesn't work if subscribe event after Enable().
- Fixed UART / CAN crashed if unsubscribe event.
- Fixed Digital Signal work incorrectly if large buffer.
- Fixed slow clock in RAM mode (non-persist) failed.
- Fixed PPP doesn't raise event if connection lost.
- Fixed PPP failed when call Disable().
- Fixed insert multi row failed SQLite.
- Enabled Threadsafe SQLite.
- Increase network socket from 20 to 32.
- Fixed IFU crashed when use memory stream and large external tca.


#### Known Issues

- https://github.com/ghi-electronics/TinyCLR-Libraries/issues?q=is%3Aissue+is%3Aopen+label%3Abug

### Firmware

#### Changes

- Improved SPI, SPI pins set to GPIO::High (they were very high that causes bad on MP3 click module).
- Fixed Shutdown still draw high power consumption after enable external ram.
- Add native NeoPixel driver.

##### SC20xxx

- Fixed Ethernet doesn't work on some modules.
- Improve ENC28J60.

##### SC13xxx

- Added 20KB to deployment.
- Fixed CDC.
- Added I2C4.

#### Known Issues

- None.

### Drivers

#### Changes

- Rewrote neopixel WS2812 natively, supporting 16/24 bit.
- Added managed file system (SD SPI).
- Improve OV9655 camera driver.

#### Known Issues

- None.

### TinyCLR Config

#### Changes

- Add support glb format (micropython firmware).

#### Known Issues

- Erase all does not erase external flash.
- Sometimes fails to connect until board is reset.
    
### TinyCLR Font Converter

#### Changes

- None.

#### Known Issues

- None.

---

## 2.1.0 - RC1

### Released 2021-04-26

### Visual Studio Project System

#### Changes

- Fixed generating assemblies take too long on large projects.
- Added System.Diagnostic to application template.
- Removed TCP/IP port.

#### Known Issues

- Sometimes a longer delay than usual during deployment. (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/660)
- Debug breakpoints sometimes hang for 5-6 seconds before resuming normally (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/659)

### Libraries

#### Changes

- Rework IFU API
- Add DataAvailable property to Stream.
- Rewrote USB stream timeout match to Network stream.
- Removed Application.Lock()
- Rewrote DeviceInformation class. Allow to set debug port, disable APP pin, lock debug...
- UI TextBox: Added border.
- Fixed missing PB14, PB15 GpioPin class.
- Add STM32L4, STM13048 GpioPin class.
- Add SHA1, HMAC-SHA1 cryptography.
- Moved VNC NuGet to drivers.
- Moved Media NuGet to drivers.
- Add GPIO low level allow transfer feature.
- JsonConverter supports enum.
- Fixed OTA doesn't work because SSID length hardcode to 3.
- Fixed crashed when flush partial rotate screen (native LCD).
- Fixed Enable/Disable has no effect with UART.
- Fixed CDC stop response with large package.
- Network: Fixed GetIPProperties sometime null.
- PWM: Fixed open channel fail then close the pin although the pin is reserved for other function.
- Remove checking Wakeup pin (PA0) if call Shutdown().

#### Known Issues

- https://github.com/ghi-electronics/TinyCLR-Libraries/issues?q=is%3Aissue+is%3Aopen+label%3Abug

### Firmware

#### Changes

- Signal PulseFeedback: Enable pullup or pulldown internally.
- Disable global interrupt when QSPI is writing/erasing.
- Raise exception if enable some configuration on non-support devices (example enable heap on SC20100)

##### SC20xxx

- Rework IFU.
- Rework deployment configuration.

##### SC13xxx

- Initial.

#### Known Issues

- None.

### Drivers

#### Changes

- Added Media NuGet.
- Fixed WAV play only 1 second.
- Added VNC NuGet.
- Fixed VNC allocate memory every frame
- Fixed VNC stop when much mouse events received.
- Added QR barcode.
- Added Infrared NecIR driver
- Added BasicGraphics (useful for low memory devices)
- Added ST7789 driver
- Deleted SPWF04Sx driver
- Added OneTimePassword
- Corrected Neopixel company name.
- Added DrawBufferNative on some screens don't support 16bit.
- Added TexasInstruments.ADC121
- Added Microchip.MCP4725
- Added ScaniaJ1939
- Added Gps.Nmea0183
- Wi-Fi OTA update: Timeout changed from integer to TimeSpan.
- Uniform SetColor(), Flush(), Clear() for all LEDs driver
- SetDrawWindow take argument (0, 0, width-1, hight-1) for full screen.

#### Known Issues

- None.

### TinyCLR Config

#### Changes

- Fixed USB friendly name duplicate.
- Detect GHI bootloader by GHI VID.
- Allow to set USB, Serial debug port, disable application pin.
- Detect mismatch versions.

#### Known Issues

- Erase all does not erase external flash.
- Sometimes fails to connect until board is reset.
    
### TinyCLR Font Converter

#### Changes

- None.

#### Known Issues

- None.

---

---

![TinyCLR Logo](images/tinyclr-logo-noborder.jpg)

## 2.1.0 - Preview4

### Released 2021-03-08

### Visual Studio Project System

#### Changes

- Prevent deploying an assembly that is larger than 6MB, not supported.

#### Known Issues

- Sometimes a longer delay than usual during deployment. (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/660)
- Debug breakpoints sometimes hang for 5-6 seconds before resuming normally (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/659)

### Libraries

#### Changes

- Added SetPersistDeviceName allows user set device name, mainly used for USB.
- USB host: Added Joystick.
- USB host: Rework HID polling interval.
- USBClient: Add BOS support WebUSB.
- USBClient: Correct endpoint bmAttribute for CDC/WinUSB.
- Fixed Graphic Flush() with custom size.
- Added convert RGB565 to RGB444.
- Added convert RGB565 to 1BPP.
- Rework VNC API.
- Fixed File System hangs when reach EOF.
- Added HMAC SHA256.
- Fixed Converter class hidden.
- Added 'Retry' NetworkStream (Send)
- Optimized ArrayList.
- Changed DeviceInformation.UniqueID from property to function.
- Fixed get power reset source incorrect.
- Added DigitalSignal Generator.
- GHIElectronics.TinyCLR.Pins: Rename Timer.Capture to Timer.DigitalSignal
- Added array Copy2D.
- IFU: Added activity led.
- Socket Send and Receive are now non-blocking.

#### Known Issues

- https://github.com/ghi-electronics/TinyCLR-Libraries/issues?q=is%3Aissue+is%3Aopen+label%3Abug+

### Firmware

#### Changes

- Fixed VS crash when set a breakpoint at bitmap array.
- Fixed PPP now automatically includes default TLS Entropy.
- Use Double-precision floating-point argument for compiling.
- Fixed could not deploy via USB debug after enabled USBClient controller.
- Fixed system slow after connected an HID device.
- APP button is free to use once disabled debug interface.
- Fixed reading EnableSlowClock flag might crash system.
- Random Class: Changed to hardware true random generator.
- Socket: Raise exception if Read/Write has timeout.
- Fixed exception when draw to N18 high SPI frequency.
- Fixed enable CAN2 corrupted CAN1 filter.
- Fix lag when set PWM in very low frequency.
- Fix DAC Controller GetDefault throws exception
- Added support wakeup pin by rising or failing edge.
- Raise OutOfMemory exception of Allocate unmanaged memory failed.

#### Known Issue

- None.

### Drivers

#### Changes

- Added Azure SAS generator.
- ST7735 support RGB444.
- Add ERC12864 (128x64).
- Fixed FT5xx6 touch has nothing when rotate screen.
- NeoPixel constructor supports software and hardware signal generator.
- Added resistive touch driver.

#### Known Issues

- None.

### TinyCLR Config

#### Changes

- Added update device name.
- Fixed Connect to Bootloader take long time.

#### Known Issues

- Erase all doesn't erase external flash.
- Sometimes fails to connect until board is reset.
    
### TinyCLR Font Converter

#### Changes

- None.

#### Known Issues

- None.

---

---

![TinyCLR Logo](images/tinyclr-logo-noborder.jpg)

## 2.1.0 - Preview3

### Released 2021-01-05

### Visual Studio Project System

#### Changes

- Updated version number 2.1.300

#### Known Issues

- Sometimes a longer delay than usual during deployment. (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/660)
- Debug breakpoints sometimes hang for 5-6 seconds before resuming normally (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/659)

### Libraries

#### Changes

- Updated version number 2.1.0-preview3.
- Change IFU API. Support network stream, file stream, memory stream.
- IFU: Support update firmware on SC20100.
- UART: Rename USART to UART
- Improved Digital Signal: Use double (fraction) for more accurate.
- Improve networking sending speed.
- WiFI: Fixed DHCP Server Null-pointer Exception
- Fixed DNS address not retrieved from DHCP
- Fixed WiFi: Socket closed if call Scan() 
- Graphic: Support Flush(x, y, width, height)
- Graphic: Support sending buffer to SPI display with custom size
- Graphic: Flush event support multi screens.
- Add DrawTextInRect
- Fixed Rotate Bitmap crash.
- Fixed SPI: support sending more than 64KB
- JSON: Support compact formatting.
- Fixed File open for read in share mode not work.
- UsbClient: Rename ByteToRead to BytesToRead 
- Slow Clock: Support persist mode.
- Add Software PWM.
- Add mDNS
- Add sampling time for ADC
- Add VNC

#### Known Issues

- Exception filter causes lockup when exception thrown from instance method (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/652)
- GetChars throwing on certain byte values (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/651)
- Double ToString() show number incorrectly sometime  (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/629)
- Running out of stack kills Visual studio (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/586)
- Network operations on any thread block all threads  (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/525)
- String does not implement IEnumerable  (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/323)
- Equals() throws unsupported instruction exception  (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/502)

### TinyCLR Config

#### Changes

- Updated version number 2.1.0-preview3 
- Add Persist slow clock option in Device Configuration.
- No longer support .glb file format.

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

- Updated version number 2.1.0.30000.
- Reduced external deployment size from 8MB to 6MB.
- Improved Network sending speed.

#### Known Issue

- None.

### Drivers

#### Changes

- Updated version number 2.1.0-preview3.
- Add motor servo driver.
- Add ILI9341 SPI 320x240 driver.

#### Known Issues

- None.

---

---

![TinyCLR Logo](images/tinyclr-logo-noborder.jpg)

## 2.1.0 - Preview2

### Released 2020-12-04

### Visual Studio Project System

#### Changes

- Updated version number 2.1.200

#### Known Issues

- Sometimes a longer delay than usual during deployment. (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/660)
- Debug breakpoints sometimes hang for 5-6 seconds before resuming normally (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/659)

### Libraries

#### Changes

- Updated version number 2.1.0-preview2.
- Fixed JSON Boolean type.
- Fixed MQTT IsConnected property never set to false
- Added WiFI AccessPoint mode
- Added DHCP Server for WiFi in AccessPoint mode.
- Fixed Tim.Capture.Controller5 and Tim.Capture.Controller2 swapped.
- Rewrite USBClient API (CDC and WinUsb) 
- Added Raw HID, Mouse (Absolute and Relative mode), Keyboard, Joystick for USBClient.

#### Known Issues

- Exception filter causes lockup when exception thrown from instance method (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/652)
- GetChars throwing on certain byte values (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/651)
- Double ToString() show number incorrectly sometime  (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/629)
- Running out of stack kills Visual studio (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/586)
- Network operations on any thread block all threads  (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/525)
- String does not implement IEnumerable  (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/323)
- Equals() throws unsupported instruction exception  (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/502)

### TinyCLR Config

#### Changes

- Updated version number 2.1.0-preview2 

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

- Updated version number 2.1.0.20000.
- Added AutoIP.
- Fixed CAN stop receiving message once internal FIFO is full.
- Fixed Reuse socket address doesn't work.
- Fixed Dns.GetHostEntry("") doesn't work.
- Fixed digital signal doesn't work at low frequency.
- Fixed WiFI doesn't connect to an Open AP.
- Fixed GPIO interrupt native timestamp not accurate.
- Fixed Set PWM in low frequency lock the system for long time.

#### Known Issue
- None.

### Drivers

#### Changes

- Updated version number 2.1.0-preview2.
- WinC15xx: Added Set/Remove multicast address.

#### Known Issues

 - SSD1351-Draw at position X may need offset = 10 to correct position. (https://github.com/ghi-electronics/TinyCLR-Drivers/issues/109)

---

---

![TinyCLR Logo](images/tinyclr-logo-noborder.jpg)

## 2.1.0 - Preview1

### Released 2020-11-03

### Visual Studio Project System

#### Changes

- Updated version number 2.1.100

#### Known Issues
- None

### Libraries

#### Changes

- Updated version number 2.1.0-preview1.
- Added Unique ID.
- Fixed Socket.Poll(-1) cause system slow.
- Fixed multicast.
- Correct SPI6 clock source.
- Prevent active USB client in USB debug mode.
- Fixed WiFi doesn't fire event when disconnected from a hotspot.
- Added analog temperature reading, VREFINT, VSENSE channels (GHIElectronics.TinyCLR.Pins)    
- Fixed UART RTS pin doesn't go high when buffer full.
- Fixed USB Host: FS.Unmount() failed without calling Flush()
- TFS: Improved and removed "StorageDriver".
- Storage: Added EraseAll() API.
- Fixed CAN 'CanWriteMessage' property always return true.
- Added DigitalSignal.
- System timer now is accurate.. 
- Supports slow clock mode (240MHz)
- Fixed JSON cannot deserialize long integers.
- Supports write out bitmap file (24 bit BMP format).
- Supports native CRC.
- Supports RegularExpression.
- Rename AdcChannel to ADC (GHIElectronics.TinyCLR.Pins)    
- Rename DacChannel to DAC (GHIElectronics.TinyCLR.Pins)
- Added Timer.Capture (GHIElectronics.TinyCLR.Pins)
- Added Timer.Pwm (GHIElectronics.TinyCLR.Pins - Changed from PwmChannel)    
- MQTT: Add MQTT pass the topic to the received message function. 
- Fixed Modbus TCP.
- Fixed UART parity Odd/Even doesn't work with 8 bit data.      
- Fixed initializing the ATWINC with null SSID and password hangs system.

#### Known Issues

- Sometimes a longer delay than usual during deployment. (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/660)
- Debug breakpoints sometimes hang for 5-6 seconds before resuming normally (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/659)
- Exception filter causes lockup when exception thrown from instance method (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/652)
- GetChars throwing on certain byte values (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/651)
- Double ToString() show number incorrectly sometime  (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/629)
- Running out of stack kills Visual studio (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/586)
- Network operations on any thread block all threads  (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/525)
- String does not implement IEnumerable  (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/323)
- Equals() throws unsupported instruction exception  (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/502)
- Empty string - Dns.GetHostEntry("") doesn't work https://github.com/ghi-electronics/TinyCLR-Libraries/issues/724

### TinyCLR Config

#### Changes
- Updated version number 2.1.0-preview1 

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

- Updated version number 2.1.0.10000
- Speed up system speed 15%
- Use Timer Counter (TIM) for system timer.
- Fixed SDCard writing failed sometime.
- Improved SDCard speed.
- Open HiRes Timer register for Marshal.
- Open TEMPERATURE_TS1_CALIBRATION, TEMPERATURE_TS2_CALIBRATION registers for Marshal.
- Open TTCAN, CAN clock calibration for Marshal.
- Graphics: Improved color table. Support color table for all modes (8888, 888, 565, 323).
- SC20260: Reduced power consumption SDRAM in Sleep and Shutdown mode.

#### Known Issue

- None.

### Drivers

#### Changes

- Updated version number 2.1.0-preview1

#### Known Issues

 - SSD1351-Draw at position X may need offset = 10 to correct position. (https://github.com/ghi-electronics/TinyCLR-Drivers/issues/109)

---

---

![TinyCLR Logo](images/tinyclr-logo-noborder.jpg)

## 2.0.0 - Release

### Released 2020-08-21

Production ready release!

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
- UART Rx buffer full doesn't make RTS pin go high (https://github.com/ghi-electronics/TinyCLR-Libraries/issues/669)

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

![TinyCLR Logo](images/tinyclr-logo-noborder.jpg)

## 2.0.0-RC2

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
- Export .tca file has smaller size.

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

- UART: Fixed can not release CTS, RTS pins when close UART
- UART: Enable FIFO mode.
- UART: Flush() will wait until last byte transfer completed.
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

![TinyCLR Logo](images/tinyclr-logo-noborder.jpg)

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
- UART: Break Signal need to wait to last byte transfer complete https://github.com/ghi-electronics/TinyCLR-Libraries/issues/634

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
- Green Ethernet LED is now activity indicator instead of link indicator.
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

- The ToString() method fails on structs, including GUID and enum.
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
- Added support for VBAT voltage monitoring.
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
- ToString() does not work if the argument is an enum.
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
- ToString() doesn't work if the argument is an enum.
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
