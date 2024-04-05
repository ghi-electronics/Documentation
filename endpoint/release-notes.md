# Release Notes

---

## **0.1.4 - Beta (2024-5-4)**

### Endpoint OS
- Changes
	- Added Adc
	- Added PulseFeedback

### Libraries
- Changes
	- Added UI
	- Added Adc
	- Added PulseFeedback (DrainDuration, EchoDuration, DurationUntilEcho)
	- Display: Flush(..) supports flushing any size, anywhere within data buffer.
	
- Known Issues
    https://github.com/ghi-electronics/Endpoint-Libraries/issues		

## **0.1.3 - Beta (2024-8-3)**

### Endpoint OS

- Changes
    - Added native Watchdog library
	- Added Python (ADC, PWM, I2C, SPI, Serial, GPIO, Display, RTC)
	- Added USB_RTL8152 Ethernet
	- Added timezone info
- Known Issues
    https://github.com/ghi-electronics/Endpoint-Libraries/issues
	
### Visual Studio Extension


- Changes
	- Fixed deployment error when using extensions in languages other than English.
- Known Issues
    https://github.com/ghi-electronics/Endpoint-Libraries/issues

### VS Code Extension

#### .NET VS Code Extension

- Changes
    - None
- Known Issues
    https://github.com/ghi-electronics/Endpoint-Libraries/issues
	
#### Python VS Code Extension
- Changes
    - Initial Release
- Known Issues
    https://github.com/ghi-electronics/Endpoint-Libraries/issues

### Libraries

- Changes
    - SPI: Added change buffer_size 
	- ADC: Rename Read() to ReadRaw(). Add Read (scaled to 3.3V)
	- UART: Removed UART6. Fix UART5 does not work
	- Ethernet: Add USB
- Known Issues
    https://github.com/ghi-electronics/Endpoint-Libraries/issues

### Drivers

- Changes
    - Added VirtualKeyboard nuget
	- Added ST7735 SPI display nuget
- Known Issues
    https://github.com/ghi-electronics/endpoint-drivers/issues

### Endpoint Config

- Changes
    - Fixed 800x480 bootscreen setting
- Known Issues
    https://github.com/ghi-electronics/Endpoint-Libraries/issues.
	
---

## **0.1.2 - Beta (2024-21-2)**

### Endpoint OS

- Changes
    - Added OpenCV
	- Support Bootscreen
- Known Issues
    https://github.com/ghi-electronics/Endpoint-Libraries/issues
	
### Visual Studio Extension

- Changes
    - Improved deploying speed
- Known Issues
    https://github.com/ghi-electronics/Endpoint-Libraries/issues

### VS Code Extension

- Changes
    - Fixed Ctrl+Shift+B doesn't work on non-Windows system
- Known Issues
    https://github.com/ghi-electronics/Endpoint-Libraries/issues

### Libraries

- Changes
    - Fixed can't initialize multiple ports: https://github.com/ghi-electronics/Endpoint-Libraries/issues/48
- Known Issues
    https://github.com/ghi-electronics/Endpoint-Libraries/issues

### Drivers

- Changes
    - Add Avalonia Touch input driver
- Known Issues
    https://github.com/ghi-electronics/endpoint-drivers/issues

### Endpoint Config

- Changes
    - Add Enable Bootscreen setting
- Known Issues
    https://github.com/ghi-electronics/Endpoint-Libraries/issues.
	
---

## **0.1.0 - Beta (2024-2-2)**

### Endpoint OS

- Initial Release
- Known Issues
    https://github.com/ghi-electronics/Endpoint-Libraries/issues

### Visual Studio Extension

- Initial Release
- Known Issues
    https://github.com/ghi-electronics/Endpoint-Libraries/issues

### VS Code Extension

- Initial Release
- Known Issues
    https://github.com/ghi-electronics/Endpoint-Libraries/issues

### Libraries

- Initial Release
- Known Issues
    - None.

### Drivers

- Initial Release
- Known Issues
    https://github.com/ghi-electronics/endpoint-drivers/issues

### Endpoint Config

- Initial Release

