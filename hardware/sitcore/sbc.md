# Single Board Computers
---
![Single Board Computer](images/sbc.png)

We offer multiple single board computers to provide the lowest possible barrier to entering the world of TinyCLR OS. Most of these boards have WiFi and they all support the complete TinyCLR feature set. These boards are great for trying out TinyCLR OS, building prototypes, or incorporating into products.

> [!Note]
> All SITCore single board computers use a USB-C connector for application deployment and debugging. While USB-C has many advantages, we've also noticed some flaws. Every USB-A to USB-C cable tested worked as expected. Testing USB-C to USB-C cables gave interesting and unexpected results. Most USB-C hubs also do not work when using USB-C to USB-C cables. If you are having problems deploying or debugging, try connecting the board directly to your computer with a USB-A to USB-C cable.

## Specifications and Peripherals

|                            |                 |                 |                 |                         |                 |
|----------------------------|-----------------|-----------------|-----------------|-------------------------|-----------------|
|                            | **FEZ Bit**     | **Fez Duino**   | **FEZ Feather** | **Fez Portal**          | **FEZ Stick**   |
| **Core**                   | SC20100S        | SC20100S        | SC20100S        | SC20260N                | SC20100S        |
| **External SDRAM**         | X               | X               | X               | 32 MByte                | X               |
| **External Flash**         | X               | 16 MByte        | X               | 16 MByte                | X               |
| **Display**                | 1.8" 160x128    | X               | X               | 4.3" 480x272 Cap. Touch | X               |
| **Click Connectors**       | X               | X               | X               | 1                       | 2               |
| **WiFi**                   | Yes             | Yes             | Yes             | Yes                     | X               |
| **Micro SD**               | Yes             | Yes             | X               | Yes                     | X               |
| **User LED**               | Yes             | Yes             | Yes             | Yes                     | Yes             |
| **Buzzer**                 | Yes             | X               | X               | Yes                     | X               |
| **Accelerometer**          | Yes             | X               | X               | X                       | X               |
| **User Buttons**           | Yes             | Yes             | Yes             | Yes                     | Yes             |
| **USB Client**             | Yes             | Yes             | Yes             | Yes                     | Yes             |
| **USB Host Connector**     | X               | Yes             | X               | Yes                     | Yes             |
| **LiPo Charger**           | X               | X               | Yes             | X                       | X               |
| **Power Barrel**           | X               | Yes             | X               | X                       | X               |
| **GPIO**                   | 19              | 38              | 31              | 45                      | 33              |
| **SPI**                    | 1               | 2               | 2               | 3                       | 2               |
| **I2C**                    | 1               | 2               | 1               | 1                       | 2               |
| **UART**                   | 3 (0 w/ HS)     | 5 (2 w/ HS)     | 5 (1 w/ HS)     | 6 (1 w/ HS)             | 3 (1 w/ HS)     |
| **CAN**                    | 1               | 1               | 1               | 2                       | 1               |
| **PWM**                    | 8               | 12              | 8               | 17                      | 6               |
| **ADC**                    | 8               | 11              | 6               | 10                      | 3               |
| **DAC**                    | 1               | 2               | 1               | 2                       | X               |
| **SD/SDIP/MMC**            | 1               | 1               | 1               | 1                       | 1               |

*Note: As many pins share peripherals, not all peripherals will be available.*

## Power Consumption
The 'Running' power consumption totals include all other on board components, such as WiFi & Display.

|                            | FEZ Bit         | Fez Duino       | FEZ Feather     | Fez Portal              | FEZ Stick       |
|----------------------------|-----------------|-----------------|-----------------|-------------------------|-----------------|
| **Running**                | 305mA           | 295mA           | 285mA           | 535mA                   | 194mA           |
| **Sleep**                  | 187mA           | 187mA           | 179mA           | 200mA                   | 163mA           |
| **Hibernate**              | 11mA            | 11mA            | 9mA             | 37mA                    | 6mA             |
| **Shutdown**               | 2mA             | 5mA             | 90uA            | 20mA                    | 810uA           |

See the [Power Management](http://docs.ghielectronics.com/software/tinyclr/tutorials/power-management.html) tutorial 

## FEZ Bit

![FEZ Bit](images/fez_bit.png)

The **FEZ Bit**, while seemingly more of a "maker" board, provides a convenient way to easily use the multitude of inexpensive Micro:bit accessories that have flooded the market. As the number of Micro:bit accessories continues to grow, this board will be valued as a way to use these accessories to quickly assemble prototypes and test new product concepts.

>[!Caution]
>The 3.3v regulator may run hot, especially when WiFi is in use. You can add 3.3V regulator externally to eliminate this heat issue, and this is needed if adding any external components that draw more than 10mA.

[FEZ Bit Schematic](pdfs/fez-bit-rev-b-schematic.pdf)

[FEZ Bit 3D STEP File](http://files.ghielectronics.com/downloads/3D/SITCore/SBC/FEZ%20Bit%20Rev%20B.step)


### FEZ Bit Peripheral Pins

|                   |             |
|-------------------|-------------|
| **User LED**      | PE11        |
|                   |             |
| **Buzzer**        | PB1         |
|                   |             |
| **Accelerometer** | I2C = I2C1  |
|                   |             |
| **SPI Display**   | SPI = SPI4  |
|                   | BL = PA15   |
|                   | CS = PD10   |
|                   | RS = PC4    |
|                   | RST = PE15  |
|                   |             |
| **WiFi**          | SPI = SPI3  |
|                   | IRQ = PB12  |
|                   | CS = PD15   |
|                   | EN = PA8    |
|                   | RST = PB13  |
|                   |             |
| **Buttons**       | LDR = PE3   |
|                   | APP = PB7   |
|                   | UP = PE4    |  
|                   | DOWN = PA1  |
|                   | A = PE5     |
|                   | B = PE6     |
|                   |             |
| **Edge Connector**| P0 = PC6 (PC2 Analog)|
|                   | P1 = PC7 (PA3 Analog)|
|                   | P2 = PA0    |
|                   | P3 = PB0    |
|                   | P4 = PA4    |
|                   | P5 = PD13   |
|                   | P6 = PD12   |
|                   | P7 = PD11   |
|                   | P8 = PE8    |
|                   | P9 = PC3    |
|                   | P10 = PC0   |
|                   | P11 = PD1   |
|                   | P12 = PD0   |
|                   | P13 = PA5   |
|                   | P14 = PA6   |
|                   | P15 = PA7   |
|                   | P16 = PE7   |
|                   | P19 = PB8   |
|                   | P20 = PB9   |


> [!Note]
> All boards with a barrel power jack accept a 5.5 x 2.1 mm power plug. The pin is positive, the sleeve is negative. While these boards accept a wide voltage range, they use linear voltage regulators that run hotter with higher input voltages. Generally we recommend an input voltage of 6 to 12 volts, but if your project draws a lot of current, use a lower voltage to keep the regulator cooler. A one amp power supply should provide enough current for most needs.

## FEZ Duino

![FEZ Duino](images/fez_duino.png)

The **FEZ Duino** provides female headers that make use of the popular Arduino pinout. Once again, we are trying to make it as easy and inexpensive as possible to build prototypes and try out new concepts by taking advantage of an existing accessory ecosystem.

[FEZ Duino Schematic](pdfs/fez-duino-rev-b-schematic.pdf)

[FEZ Duino 3D STEP File](http://files.ghielectronics.com/downloads/3D/SITCore/SBC/FEZ%20Duino%20Rev%20B.step)

![FEZ Duino](images/fez-duino-pinout.jpg)

### FEZ Duino Peripheral Pins

|                   |             |
|-------------------|-------------|
| **User LED**      | PE11        |
|                   |             |
| **WiFi**          | SPI = SPI3  |
|                   | IRQ = PB12  |
|                   | CS = PD15   |
|                   | EN = PA8    |
|                   | RST = PB13  |
|                   |             |
| **Buttons**       | LDR = PE3   |
|                   | APP = PB7   |

## FEZ Feather

![FEZ Feather](images/fez_feather.png)

The Adafruit Feather form factor boards are made to be stackable and have built-in support for 3.7V LiPo batteries with a charging circuit. The **FEZ Feather** provides both through hole pads and castellated edges making it both breadboard friendly and easy to build into products.

>[!Caution]
>Lithium Polymoer(Li-Po) batteries are significantly more volatile than other rechargable batteries. Make sure you have an understand of how to properly charge and use them before connecting to the FEZ Feather. Never attempt to charge a damaged or swollen battery. Never leave battery charging unattended. Improper use could result in fire.

>[!Warning]
>Be very careful to ensure the correct polarity of LiPo batteries before connecting them to the FEZ Feather. Reverse polarity will damage the charging circuit, and not all batteries are wired correctly. GHI Electronics is not responsible for, and will not warranty, damage caused by incorrectly connected batteries.

Make sure the battery polarity is correct as shown below (red wire to plus, black to minus):

![FEZ Feather Battery Connection](images/battery-connect.jpg)

>[!Caution]
>The 3.3v regulator may run hot, especially when WiFi is in use. You can add 3.3V regulator externally to eliminate this heat issue, and this is needed if adding any external components that draw more than 10mA.

[FEZ Feather Schematic](pdfs/fez-feather-rev-b-schematic.pdf)

[FEZ Feather 3D STEP File](http://files.ghielectronics.com/downloads/3D/SITCore/SBC/FEZ%20Feather%20Rev%20B.step)


### FEZ Feather Peripheral Pins

|                   |             |
|-------------------|-------------|
| **User LED**      | PE11        |
|                   |             |
| **WiFi**          | SPI = SPI3  |
|                   | IRQ = PB12  |
|                   | CS = PD15   |
|                   | EN = PA8    |
|                   | RST = PB13  |
|                   |             |
| **Buttons**       | LDR = PE3   |
|                   | APP = PB7   |

## FEZ Portal

![FEZ Portal](images/fez_portal.png)

Already one of our most popular SITCore single board computers, The **FEZ Portal** is a 4.3" 480x272 display with capacitive touch that is programmable in C#. As the display and controller are one unit, it's even easier to make a product with touch as you only have to mount a single board that's only slightly larger than the display.

[FEZ Portal Schematic](pdfs/fez-portal-rev-c-schematic.pdf)

[FEZ Portal 3D STEP File](http://files.ghielectronics.com/downloads/3D/SITCore/SBC/FEZ%20Portal%20Rev%20C.step)


### FEZ Portal Peripheral Pins

|                   |                 |
|-------------------|-----------------|
| **User LED**      | PB0             |
|                   |                 |
| **Buzzer**        | PB1             |
|                   |                 |
| **Display**       | BL = PA15       |
|                   | Touch I2C = I2C1|
|                   | Touch IRQ = PG9 |
|                   |                 |
| **WiFi**          | SPI = SPI3      |
|                   | IRQ = PF10      |
|                   | CS = PA6        |
|                   | EN = PA8        |
|                   | RST = PF8       |
|                   |                 |
| **Buttons**       | LDR = PE3       |
|                   | APP = PB7       |

## FEZ Stick

![FEZ Stick](images/fez_stick.png)

The **FEZ Stick** is simply the least expensive way to easily get started with TinyCLR OS. While providing an inexpensive way for the uninitiated to try TinyCLR OS, we've provided castellated edges as well as through hole pads to make it breadboard friendly and easy to embed into products. Also, there's actually space for two click modules, making this a very versatile board at a very affordable price!

> [!Note]
> FEZ Stick REV. B pin PB13 MISO is mislabeled on the silk screen and should read PE13 MISO

>[!Caution]
>The onboard 3.3v regulator is only capable of running external components of an additional 50mA. If more current is necessary, then add an additional external 3.3V regulator.

[FEZ Stick Schematic](pdfs/fez-stick-rev-b-schematic.pdf)

[FEZ Stick 3D STEP File](http://files.ghielectronics.com/downloads/3D/SITCore/SBC/FEZ%20Stick%20Rev%20B.step)


### FEZ Stick Peripheral Pins

|                   |             |
|-------------------|-------------|
| **User LED**      | PE11        |
|                   |             |
| **Buttons**       | LDR = PE3   |
|                   | APP = PB7   |





