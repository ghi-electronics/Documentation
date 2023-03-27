## Demos

These are demos that are built-in the DUE software.

**Demo("Help")**

Returns a list of the demos available on the device. For example:

```basic
>Demo("Help")
DUE DEMOS
---------
led
analog
```

**Demo("led")**



```basic
@Loop
  DWrite(18,1) : Wait(250)
  Dwrite(18,0) : Wait(250)
Goto Loop
```

Type **Run** to launch the demo. This demo flashes the on-board LED.


**Demo("analog")**

```basic
@Loop
  For i=0 to 1000 Step 100
    AWrite(18, i) : Wait(50)
  Next
  For i=1000 to 0 Step -100
    AWrite(18, i) : wait(50)
  Next
Goto Loop
```

Type **Run** to launch the demo. This demo fades the on-board LED in & out.

