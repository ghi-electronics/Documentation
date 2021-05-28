#UART

---

UART uses 2 pins for full-duplex data transfer between 2 devices, where TX (transmit) on one side goes to RX (receive) on the other device.

```
from machine import UART
uart = UART(1, baudrate=9600)
uart.write('hello')
uart.read(5) # read up to 5 bytes
```