#I2C

---

I2C is a common 2 wire bus where a master talk to a slave using the slave's address. The available implementation is for I2C Master only, allowing the chip to talk to I2C slaves, such as displays and accelerometers.

---

## Hardware I2C

MicroPython implementation on SITCore internally uses Software I2C but compatibility is provides the hardware class.

```py
from machine import I2C, Pin
i2c = I2C(1, freq=100000) # Uses I2C1
i2c.scan() # show what slaves are available

i2c.readfrom(0x3a, 4)   # read 4 bytes from slave device with address 0x3a
i2c.writeto(0x3a, '12') # write '12' to slave device with address 0x3a

buf = bytearray(10)     # create a buffer with 10 bytes
i2c.writeto(0x3a, buf)  # write the given buffer to the slave
```

> [!Note]
> i2c.scan() returns addresses 0x8 to 0x77 only.

---

## Software I2C

Software I2C can work with any pin.

```
from machine import Pin, SoftI2C
i2c = SoftI2C(scl=Pin("PB8"), sda=Pin("PB9"))
```
