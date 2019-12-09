# Upgrading From Earlier GHI Hardware

To complement our ten year Longevity Promise, we provide SITCore products that are drop in replacements for most of our more mature SoMs and chipsets. We strive to keep your product viable as long as possible with no or minimal changes to your hardware.

## Upgrading from G30 to SITCore

While we offer no SITCore in an LQFP64 package, the recommended replacement (the SC20100) has considerably more horsepower and available resources. As nearly all new designs will require some form of IoT connectivity, the SC20100 provides much greater value for new designs or redesigns of existing products.

## Upgrading from G80 to SITCore

Unfortunately the LQFP100 version of the SITCore processor is unavailable in a version that is pin compatible with the G80, so changes to your circuit board will be needed. However, many of the pins on the SC20100 have the same function as on the G80, and the other pins are close to their previous position. Our experience has shown that upgrading a circuit board design from the G80 to the SC20100 can easily be accomplished in a matter of hours.

## Upgrading from G120 to SITCore

Our SC20260B is a drop in replacement for the G120 with the following differences that will rarely be an issue.

* SC20260B pad 3 (PK7/LCD DE) does not have PWM as on G120 pad 3 (P2.4/PWM10/LCD OE). Use software PWM if needed.
* SC20260B pad 23 (PC10/SDMMC1 D2/USART3 TX) does not have PWM as on G120 pad 23 (P1.11/PMW5/SD D2). Use software PWM if needed.
* SC20260B pad 24 (PC9/SDMMC1 D1/UART5 CTS) does not have PWM as on G120 pad 24 (P1.7/PWM4/SD D1). Use software PWM if needed.
* SC20260B pad 25 (PC12/SDMMC1 CK) does not have PWM as on G120 pad 25 (P1.2/PWM0/SD CLK). Use software PWM if needed.
* SC20260B pad 26 (PC8/SDMMC1 D0/UART5 RTS) does not have PWM as on G120 pad 26 (P1.6/PWM3/SD D0). Use software PWM if needed.
* SC20260B pad 28 (PD2/SDMMC1 CMD) does not have PWM as on G120 pad 28 (P1.3/PWM1/SD CMD). Use software PWM if needed.
* SC20260B pad 80 (PK6/LCD B7) does not have COM TX as on G120 pad 80 (P1.29/LCD B4/COM5 TX). As this is an LCD pin, this will rarely be an issue.
* SC20260B pad 85 (PI12/LCD HSYNC) does not have PWM as on G120 pad 85 (P2.5/LCD HS/PWM11). Use software PWM if needed.
* SC20260B pad 88 (PJ6/LCD R7) does not have COM RX as on G120 pad 88 (P2.9/LCD R4/COM5 RX). As this is an LCD pin, this will rarely be an issue.
* SC20260B pad 90 (PI13/LCD VSYNC) does not have PWM as on G120 pad 90 (P2.3/LCD VS/PWM9). Use software PWM if needed.

* Pad 15 on the SC20260B (PI2/SPI2 MISO/TIM8 CH4 + PD3/USART2 CTS through 0 ohm) provides USART CTS connected through a zero ohm resistor to maintain compatibility with Pad 15 on the G120 (P0.17/COM2 CTS/SPI1 MISO).

## Upgrading from G120E to SITCore

Our SC20260E is a drop in replacement for the G120E except for a few issues that will rarely present any problem.

* SC20260E pad 57 (PD3/USART2 CTS) does not have PWM as on G120E pad 57 (P3.18/COM2 CTS/PWM2). Use software PWM if needed.
* SC20260E pad T5 (PJ6/LCD R7) does not have COM RX as on G120E pad T5 (P2.9/LCD R4/COM5 RX). As this is an LCD pin, this will rarely be an issue.
* SC20260E pad T16 (PJ6/LCD R7) does not have COM TX as on G120E pad T16 (P1.29/LCD B4/COM5 TX). As this is an LCD pin, this will rarely be an issue.

* Pad 10 on the SC20260B (PF6/UART7 RX/ADC3 INP8 + PA5/OTG HS ULPI CK/ADC12 INP19/DAC2 through 0 ohm) provides DAC connected through a zero ohm resistor to maintain compatibility with Pad 10 on the G120E (P0.26/COM4 RX/ADC3/DAC0).

## Upgrading from G400S to SITCore

Unfortunately we do not currently offer a SITCore drop in replacement for the G400S. The recommended replacement is the SCM20260E, which has considerably more horsepower and available resources. As nearly all new designs will require some form of IoT connectivity, the SC20100 provides much greater value for new designs or redesigns of older products.

## Upgrading from G400D to SITCore

Our SC20260D is a drop in replacement for the G400D, with just a couple of differences that will rarely be an issue.

* SC20260D pins 164 and 165 do not provide UART TX and RX as on the G400D. As these are LCD pins, this will rarely be an issue.
* There is no second USB host controller on the SITCore SC20260D pins 182 and 184 as there is on the G400D.

## Upgrading from UC2550 and UC5500 to SITCore

The recommended replacement, the SCM20260D, is close, but not completely compatible with the UC2550 and UC5550. Some PCB changes will be needed.
