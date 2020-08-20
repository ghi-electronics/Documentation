# Marshal
---
Marshal is a static class provides two functions to read `ReadInt32`, write and modify some special peripheral's registers `WriteInt32`.

Example below show how to use Marshal to read gpio input data register, modify on gpio output data register to set pin PB0 to high:

>[!TIP]
> The example below requires the `System.Runtime.InteropServices`.

```
var pinPB0OutDataReg = (IntPtr)0x58020414;

var portValue = Marshal.ReadInt32(pinPB0OutDataReg) | (1 << 0); // Pin 0

Marshal.WriteInt32(pinPB0OutDataReg, portValue);

```
>[!WARNING]
> Some peripherals, reading status registers also clear their status, which may effect to their behavior in run time.

Below is list of peripheral registers that TinyCLR OS allowes to access. An exception will be thrown if invalid register.

    - Analog-to-digital converters (ADC)
    - Controller area network (CANFD)
    - Digital-to-analog converter (DAC)
    - Digital camera interface (DCMI)
    - LCD-TFT Display Controller (LTDC)
    - Ethernet (ETH)
    - Flexible memory controller (FMC)
    - General-purpose I/Os (GPIO)
    - Inter-integrated circuit (I2C) interface
    - Power control (PWR)
    - Advanced-control timers (TIM1/TIM8)
    - General-purpose timers (TIM2/TIM3/TIM4/TIM5/TIM12/TIM13/TIM14/TIM15/TIM16/TIM17)
    - Basic timers (TIM6/TIM7)
    - Quad-SPI interface (QUADSPI)
    - Secure digital input/output MultiMediaCard interface (SDMMC1)
    - Real Time Clock (RTC)
    - Serial peripheral interface (SPI)
    - Universal synchronous/asynchronous receiver transmitter (USART/UART)
    - USB on-the-go (USB_OTG)
    - WatchDog (WDG)
    - Reset and Clock Control
    - Voltage reference buffer (VREFBUF)

 
