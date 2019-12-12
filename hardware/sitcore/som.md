# SITCore System on Modules
---
![G400S](images/uc5550.jpg)

## Overview
The SITCore SoMs provide a low cost way to add .NET computing power to any embedded product. They are available as a 200 pin SO-DIMM with and without WiFi (G400 compatible), a 91 pad surface mount module (G120 compatible), or a 105 pad surface mount module (G120E compatible). The SITCore SoMs let's you design IoT products that are secure, easily integrated with the cloud, and can be easily managed and updated from the cloud for deployments of one to a million or more. The surface mount versions are great for harsh or high vibration environments.

## Ordering Part Number
* 91 Pad Surface Mount: SC20260N
* 200 Pin SO-DIMM: SC20260D

## Specifications

| Spec               | All SITCore SoMs          |
|--------------------|---------------------------|
| Processor Type     | ARM Coretex-M7 32 Bit     |
| Speed              | 480 MHz                   |
| Internal RAM       | 1 MByte                   |
| Internal Flash     | 2 MByte                   |
| Instruction Cache  | 16 KByte                  |
| Data Cache         | 16 KByte                  |
| Temperature Range  | -40C to +85C              |

*Note: Resources are shared between your application and the operating system.*

## Peripherals

| Peripheral            | SC20260N               | SC20260E               | SC20260D               |
|-----------------------|------------------------|------------------------|------------------------|
| GPIO (all support IRQ)|                        |                        |                        |
| SPI                   | 3                      | 3                      | 3                      |
| I2C                   | 2                      | 3                      | 3                      |
| UART/USART            | 7 (4 with handshaking) | 8 (4 with handshaking) | 8 (4 with handshaking) |
| CAN                   | 2                      | 2                      | 2                      |
| PWM                   | 21                     | 23                     | 27                     |
| ADC                   | 21                     | 21                     | 21                     |
| DAC                   | 2                      | 2                      | 2                      |
| SD/SDIP/MMC           | 1                      | 1                      | 1                      |
| Quad SPI              | 1                      | 1                      | 1                      |
| USB Host              | 1                      | 1                      | 1                      |
| USB Client            | 1                      | 1                      | 1                      |
| Ethernet              | 1                      | 1                      | 1                      |
| LCD TFT               | 1                      | 1                      | 1                      |
| Camera                | 1                      | 1                      | 1                      |

*Note: As many pins share peripherals, not all peripherals will be available.*

## Features
* Low power modes including three independently controllable power domains
* RTC
* Watchdog
* Threading
* TCP/IP with SSL
  * Full .NET socket interface
  * Ethernet
  * PPP
* Graphics
  * Images
  * Fonts
  * Controls
* File System
  * Full .NET file interface
  * SD cards
  * USB drives
* Native extensions
  * Runtime Loadable Procedures
  * Device register access
* Signal controls
  * Generation
  * Capture
  * Pulse measurement
    
## SCM20260D Pinout

| SO-DIMM Pin   | Function Name                                    |
|---------------|--------------------------------------------------|
| 1             | Analog GND                                       |
| 2             | ETH PHY TX-                                      |
| 3             | NC                                               |
| 4             | ETH PHY TX+                                      |
| 5             | Analog VREF-                                     |
| 6             | ETH PHY RX-                                      |
| 7             | NC                                               |
| 8             | ETH PHY RX+                                      |
| 9             | NC                                               |
| 10            | ETH PHY LED SPEED                                |
| 11            | ETH PHY LED LINK                                 |
| 12            | NC                                               |
| 13            | GND                                              |
| 14            | PH9/DCMI D0/TIM12 CH2                            |
| 15            | PH10/DCMI D1                                     |
| 16            | PG10/DCMI D2                                     |
| 17            | PH12/DCMI D3/TIM5 CH3                            |
| 18            | PE4/DCMI D4                                      |
| 19            | PI4/DCMI D5                                      |
| 20            | Analog 3.3V                                      |
| 21            | PE5/DCMI D6/TIM15 CH1                            |
| 22            | PE6/DCMI D7/TIM15 CH2                            |
| 23            | PG9/DCMI VSYNC                                   |
| 24            | PA4/DCMI HSYNC/ADC12 INP18/DAC1                  |
| 25            | PA6/DCMI PIXCLK/TIM13 CH1/ADC12 INP3             |
| 26            | PA8/DCMI XCLK                                    |
| 27            | GND                                              |
| 28            | NC                                               |
| 29            | NC                                               |
| 30            | NC                                               |
| 31            | NC                                               |
| 32            | Analog VREF+                                     |
| 33            | NC                                               |
| 34            | NC                                               |
| 35            | PDR ON                                           |
| 36            | PA0 C/ADC12 INP0                                 |
| 37            | PA1 C/ADC12 INP1                                 |
| 38            | PC2 C/ADC3 INP0                                  |
| 39            | PC3 C/ADC3 INP1                                  |
| 40            | GND                                              |
| 41            | GND                                              |
| 42            | NC                                               |
| 43            | NC                                               |
| 44            | NC                                               |
| 45            | NC                                               |
| 46            | 3.3V                                             |
| 47            | NC                                               |
| 48            | NC                                               |
| 49            | NC                                               |
| 50            | NC                                               |
| 51            | GND                                              |
| 52            | NC                                               |
| 53            | NC                                               |
| 54            | NC                                               |
| 55            | NC                                               |
| 56            | NC                                               |
| 57            | PJ10/SPI5 MOSI                                   |
| 58            | PK0/SPI5 SCK                                     |
| 59            | PJ11/SPI5 MISO/TIM1 CH2                          |
| 60            | 3.3V                                             |
| 61            | PF6/UART7 RX/ADC3 INP8                           |
| 62            | PF7/UART7 TX/ADC3 INP3                           |
| 63            | PF8/UART7 RTS/TIM13 CH1/ADC3 INP7                |
| 64            | PF9/UART7 CTS/TIM14 CH1/ADC3 INP2                |
| 65            | GND                                              |
| 66            | PB10/OTG HS ULPI D3/I2C2 SCL                     |
| 67            | PB11/OTG HS ULPI D4/I2C2 SDA                     |
| 68            | PA9/USART1 TX                                    |
| 69            | PA10/USART1 RX                                   |
| 70            | NC                                               |
| 71            | NC                                               |
| 72            | 3.3V                                             |
| 73            | NC                                               |
| 74            | NC                                               |
| 75            | NC                                               |
| 76            | NC                                               |
| 77            | NC                                               |
| 78            | NC                                               |
| 79            | GND                                              |
| 80            | NC                                               |
| 81            | NC                                               |
| 82            | NC                                               |
| 83            | NC                                               |
| 84            | NC                                               |
| 85            | NC                                               |
| 86            | NC                                               |
| 87            | NC                                               |
| 88            | 3.3V                                             |
| 89            | NC                                               |
| 90            | NC                                               |
| 91            | PB0/UART4 CTS/OTG HS ULPI D1/TIM3 CH3/ADC12 INP9 |
| 92            | PG6                                              | 
| 93            | PH7/I2C3 SCL                                     |
| 94            | PH8/I2C3 SDA                                     |
| 95            | GND                                              |
| 96            | PA15/UART4 RTS/I2S3 WS/TIM2 CH1                  |
| 97            | PA0/TIM5 CH1/ADC1 INP16/WKUP                     |
| 98            | PH13/FDCAN1 TX/UART4 TX                          |
| 99            | PH14/FDCAN1 RX/UART4 RX                          |
| 100           | PH6/TIM12 CH1                                    |
| 101           | PH11/TIM5 CH2                                    |
| 102           | PD5/USART2 TX                                    |
| 103           | PD6/USART2 RX                                    |
| 104           | PF10/ADC3 INP6                                   |
| 105           | PI0/TIM5 CH4                                     |
| 106           | 3.3V                                             |
| 107           | PB4/SPI3 MISO/I2S3 SDI                           |
| 108           | PB5/SPI3 MOSI/I2S3 SDO/OTG HS ULPI D7            |
| 109           | PB3/SPI3 SCK/I2S3 SCK/TIM2 CH2                   |
| 110           | PC0/OTG HS ULPI STP/ADC123 INP10                 |
| 111           | PB7/TIM4 CH2/APP                                 |
| 112           | PI5/TIM8 CH1                                     |
| 113           | GND                                              |
| 114           | PB1/OTG HS ULPI D2/TIM3 CH4/ADC12 INP5           |
| 115           | PB9/I2C1 SDA/TIM17 CH1                           |
| 116           | PB8/I2C1 SCL/TIM16 CH1                           |
| 117           | PB12/OTG HS ULPI D5/FDCAN2 RX/UART5 RX           |
| 118           | PB13/OTG HS ULPI D6/FDCAN2 TX/UART5 TX           |
| 119           | PA5/OTG HS ULPI CK/ADC12 INP19/DAC2              |
| 120           | PD4/USART2 RTS                                   |
| 121           | PD3/USART2 CTS                                   |
| 122           | PI9                                              |
| 123           | PC8/SDMMC1 D0/UART5 RTS                          |
| 124           | 3.3V                                             |
| 125           | PD2/SDMMC1 CMD                                   |
| 126           | PC12/SDMMC1 CK                                   |
| 127           | PC9/SDMMC1 D1/UART5 CTS                          |
| 128           | PC10/SDMMC1 D2/USART3 TX                         |
| 129           | PC11/SDMMC1 D3/USART3 RX                         |
| 130           | PI7/TIM8 CH3                                     |
| 131           | GND                                              |
| 132           | PC13/WKUP2/TAMPER                                |
| 133           | PI6/TIM8 CH2                                     |
| 134           | PE3/LDR                                          |
| 135           | PD7/MOD                                          |
| 136           | PI11                                             |
| 137           | PI8                                              |
| 138           | PJ13                                             |
| 139           | PG12                                             |
| 140           | PC6/USART6 TX/TIM3 CH1                           |
| 141           | PC7/USART6 RX/I2S3 MCK/TIM3 CH2                  |
| 142           | 3.3V                                             |
| 143           | PI13/LCD VSYNC                                   |
| 144           | PI12/LCD HSYNC                                   |
| 145           | PI14/LCD CLK                                     |
| 146           | PK7/LCD DE                                       |
| 147           | PJ0                                              |
| 148           | PJ1                                              |
| 149           | PJ7                                              |
| 150           | PJ14                                             |
| 151           | GND                                              |
| 152           | PJ15/LCD B3                                      |
| 153           | PK3/LCD B4                                       |
| 154           | PK4/LCD B5                                       |
| 155           | PK5/LCD B6                                       |
| 156           | PK6/LCD B7                                       |
| 157           | PC2/ADC123 INP12                                 |
| 158           | PC3/ADC12 INP13                                  |
| 159           | PA3/OTG HS ULPI D0/TIM2 CH4/ADC12 INP15          |
| 160           | 3.3V                                             |
| 161           | PI15/LCD G2                                      |
| 162           | PJ12/LCD G3                                      |
| 163           | PH15/LCD G4                                      |
| 164           | PH4/LCD G5/ADC3 INP15                            |
| 165           | PK1/LCD G6/TIM1 CH1                              |
| 166           | PG7                                              |
| 167           | PJ9/UART8 RX/TIM1 CH3                            |
| 168           | PJ6/LCD R7                                       |
| 169           | GND                                              |
| 170           | PK2/LCD G7                                       |
| 171           | PJ2/LCD R3                                       |
| 172           | PJ3/LCD R4                                       |
| 173           | PJ4/LCD R5                                       |
| 174           | PJ5/LCD R6                                       |
| 175           | PI1/SPI2 SCK                                     |
| 176           | PI2/SPI2 MISO/TIM8 CH4                           |
| 177           | NC                                               |
| 178           | PI3/SPI2 MOSI                                    |
| 179           | NC                                               |
| 180           | 3.3V                                             |
| 181           | NC                                               |
| 182           | NC                                               |
| 183           | VBAT                                             |
| 184           | NC                                               |
| 185           | GND                                              |
| 186           | GND                                              |
| 187           | RESET                                            |
| 188           | USBH P                                           |
| 189           | NC                                               |
| 190           | USBH N                                           |
| 191           | BOOT0                                            |
| 192           | 3.3V                                             |
| 193           | NC                                               |
| 194           | USBC P                                           |
| 195           | NC                                               |
| 196           | USBC N                                           |
| 197           | PA14/JTCK/SWCLK                                  |
| 198           | GND                                              |
| 199           | PA13/JTMS/SWDIO                                  |
| 200           | PJ8/UART8 TX                                     |
                                                                                                   

## Device Startup
The SITCore is held in reset when the reset pin is low. Releasing it will begin the system startup process.

There are three different components of the device firmware:
1. GHI Bootloader: initializes the system, updates TinyCLR when needed, and executes TinyCLR.
2. TinyCLR: loads, debugs, and executes the managed application.
3. Managed application: the program developed by the customer.

Which components get executed on startup can be control by manipulating the LDR0 pin. It is pulled high on
startup. When low, the device waits in the GHI Bootloader. Otherwise, the managed application is executed. LDR1
is reserved for future use.

Additionally, the communications interface between the host PC and the SITCore is selected on startup through the
MODE pin, which is pulled high on startup. The USB interface is selected when MODE is high and COM1 is selected
when MODE is low.

The above discussed functions of LDR0, LDR1, and MODE are only during startup. After startup, they return to the
default GPIO state and are available to use as GPIO in the user application

## TinyCLR OS
TinyCLR OS provides a way to program the SITCore in C# or Visual Basic from the Microsoft Visual Studio integrated development environment.  To get started you must first install the firmware on the SITCore (instructions below) and then go to the TinyCLR [Getting Started](../../software/tinyclr/getting-started.md) page for instructions.

### Loading the Firmware

1. Activate the bootloader, hold the LDR0 signal low while resetting the board.
2. Open [TinyCLR Config](../../software/tinyclr/tinyclr-config.md) tool.
3. Click the loader tab.
4. Select the correct COM port. If you are not seeing it then the device is not in the loader mode.
5. Click the `Update to Latest` button.

You can also update the firmware manually. Download the [firmware](../../software/tinyclr/downloads.md) and learn how to use the [GHI Bootloader](../../hardware/loaders/ghi-bootloader.md) manually

### Loading the Bootloader
1. Download the SITCore bootloader [here](../../hardware/loaders/ghi-bootloader.md).
2. Connect your device to the USB client port.
3. Put the board in DFU mode: Hold the SYS A pin low and press/release the reset button. Wait for a second then release SYS A. Windows *Device Manager* will now show "STM Device in DFU Mode" under the 'Universal Serial Bus controller' TAB.
4. Go to the [STM32 Bootloader](../../hardware/loaders/stm32-bootloader.md) to learn how to upload DFU files.

### Loading the Firmware
1. Activate the bootloader, hold the LDR0 signal (SYS B) low while resetting the board.
2. Open [TinyCLR Config](../../software/tinyclr/tinyclr-config.md) tool.
3. Click the loader tab.
4. Select the correct COM port. If you are not seeing it then the device is not in the loader mode.
5. Click the `Update to Latest` button.

You can also update the firmware manually. Download the [firmware](../../software/tinyclr/downloads.md) and learn how to use the [GHI Bootloader](../../hardware/loaders/ghi-bootloader.md) manually.

### Start Coding
Now that you have installed the bootloader and firmware on the SITCore, you can setup your host computer and start programming.  Go to the TinyCLR [Getting Started](../../software/tinyclr/getting-started.md) page for instructions.

## Datasheet

## Design Considerations

## Footprints

We recommend no traces or vias under the module. Dimensions are in inches.

### SC20260N Recommended Footprint
![SC20260N Pinout](images/g120-footprint.jpg)

### SC20260E Recommended Footprint
![SC20260E Footprint](images/scm20260e-footprint.jpg)

### SC20260D SO-DIMM Socket
![200 pin DDR2 SO-DIMM socket](images/200-pin-ddr2-so-dimm.jpg)

The SC20260D and SC20260W use the same 200 pin SO-DIMM socket that was originally made for DDR2 memory modules. You can make a custom SO-DIMM SITCore circuit board by adding the appropriate SO-DIMM socket to your circuit board.

> [!Tip]
> Make sure to expose the required pins in your design. Specific pins are needed for device programming, updates, recovery, and WiFi firmware updates. See device specifications for details.

SO-DIMM stands for Small Outline Dual Inline Memory Module. There are two different 200 pin SO-DIMM sockets, those made for DDR memory and those made for DDR2 memory. They are identical except for the orientation notch which is in a slightly different position. These sockets are not interchangeable. There is also a 204 pin SO-DIMM socket for DDR3 memory with the notch positioned closer to the center of the module.

> [!Note]
> Our UCMs are only compatible with DDR2 type 200 pin SO-DIMM sockets.

Here is a link to the manufacturer's web page for the connector we use on our boards: [EMBOSS ASSY DDR2 SODIMM SOCKET 200P 5.2H](http://www.te.com/usa-en/product-1565917-4.html)

### Required Pins
Exposing the following pins is required in every design to enable device programming, updates, and recovery:
* LDR0
* LDR1
* Reset
* Desired debug interface(s)
* MODE if required to select a debug interface

### Power Supply
A typical clean power source, suited for digital circuitry, is needed to power the SITCore SoCs. Voltages should be within at
least 10% of the specified voltage. Decoupling capacitors of 0.1 uF are needed near every power pin. Additionally, a
large capacitor, typically 47 uF, should be near the G80 if the power supply is more than few inches away.

### Crystals
The SITCore requires an external 8 MHz crystal and associated circuitry to function. For the RTC to function, a 32.768
kHz crystal and circuitry are required. Please see the processor's documentation for advanced information.

### Reset
The reset pin is not pulled in any direction. Designs must be sure to use an appropriate pull-up resistor.

### Oven Reflow Profile

## SITCore Development Board
