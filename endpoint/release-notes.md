# Release Notes

---

## **0.1.7 - Beta (2024-5-14)**

### Endpoint OS

- Changes
    - Added BlueZ stack for Bluetooth
	- Added Bluetooth drivers: Broadcom: BCM4335,BCM4350, BCM4356, BCM4371, BCM20702, BCM20703, BCM43142 
	- Added Bluetooth drivers: Realtek: RTL87xx 	
- Known Issues
    https://github.com/ghi-electronics/Endpoint-Libraries/issues
			
### Libraries

- Changes 
	- Core: Class Script supports event
- Known Issues
    https://github.com/ghi-electronics/Endpoint-Libraries/issues

### Drivers

- Changes
    - Added Bluetooth driver nuget
- Known Issues
    https://github.com/ghi-electronics/endpoint-drivers/issues

### Endpoint Config

- Changes
    - Added Set/Remove environment variables
- Known Issues
    https://github.com/ghi-electronics/Endpoint-Libraries/issues.

---


## **0.1.6.1 - Beta (2024-4-24)**

### Endpoint OS

- Changes
    - Fixed python library 
- Known Issues
    https://github.com/ghi-electronics/Endpoint-Libraries/issues
	
---

## **0.1.6 - Beta (2024-4-22)**

### Endpoint OS

- Changes
    - Add DMA for SPI
	- Support Network configuration from Endpoint tool 	
	- Suport MacOS (192.168.83.2)
	- Fix WiFi don't work with static IP	
- Known Issues
    https://github.com/ghi-electronics/Endpoint-Libraries/issues
	
### Visual Studio Extension

- Changes
	- Support debug over WiFi, Ethernet other than USB	
- Known Issues
    https://github.com/ghi-electronics/Endpoint-Libraries/issues

### Libraries

- Changes 
	- Network: WiFi and Ethernet, USB Ethernet can work at the same time
- Known Issues
    https://github.com/ghi-electronics/Endpoint-Libraries/issues

### Drivers

- Changes
    - Improved VirtualKeyboard driver	
- Known Issues
    https://github.com/ghi-electronics/endpoint-drivers/issues

### Endpoint Config

- Changes
    - Added Network configuration
- Known Issues
    https://github.com/ghi-electronics/Endpoint-Libraries/issues.

---

## **0.1.4 - Beta (2024-4-5)**

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

---

## **0.1.3 - Beta (2024-3-8)**

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

## **0.1.2 - Beta (2024-2-21)**

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

