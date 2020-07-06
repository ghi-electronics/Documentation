# SITCore System on Chip
---
![SITCore SC20100S](images/system-on-chip.jpg)

## Overview
The SITCore SoCs provide a low cost way to add .NET computing power to any embedded product. Available as either a 100 pin LQFP or a 265 ball BGA, the SITCore SoCs let you design IoT products that are secure, easily integrated with the cloud, and can be easily managed and updated from the cloud for deployments of one to a million or more.

## Specifications

| Spec                   | SC20100S                  | SC20260B             |
|------------------------|---------------------------|----------------------|
| **Core**               | ARM Cortex-M7 32 bit      | ARM Cortex-M7 32 bit |
| **Speed**              | 480 MHz                   | 480 MHz              |
| **Internal RAM**       | 1 MByte                   | 1 MByte              |
| **Internal Flash**     | 2 MByte                   | 2 MByte              |
| **Instruction Cache**  | 16 KByte                  | 16 KByte             |
| **Data Cache**         | 16 KByte                  | 16 KByte             |
| **Package**            | LQFP100 14 x 14 mm        | 265-TFBGA 14 x 14 mm |
| **Temperature Range**  | -40C to +85C              | -40C to +85C         |

*Note: Resources are shared between your application and the operating system.*

## Peripherals

| Peripheral                 | SC20100S                  | SC20260B              |
|----------------------------|---------------------------|-----------------------|
| **GPIO**                   | 76                        | 164                   |
| **SPI**                    | 3                         | 3                     |
| **I2C**                    | 2                         | 3                     |
| **UART**                   | 8 (4 with handshaking)    | 8 (4 with handshaking)|
| **CAN**                    | 2                         | 2                     |
| **PWM**                    | 16                        | 29                    |
| **ADC**                    | 12                        | 21                    |
| **DAC**                    | 2                         | 2                     |
| **SD/SDIP/MMC**            | 1                         | 1                     |
| **USB Host**               | 1                         | 1                     |
| **USB Client**             | 1                         | 1                     |
| **Ethernet**               | 1                         | 1                     |
| **LCD TFT**                | 0                         | 1                     |
| **Camera**                 | 0                         | 1                     |

*Note: As many pins share peripherals, not all peripherals will be available.*

### Using Interrupts (IRQs)

The microcontrollers we use in our SITCore line of products do not support concurrent interrupts with the same pin number, even if the pins are on different ports (the port is denoted by the second letter of the GPIO pin name -- PA1 is pin 1 on port A). Therefore, interrupts are available on only 16 pins at any given time. For example, pins PA1 and PB1 cannot be used as interrupt pins at the same time, but PA1 and PB2 can. PA1 and PA2 can also be used with interrupts simultaneously.

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
[![SC20100S Pinout](images/sc20100s-pinout.gif)](pdfs/sc20100s-pinout.pdf)

### SC20260B Pinout
[![SC20260B Pinout](images/sc20260b-pinout.gif)](pdfs/sc20260b-pinout.pdf)

## Device Startup
The SITCore is held in reset while the RESET pin is low. Releasing RESET will begin the system startup process.

There are three different components of the device firmware:
1. GHI Electronics Bootloader: initializes the system, updates TinyCLR when needed, and executes TinyCLR.
2. TinyCLR: used to load, debug, and execute the managed application.
3. Managed application: the program developed by you or your software developer.

Which components get executed on startup is controlled by manipulating the LDR pin. It is pulled high on startup during normal program execution. When low, the device waits in the GHI Electronics Bootloader. Otherwise, the managed application is executed. The APP pin is used to stop the application from running.

Additionally, the communications interface between the host PC and the SITCore is selected on startup through the MOD pin, which is pulled high on startup. The USB interface is selected when MOD is high and UART1 is selected when MOD is low.

The above discussed functions of the LDR, APP, and MOD pins are only available during startup. After startup, the pins return to the default GPIO state and are available as a GPIO (or peripheral pin) in your application. Check out the [Special Pins](../../software/tinyclr/special-pins.md) page for more information.

## TinyCLR OS
TinyCLR OS provides a way to program the SITCore in C# or Visual Basic from the Microsoft Visual Studio integrated development environment.  To get started you must first install the firmware on the SITCore (instructions below) and then go to the TinyCLR [Getting Started](../../software/tinyclr/getting-started.md) page for instructions.

### Loading the Firmware

1. Activate the bootloader, hold the LDR signal low while resetting the board.
2. Open [TinyCLR Config](../../software/tinyclr/tinyclr-config.md) tool.
3. Click the loader tab.
4. Select the correct COM port. If you are not seeing it then the device is not in the loader mode.
5. Click the `Update to Latest` button.

You can also update the firmware manually. Download the [firmware](../../software/tinyclr/downloads.md) and learn how to use the [GHI Electronics Bootloader](../../software/tinyclr/bootloader.md) manually

### Start Coding
Now that you have installed the bootloader and firmware on the SITCore, you can setup your host computer and start programming.  Go to the TinyCLR [Getting Started](../../software/tinyclr/getting-started.md) page for instructions.

## Design Considerations

### Footprints
####This is the recommended footprint for the SC20100S:
![SC20100S Footprint](images/sc20100s-footprint.gif)

####This is the recommended footprint and PCB design rules for the SC20260B:
![SC20260B Footprint](images/sc20260b-footprint.gif)
![SC20260B Design Rules](images/sc20260b-design-rules.gif)

### Required Pins
Exposing the following pins is required in every design to enable device programming, updates, and recovery:
* RESET
* LDR
* APP
* MOD (if required to select a debug interface)
* Desired debug interface(s) (see below)

For information on these and other important pins, please refer to the [Special Pins](../../software/tinyclr/special-pins.md) page.

### Debug Interface
All SITCore products provide two debug and deployment interfaces: USB and serial. Whether USB or serial debugging is selected is determined by the state of the MOD pin during startup and reset. If the MOD pin is held high during startup, the USB debug interface will be selected. If the MOD pin is held low during startup, the serial debug interface will be selected.

All SITCore products using our 100 pin chips (the SC20100S and SC20100B) use UART1 for the serial debug interface. SITCore products built around the 260 pin SC20260B chip use UART5 for the serial debug interface.

### Power Supply
A clean power source, suitable for digital circuitry, is needed to power SITCore SoCs. Voltages should be regulated to within 10% or better of the specified voltage. Decoupling capacitors of 0.1 uF are needed near every power pin. Additionally, a large capacitor, typically 47 uF, should be placed near the SoC if the power supply is more than few inches away.

### Analog Considerations
It is a good idea to provide a separate filtered supply line for the `Vdda`, and `Vref+` pins. Additionally, on the 260 pin devices, you may want to provide a separate filtered ground connection for the `Vssa` and `Vref-` pins. While this is not needed for ADC operation, it does help to ensure more accurate ADC readings by reducing analog supply noise.

### Crystals
SITCore SoCs require an external 8 MHz crystal and two load capacitors to function. For the RTC to function, a 32.768 kHz crystal two load capacitors are required.

There is a lot to consider when selecting a crystal -- especially the RTC crystal. This is one reason our SoMs are so popular, as the difficult design choices have already been made for you. For more information on crystal selection for SITCore SoCs, please consult [AN2867](https://www.st.com/resource/en/application_note/cd00221665-oscillator-design-guide-for-stm8afals-stm32-mcus-and-mpus-stmicroelectronics.pdf) from STMicroelectronics.

### Main Crystal
Most 8 MHz quartz crystals and ceramic resonators from various manufacturer will work with SITCore SoCs. The table below will tell you what to look for based on the crystal's maximum equivalent series resistance (ESR), shunt capacitance (C0), and load capacitance (CL). Keeping the total capacitance of C0 + CL well below the recommended maximum will provide more of a safety margin for stable and reliable oscillator operation.

|                        |                                         |
|------------------------|-----------------------------------------|
| Max crystal ESR (ohms) | Recommended max total of C0 and CL (pF) |
| 40                     | 49                                      |
| 50                     | 44                                      |
| 60                     | 40                                      |
| 70                     | 37                                      |
| 80                     | 35                                      |
| 100                    | 31                                      |
| 200                    | 22                                      |
| 300                    | 18                                      |

### RTC Crystal
It's more difficult finding crystals that will work reliably with the RTC. This is because the RTC oscillator is an extremely low power oscillator to increase RTC battery life. Start by looking for crystals with low load capacitance. The table below will help. For reliable operation, the total capacitance of C0 (crystal shunt capacitance) and CL (crystal load capacitance) must be less than the recommended max total of C0 and CL.

|                           |                                         |
|---------------------------|-----------------------------------------|
| Max crystal ESR (kilohms) | Recommended max total of C0 and CL (pF) |
| 30                        | 9.9                                     |
| 40                        | 8.5                                     |
| 50                        | 7.6                                     |
| 60                        | 7.0                                     |
| 70                        | 6.5                                     |
| 80                        | 6.0                                     |
| 90                        | 5.7                                     |
| 100                       | 5.4                                     |

When laying out your board, it is best to keep the crystal as close as possible to the SoC so the oscillator traces are as short as possible. The oscillator circuit should also be surrounded by a grounded guard ring or ground plane on the same layer to reduce noise. There should also be a ground plane on a layer underneath the oscillator circuit. The oscillator ground plane should be connected to the closest SoC ground pin.

Conformal coating or other protection is recommended in severe environments to reduce leakage current caused by PCB contamination. Do not expose the crystal to higher temperatures than it is rated for as damage may occur. PCB cleaning is recommended to obtain maximum performance by removing flux residuals from the board after assembly (even when using "no-clean" products in ultra-low-power applications).

Follow the crystal manufacturer's guidelines for load capacitance, otherwise the oscillation frequency may be changed slightly. If the two load capacitors have the same value, one half the value of one load capacitor added to the capacitance of the oscillator traces should be equal to the manufacturer's recommended load capacitance.

### QuadSPI External Flash
We have tested two 16 MByte QuadSPI flash chips with SITCore SoCs. These are the Winbond Electronics W25Q128JVSIM TR and W25Q128JVSIQ TR. If you want to add external flash to your design, sticking with one of these two chips should ensure compatibility with both the SoC and TinyCLR OS.

### Reset
SITCore processors have a permanent internal pull up resistor that is connected to the RESET (NRST) pin. No external pull up resistor is needed.

### Oven Reflow Profile

SITCore SoCs are not sealed for moisture. Baking SoCs before reflow is recommended and required in a humid environment. The process of reflow can damage the SoC if the temperature is too high or exposure is too long.

The lead-free reflow profiles used by GHI Electronics are shown below. The profiles are based on AIM SAC 305 solder (3% silver, 0.5% copper). The thermal mass of the assembled board and the sensitivity of the components on it affect the total dwell time. Differences in the two profiles are where they reach their respective peak temperatures as well as the time above liquids (TAL). The shorter profile applies to smaller assemblies, whereas the longer profile applies to larger assemblies such as back-planes or high-density boards. The process window is described by the shaded area. These profiles are only starting-points and general guidance. The particulars of the oven and the assembly will determine the final process.

[![Reflow Chart](../netmf/images/reflow-profile.gif)](http://files.ghielectronics.com/downloads/Documents/Datasheets/WS483%20SAC305%20Solder%20Paste%20Datasheet.pdf)


## SITCore Dev Boards

We offer SITCore development boards to get you started as quickly and easily as possible. These boards allow you to start programming in minutes, and are suitable for both prototypes and production. Click [here](dev.md) for details.
