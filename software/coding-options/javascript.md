# JavaScript

---

![JavaSript](../images/javascript.png)

JavaScript is one of the core technologies used by the World Wide Web. 98% of all websites use JavaScript. Websites can now use the provided DUELink JavaScript library to access the physical world.

Here is a website demo to demonstrate how JavaScript can control actuators and read sensors: [demo.duelink.com](https://demo.duelink.com/)

## Setup
This page assumes the user is already familiar with JavaScript and there is a development machine that is already setup to build and run JavaScript programs. We'll be running our program on a local machine using NodeJS.

> [!TIP]
> Make sure your hardware is updated with the latest firmware listed on the [downloads](..\downloads.md) page.

Start a new project with a simple line of code to test out the project is running.

```js
console.log("Hello World");
```

We are now ready to bring in the [DUE JavaScript library](https://github.com/ghi-electronics/due-libraries) using `npm install DUELink`. However, the library is not NPM hosted yet and can be downloaded from here https://github.com/ghi-electronics/due-libraries/tree/main/javascript. Download and save duelink.js, util.js, and serialusb.js your program's local folder. Finally, install SerialPort library using `npm install serialport`.

We can now instantiate and get the DUELink controller ready. We will be using SerialUSB() here. If using a web browser, use WebSerial() instead.


## Blinky!

Our first program will blink the on-board LED 20 times, where it comes on for 200ms and then it is off for 800ms.

```js
import {SerialUSB} from './serialusb.js';
import * as DUELink from './duelink.js';

let duelink = new DUELink.DUELinkController(new SerialUSB());
await duelink.Connect();

// Flash the LED 20 times (on for 200ms and off for 800ms)
await duelink.Led.Set(200,800,10);
```

## JavaScript API

The [API](../api/intro.md) page includes all details and examples to use all the available "physical world" services.

