# Python

---

![Python](../images/python.png)

Python is the main language used with AI and data science. The provided DUELink Python library allows a full standard Python program to access physical world. For example, an AI vision facial recognition can now control a door lock.

## Setup
This page assumes the user is already familiar with Python and there is a development machine that is already setup to build and run Python programs. No changes are needed there but we are using Microsoft Visual Studio Code as a personal preference.

> [!TIP]
> Make sure your hardware is updated with the latest firmware listed on the [downloads](..\downloads.md) page.

Start a new project with a simple line of code to test out the project is running.

```py
print("Hello DUELink!")
```

We now need to install the DUE Python library `pip install DUELink`. The DUELink package will also install all required dependencies.

> [!Tip]
> The DUE python library requires pyserial, which may require an admin access to install.

## Blinky!
Our first program will blink the on-board LED 20 times, where it turns on for 200ms and then it shuts off for 800ms.

```py
from DUELink.DUELinkController import DUELinkController
print("Hello DUE!")
availablePort = DUELinkController.GetConnectionPort()
duelink = DUELinkController(availablePort)
# Flash the LED 20 times (on for 200ms and off for 800ms)
duelink.Led.Set(200,800,20)
print("Bye DUE!")
```

## Python API

The [API](../api/intro.md) page includes all details and examples to use all the available "physical world" services.

Use the above example program to initiate the hardware instantiate the `duelink` object and then use any of the available APIs, such as `duelink.Sound.Beep('p', 500, 1000)' to generate a one second 500Hz beep using the on-board peizo buzzer.