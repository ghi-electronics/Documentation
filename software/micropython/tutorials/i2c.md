#I2C

---

TBD

---

## Software I2C

Software I2C is slower but can work with any pin.

```
from machine import Pin, SoftI2C
i2c = SoftI2C(scl=Pin("PB8"), sda=Pin("PB9"), freq=100000)
i2c.scan() # show what slaves are available

i2c.readfrom(0x3a, 4)   # read 4 bytes from slave device with address 0x3a
i2c.writeto(0x3a, '12') # write '12' to slave device with address 0x3a

buf = bytearray(10)     # create a buffer with 10 bytes
i2c.writeto(0x3a, buf)  # write the given buffer to the slave
```

> [!Note]
> i2c.scan() returns from 0x8 to 0x77 address only.