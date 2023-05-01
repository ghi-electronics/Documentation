## Basic Samples

These samples don't require you to wire anything and utilize the on-board components, when available, of the supported hardware.

Example: LED, Buttons, Buzzer, and Screen. 

**Blink On-board LED**

```basic
@Loop
  DWrite(108,1) : Wait(250)
  DWrite(108,0) : Wait(250)
Goto Loop
```

**Analog Blink On-board LED**

```basic
@Loop
  For i=0 to 1000 Step 100
    AWrite(108, i) : Wait(50)
  Next
  For i=1000 to 0 Step -100
    AWrite(108, i) : wait(50)
  Next
Goto Loop
```

**On-board Buttons**

```basic
BtnEnable('a',1)
BtnEnable('b',1)
@Loop
x=BtnDown('a')
y=BtnDown('b')
If x=1
    PrintLn("Button A")
    wait(500)
End
If y=1
    PrintLn("Button B")
    wait(500)
End
Goto Loop
```

**On-board Buzzer**

```basic
# G
Sound(392, 1000, 100)
Wait(500)
# A
Sound(440, 1000, 100)
Wait(500)
# F
Sound(349, 500, 100)
Wait(500)
# F octave lower
Sound(175, 500, 100)
Wait(500)
# C
Sound(262, 2000, 100)
```

**On-board Display Small Text**

```basic
LcdClear(0)
LcdText("Hello World",1,10,10)
LcdShow()
```

**On-board Display Large Text**

```basic
LcdClear(0)
LcdTextS("Hello",1,0,0,2,2)
LcdTextS("World",1,15,15,2,2)
LcdShow()
```

