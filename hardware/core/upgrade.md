# Upgrading From Earlier GHI Hardware

To complement our ten year Longevity Promise, we provide SITCore products that are drop in replacements for most of our more mature SoMs and chipsets -- even though they are still in production. We strive to keep your product viable as long as possible with no or minimal changes to your hardware.

## Upgrading from G30 and G80 to SITCore

Unfortunately the LQFP100 version of the SITCore processor is unavailable in a version that is pin compatible with the G30 and G80, so changes to your circuit board will be needed. While many of the pins on the SC20100 have the same function, other pins are shifted to a location one over from their previous location. Our experience has shown that these changes are much easier than a complete redesign as most of your circuit board will work without changes. (is this true for G30, or just G80??)

## Upgrading from G120 to SITCore

Our SC20260B is a 99% drop in replacement for the G120. When replacing a G120 with a SC20260B, the following differences may affect your design.

* Some pins with PWM on the G120 do not have PWM on the SC20260B, but software PWM can be used instead.
* The LCD pins do not have UART functionality as on the G120, but this is not often used.
* Pad 15 on the G120 has both UART CTS and SPI. The SC20260B provides SPI and an optional zero ohm resistor connected to a UART CTS pin.
* There is no JTAG exposed on the SC20260B pads, so we provide JTAG through test points on the SoM.

## Upgrading from G120E to SITCore

Our SC20260E is a 99% drop in replacement for the G120E. When replacing the G120E with the SITCore you may encounter the following issues.

* A few pins that support PWM on the G120E do not support PWM on the SITCore SC20260E. Software based PWM can be used instead.
* The LCD pins do not support UART, but this will rarely be an issue.
* Pad 10 on the G120E supports both UART and DAC, so on the SC20260E we support UART and added DAC through an optional zero ohm resistor.

## Upgrading from G400S to SITCore

Unfortunately we do not currently offer a SITCore replacement for the G400S. Significant PCB changes will be needed.

## Upgrading from G400D to SITCore

Our SC20260D is a 99% drop in replacement for the G400D.

* The LCD pins do not have UART functionality, like some do on the G400D, but this is rarely a problem.
* There is not a second USB host controller on the SITCore SC20260D like there is on the G400D.

## Upgrading from UC2550 and UC5500 to SITCore

These are close, but not completely compatible. Some PCB changes will be needed.
