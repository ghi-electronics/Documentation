# Getting Started

---

<div style="text-align: center;">

![Host Mode](./images/getting-started.png)

</div>

## Hardware Selection

The first step is to pick from one of the many available [DUE Hardware](../hardware/intro.md) options. 

Follow the hardware instructions to load the latest DUE Link firmware onto your device.

## Start Coding

There are multiple langues can be used to comminucate with DUELink controller.

---

## Blink LED

Assuming you already have hardware and the board is loaded with the latest firmware, We will start by blinking an LED on different langues.

# [Python](#tab/py)

```py
from DUELink.DUELinkController import DUELinkController
import time

availablePort = DUELinkController.GetConnectionPort()
due = DUELinkController(availablePort)

while True:
    due.Led.Set(1,0,0)
    time.sleep(0.5)
    due.Led.Set(0,1,0)
    time.sleep(0.5)
```


# [JavaScript](#tab/js)

```js
import {SerialUSB} from './serialusb.js';
import * as DUELink from './duelink.js';
import { Util } from "./util.js";

let due = new DUELink.DUELinkController(new SerialUSB());
await due.Connect();

while (true){
	await due.Led.Set(1, 0, 0)
	await Util.sleep(500)
	await due.Led.Set(0, 1, 0)
	await Util.sleep(500)
}
```
# [.NET](#tab/net)
```cs
var availablePort = DUELinkController.GetConnectionPort();
var due = new DUELinkController(availablePort);
 
while (true) {
	due.Led.Set(1, 0, 0);
	Thread.Sleep(500);
	due.Led.Set(0, 1, 0);
	Thread.Sleep(500);
}
```


# [DUE Engine](#tab/due)

```
@Loop
  Led(1, 0, 0)
  Wait(500)
  Led(0, 1, 0)
  Wait(500)
Goto Loop
```

---

---

## Special Pins

Boards may include on-board features that can be accessed through the API.

Pin "number" | On-board Feature
--|--
'a' or 'A' | Button A
'b' or 'B' | Button B
'p' or 'P' | Piezo buzzer
'l' or 'L' | LED

This is an example of how to blink the on-board LED.

# [Python](#tab/py)

```py
from DUELink.DUELinkController import DUELinkController
import time

availablePort = DUELinkController.GetConnectionPort()
duelink = DUELinkController(availablePort)

while True:
    duelink.Digital.Write('l', 1)
    time.sleep(0.5)
    duelink.Digital.Write('l', 0)
    time.sleep(0.5)
```


# [JavaScript](#tab/js)

```js
import {SerialUSB} from './serialusb.js';
import * as DUELink from './duelink.js';
import { Util } from "./util.js";

let duelink = new DUELink.DUELinkController(new SerialUSB());
await due.Connect();

while (true){
	await duelink.Digital.Write('l', 1)
	await Util.sleep(500)
	await duelink.Digital.Write('l', 0)
	await Util.sleep(500)
}
```
# [.NET](#tab/net)
```cs
var availablePort = DUELinkController.GetConnectionPort();
var due = new DUELinkController(availablePort);
 
while (true) {
	duelink.Digital.Write('l', 1);
	Thread.Sleep(500);
	duelink.Digital.Write('l', 0);
	Thread.Sleep(500);
}
```


# [DUE Engine](#tab/due)

```
@Loop
  DWrite('l', 1)
  Wait(500)
  DWrite('l', 0)
  Wait(500)
Goto Loop
```
