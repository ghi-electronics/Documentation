# SITCore System on Chip
---
![SITCore SC20260](images/sc20100-board.jpg)

## Overview
The SITCore SoCs provide a low cost way to add .NET computing power to any embedded product. Available as either a 100 pin LQFP or a 265 ball BGA, the SITCore SoCs let you design IoT products that are secure, easily integrated with the cloud, and can be easily managed and updated from the cloud for deployments of one to a million or more.

## Ordering Part Number
* 100 Pin LQFP: SC20100S
* 100 Ball BGA: SC20100B
* 265 Ball BGA: SC20260B

## Specifications

| Spec               | SC20100x                  | SC20260B             |
|--------------------|---------------------------|----------------------|
| Processor          | STM32H743VIT6             | STM32H743XIH6        |
| Core               | ARM Cortex-M7 32 bit      | ARM Cortex-M7 32 bit |
| Speed              | 480 MHz                   | 480 MHz              |
| Internal RAM       | 1 MByte                   | 1 MByte              |
| Internal Flash     | 2 MByte                   | 2 MByte              |
| Instruction Cache  | 16 KByte                  | 16 KByte             |
| Data Cache         | 16 KByte                  | 16 KByte             |
| Package            | LQFP100 14 x 14 mm        | 265-TFBGA 14 x 14 mm |
| Temperature Range  | -40C to +85C              | -40C to +85C         |

*Note: Resources are shared between your application and the operating system.*

## Peripherals

| Peripheral            | SC20100                   | SC20260               |
|-----------------------|---------------------------|-----------------------|
| GPIO (all support IRQ)|                           |                       |
| SPI                   | 4                         | 3                     |
| I2C                   | 3                         | 3                     |
| UART/USART            | 8 (4 with handshaking)    | 8 (4 with handshaking)|
| CAN                   | 2                         | 2                     |
| PWM                   | 19                        | 27                    |
| ADC                   | 11                        | 21                    |
| DAC                   | 2                         | 2                     |
| SD/SDIP/MMC           | 1                         | 1                     |
| Quad SPI              | 1                         | 1                     |
| USB Host              | 1                         | 1                     |
| USB Client            | 1                         | 1                     |
| Ethernet              | 1                         | 1                     |
| LCD TFT               | 0                         | 1                     |
| Camera                | 0                         | 1                     |

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
    
## Pinouts
### SC20100S Pinout
| LQFP100 Pin # | Function Name                                         |
|---------------|-------------------------------------------------------|
| 1             | PE2/QUADSPI BK1 IO2                                   |
| 2             | PE3/LDR                                               |
| 3             | PE4                                                   |
| 4             | PE5                                                   |
| 5             | PE6                                                   |
| 6             | VBAT                                                  |
| 7             | PC13/WKUP2/TAMPER                                     |
| 8             | PC14/OSC32 IN                                         |
| 9             | PC15/OSC32 OUT                                        |
| 10            | Vss                                                   |
| 11            | Vdd                                                   |
| 12            | PH0/OSC IN                                            |
| 13            | PH1/OSC OUT                                           |
| 14            | NRST                                                  |
| 15            | PC0/OTG HS ULPI STP/ADC123 INP10                      |
| 16            | PC1/ETH MDC                                           |
| 17            | PC2 C/SPI2 MISO/OTG HS ULPI DIR                       |
| 18            | PC3 C/SPI2 MOSI/OTG HS ULPI NXT                       |
| 19            | Vssa                                                  |
| 20            | Vref+                                                 |
| 21            | Vdda                                                  |
| 22            | PA0 C/ADC12 INP0                                      |
| 23            | PA1/ETH MII RX CLK                                    |
| 24            | PA2/ETH MDIO                                          |
| 25            | PA3/OTG HS ULPI D0/TIM2 CH4/ADC12 INP15               |
| 26            | Vss                                                   |
| 27            | Vdd                                                   |
| 28            | PA4/ADC12 INP18/DAC1                                  |
| 29            | PA5/SPI6 SCK/OTG HS ULPI CK/ADC12 INP19/DAC2          |
| 30            | PA6/SPI6 MISO/TIM13 CH1/ADC12 INP3                    |
| 31            | PA7/SPI6 MOSI/TIM14 CH1/ADC12 INP7/ETH RMII CRS DV    |
| 32            | PC4/ETH RMII RXD0                                     |
| 33            | PC5/ETH RMII RXD1                                     |
| 34            | PB0/UART4 CTS/OTG HS ULPI D1/TIM3 CH3/ADC12 INP9      |
| 35            | PB1/OTG HS ULPI D2/TIM3 CH4/ADC12 INP5                |
| 36            | PB2/QUADSPI CLK                                       |
| 37            | PE7/UART7 RX                                          |
| 38            | PE8/UART7 TX                                          |
| 39            | PE9/UART7 RTS/TIM1 CH1                                |
| 40            | PE10/UART7 CTS                                        |
| 41            | PE11/TIM1 CH2                                         |
| 42            | PE12/SPI4 SCK                                         |
| 43            | PE13/SPI4 MISO                                        |
| 44            | PE14/SPI4 MOSI                                        |
| 45            | PE15                                                  |
| 46            | PB10/PB10/OTG HS ULPI D3/I2C2 SCL/ETH MII RX ER       |
| 47            | PB11/OTG HS ULPI D4/I2C2 SDA/ETH RMII TX EN           |
| 48            | Vcap                                                  |
| 49            | Vss                                                   |
| 50            | Vdd                                                   |
| 51            | PB12/OTG HS ULPI D5/FDCAN2 RX/UART5 RX/ETH RMII TXD0  |
| 52            | PB13/OTG HS ULPI D6/FDCAN2 TX/UART5 TX/ETH RMII TXD1  |
| 53            | PB14/OTG HS D-                                        |
| 54            | PB15/OTG HS D+                                        |
| 55            | PD8/USART3 TX                                         |
| 56            | PD9/USART3 RX                                         |
| 57            | PD10                                                  |
| 58            | PD11/QUADSPI BK1 IO0                                  |
| 59            | PD12/QUADSPI BK1 IO1                                  |
| 60            | PD13/QUADSPI BK1 IO3                                  |
| 61            | PD14                                                  |
| 62            | PD15                                                  |
| 63            | PC6/USART6 TX/TIM3 CH1                                |
| 64            | PC7/USART6 RX/I2S3 MCK/TIM3 CH2                       |
| 65            | PC8/SDMMC1 D0/UART5 RTS                               |
| 66            | PC9/SDMMC1 D1/UART5 CTS                               |
| 67            | PA8                                                   |
| 68            | PA9/USART1 TX                                         |
| 69            | PA10/USART1 RX                                        |
| 70            | PA11/OTG FS D-                                        |
| 71            | PA12/OTG FS D+                                        |
| 72            | PA13/JTMS/SWDIO                                       |
| 73            | Vcap                                                  |
| 74            | Vss                                                   |
| 75            | Vdd                                                   |
| 76            | PA14/JTCK/SWCLK                                       |
| 77            | PA15/UART4 RTS/I2S3 WS/TIM2 CH1                       |
| 78            | PC10/SDMMC1 D2/USART3 TX                              |
| 79            | PC11/SDMMC1 D3/USART3 RX                              |
| 80            | PC12/SDMMC1 CK                                        |
| 81            | PD0/FDCAN1 RX/UART4 RX                                |
| 82            | PD1/FDCAN1 TX/UART4 TX                                |
| 83            | PD2/SDMMC1 CMD                                        |
| 84            | PD3/USART2 CTS                                        |
| 85            | PD4/USART2 RTS                                        |
| 86            | PD5/PD5/USART2 TX                                     |
| 87            | PD6/USART2 RX                                         |
| 88            | PD7/MOD                                               |
| 89            | PB3/SPI3 SCK/I2S3 SCK/TIM2 CH2                        |
| 90            | PB4/SPI3 MISO/I2S3 SDI                                |
| 91            | PB5/SPI3 MOSI/I2S3 SDO/OTG HS ULPI D7                 |
| 92            | PB6/QUADSPI BK1 NCS                                   |
| 93            | PB7/APP/TIM4 CH2                                      |
| 94            | BOOT0                                                 |
| 95            | PB8/I2C1 SCL/TIM16 CH1                                |
| 96            | PB9/I2C1 SDA/TIM17 CH1                                |
| 97            | PE0/UART8 RX                                          |
| 98            | PE1/UART8 TX                                          |
| 99            | Vss                                                   |
| 100           | Vdd                                                   |

## Device Startup
The SITCore is held in reset when the reset pin is low. Releasing it will begin the system startup process.

There are three different components of the device firmware:
1. GHI Bootloader: Initializes the system, updates TinyCLR when needed, and executes TinyCLR.
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

### Footprints
####This is the recommened footprint for the SC20100S:
![SC20100S Footprint](images/sc20100s-footprint.gif)

####This is the recommended footprint and PCB design rules for the SC20100B:
![SC20100B Footprint](images/sc20100b-footprint.gif)
![SC20100B Design Rules](images/sc20100b-design-rules.gif)

####This is the recommended footprint and PCB design rules for the SC20260B:
![SC20260B Footprint](images/sc20260b-footprint.gif)
![SC20260B Design Rules](images/sc20260b-design-rules.gif)


### Required Pins
Exposing the following pins is required in every design to enable device programming, updates, and recovery:
* LDR
* APP
* RESET
* MOD (if required to select a debug interface)

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
