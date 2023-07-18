## Basic Samples

These samples don't require you to wire anything and utilize the on-board components, when available, of the supported hardware.

Example: LED, Buttons, Buzzer, and Screen. 

**Blink On-board LED**

```basic
@Loop
  DWrite('L',1) : Wait(250)
  DWrite('L',0) : Wait(250)
Goto Loop
```

**Analog Blink On-board LED**

```basic
@Loop
  For i=0 to 100 Step 10
    AWrite('L', i) : Wait(50)
  Next
  For i=100 to 0 Step -10
    AWrite('L', i) : wait(50)
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
     Wait(500)
  End
  If y=1
     PrintLn("Button B")
     Wait(500)
  End
Goto Loop
```

**On-board Buzzer**

```basic
# G
Beep('p', 392, 500)
# A
Beep('p', 440, 500)
# F
Beep('p', 349, 250)
# F octave lower
Beep('p', 175, 250)
# C
Beep('p', 262, 1000)
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

