[IN PROGRESS](error.md) 
# Specialized
---
Some of the specialized low-level features in this section are used to directly access hardware control or change the normal behavior of the SITCore processor.

> [!Warning]
> This section is for ADVANCED users. An understanding of how processors & registers work is recommended. 

---

## Register Access

The Marshal class allows us to directly access and modify some of the internal processor's registers. More on this can be found in the [Marshal class](marshal.md) section.

---

## SD Card Control

A user may find it necessary to change the clock speed of the SD card. Using the Marshal class, we can directly access the processor and slow down the clock speed of the SD peripheral. 
> [!Note]
> This may be necessary depending on the design of the final product, or the use of low-cost SD cards.

```cs
const int SD_CLOCK_ADDRESS_REG = 0x00000004;

var clock_divider = 4; // 0,1,2,3 are 25MHz, 4: 12MHz, 5: 10MHz, 6: 8MHz...
            
Marshal.WriteInt32((IntPtr)SD_CLOCK_ADDRESS_REG, clock_divider);
```

---

## Disable Interrupts

Interrupts can be disabled and enabled. This is useful in timing critical tasks however interrupts shold only be disabled for a very short time.

```cs
var isDisabled = Interrupt.IsDisabled();

if (isDisabled == false){
    Interrupt.Disable();
}

// code....

if (isDisabled == false){
    Interrupt.Enable();
}
```

---

## Alternate Functions

Some pins on a SITCore processor may offer alternate functions. There is an example in the [GPIO](gpio.md) section on moving a feature from one pin to another. 

---

## Temperature 

The processor's internal temperature can be read as shown in the the [Analog In](analog-in.md) tutorial. 

---

