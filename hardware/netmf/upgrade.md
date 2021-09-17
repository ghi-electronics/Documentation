# Upgrading

---


![Upgrading](images/upgrade-sign.png)

To complement our ten year Longevity Promise, we provide [products](../sitcore/intro.md) that are drop in replacements for most of our more mature SoMs and chipsets. We strive to keep customers products viable as long as possible with no or minimal changes to hardware.

## Speed Comparison

| Processor      | Speed           | OS             |
| ---------------| ----------------|----------------|
| SC20xxx        | 1.75 seconds    | TinyCLR 2.1    |
| G400           | 3.3 seconds     | NETMF 4.3      |
| G80            | 7.6 seconds     | NETMF 4.3      |
| G30            | 18 seconds      | NETMF 4.3      |
| SC13xxx        | 21 seconds      | TinyCLR 2.1    |
| G120           | 29 seconds      | NETMF 4.3      |
| EMX            | 74 seconds      | NETMF 4.3      |

## G30 to SITCore

There is currently no LQFP64 package options for SITCore. The recommended replacement is SC20100S 100LQFP, with considerably more horsepower and available resources.

## G80 to SITCore

The SITCore SC20100S is LQFP100 with near identical pinout and compatibility with the G80, however it is not a drop-in replacement and some small changes are necessary. The table below provides a pinout comparison.

[SC20100S to G80 Pinout Map](pdfs/sc20100s-g80-pinoutmap.pdf)  

## G120 to SITCore

Our SCM20260N is a drop in replacement for the G120 with the following differences that will rarely be an issue.

* The following pads/pins on the SCM20260N do not support hardware PWM: Pad 3/pin PK7, pad 23/pin PC10, pad 24/pin PC9, pad 25/pin PC12, pad 26/pin PC8, pad 28/pin PD2, pad 85/pin PI12, and pad 90/pin PI13.
* SCM20260N pad 80 (PK6/LCD B7) and pad 88 (PJ6/LCD R7) do not have UART TX and RX as found on G120 pads 80 and 88. As this is an LCD pin, this will rarely be an issue.
* Pad 15 on the SCM20260N (PI2/SPI2 MISO/TIM8 CH4 + PD3/USART2 CTS through a 330 ohm resistor) provides USART CTS connected through a 330 ohm resistor to maintain compatibility with Pad 15 on the G120 (P0.17/UART2 CTS/SPI1 MISO).
* The SCM20260N serial debug port (UART5) is exposed on pads 29 and 30 of the SoM, while on the G120 the serial debug (UART1) is on pads 5 and 6. This will only be a problem when using serial debugging/deployment -- USB debugging/deployment is not affected.

[SCM20260N to G120 Pinout Map](pdfs/scm20260n-g120-pinoutmap.pdf)

## G120E to SITCore

Our SCM20260E is a drop in replacement for the G120E except for a few issues that will rarely present any problem.

* To enable serial deployment and debugging, the MOD pin on the SCM20260E is active low, while on the G120E the MODE pin is active high. A minor change will be needed to correct the MOD level and select the desired debugging interface.
* Serial mode deploying and debugging defaults to UART5 on the SCM20260E versus UART1 on the G120E. This is only a concern if serial mode deploying/debugging is needed.
* SCM20260E pad 57 (PD3/UART2 CTS) does not have PWM as on G120E pad 57 (P3.18/UART2 CTS/PWM2). 
* SCM20260E pad T5 (PJ6/LCD R7) does not have UART RX as on G120E pad T5 (P2.9/LCD R4/UART5 RX). As this is an LCD pin, this will rarely be an issue.
* SCM20260E pad T16 (PJ6/LCD R7) does not have UART TX as on G120E pad T16 (P1.29/LCD B4/UART5 TX). As this is an LCD pin, this will rarely be an issue.
* SD Power pin is not available. Instead, there is regular GPIO pin.

[SCM20260E to G120E Pinout Map](pdfs/scm20260e-g120e-pinoutmap.pdf)

## G400S to SITCore

There is no drop-in replacement for the G400S. The recommended replacement is the SCM20260E, which has considerably more horsepower and available resources.

## G400D to SITCore

Our SCM20260D is a drop in replacement for the G400D, with just a couple of differences that will rarely be an issue.

* SCM20260D pins 164 and 165 do not provide UART TX and RX as on the G400D. As these are LCD pins, this will rarely be an issue.
* There is no second USB host controller on the SITCore SCM20260D pins 182 and 184 as there is on the G400D.

[SCM20260D to G400D Pinout Map](pdfs/scm20260d-g400d-pinoutmap.pdf)

## UC2550 and UC5500 to SITCore

The recommended replacement, the SCM20260D, is close, but not completely compatible with the UC2550 and UC5550. Some PCB changes will be needed.
