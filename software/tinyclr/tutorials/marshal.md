# Marshal
---
Marshal is a static class that provides two functions `ReadInt32` to read, and `WriteInt32` to write and modify some special peripheral's registers .

Example below shows how to use Marshal to read gpio input data register, and modify on gpio output data register to set pin PB0 to high:

>[!TIP]
> The example below requires `System.Runtime.InteropServices`.

```cs
var pinPB0OutDataReg = (IntPtr)0x58020414;

var portValue = Marshal.ReadInt32(pinPB0OutDataReg) | (1 << 0); // Pin 0

Marshal.WriteInt32(pinPB0OutDataReg, portValue);

```
>[!WARNING]
> Some peripherals, reading status registers also clear their status, which may effect their behavior at run time.

Below is list of peripheral registers that TinyCLR OS allows access to. An exception will be thrown if an invalid register is used.

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

 
