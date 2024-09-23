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

# [Python](#tab/python)

```
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

# [.NET](#tab/net)
```

var availablePort = DUELinkController.GetConnectionPort();
var due = new DUELinkController(availablePort);
 
while (true) {
	due.Led.Set(1, 0, 0);
	Thread.Sleep(500);
	due.Led.Set(0, 1, 0);
	Thread.Sleep(500);
}
```

# [JavaScript](#tab/javascript)

```
import {SerialUSB} from './serialusb.js';
import * as due from './duelink.js';
import { Util } from "./util.js";

let due = new due.DUELinkController(new SerialUSB());
await due.Connect();

while (true) {
	await due.Led.Set(1, 0, 0)
	await Util.sleep(500)
	await due.Led.Set(0, 1, 0)
	await Util.sleep(500)
}

```

# [DUE Engine](#tab/dueengine)

```
@Loop
  Led(1, 0, 0)
  Wait(500)
  Led(0, 1, 0)
  Wait(500)
Goto Loop
```
