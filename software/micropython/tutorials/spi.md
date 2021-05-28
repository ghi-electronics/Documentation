# SPI

---
SPI uses transfers data serially, from a master to one or more slaves. Data is clocked out on the CLK pin. With every clock, a bit is sent out of the master into the slave MOSI (Master Out Slave In). The MISO sends data in the opposite direction. When there are multiple salves, the CS (Chip Select) pin is used to identify the addressed salve.

---

# Hardware SPI

```py
from machine import SPI
spi = SPI(1, SPI.MASTER, baudrate=600000, polarity=1, phase=0)

spi.init(baudrate=200000) # set the baudrate

spi.read(10)            # read 10 bytes on MISO
spi.read(10, 0xff)      # read 10 bytes while outputting 0xff on MOSI

buf = bytearray(50)     # create a buffer
spi.readinto(buf)       # read into the given buffer (reads 50 bytes in this case)
spi.readinto(buf, 0xff) # read into the given buffer and output 0xff on MOSI

spi.write(b'12345')     # write 5 bytes on MOSI

buf = bytearray(4)      # create a buffer
spi.write_readinto(b'1234', buf) # write to MOSI and read from MISO into the buffer
spi.write_readinto(buf, buf) # write buf to MOSI and read MISO back into buf
```

---

## Software SPI

Software SPI is slower than hardware but can work with any pins.

```py
from machine import Pin, SoftSPI
spi = SoftSPI(baudrate=100000, polarity=1, phase=0, sck=Pin("PB3"), mosi=Pin("PB5"), miso=Pin("PB4"))
```