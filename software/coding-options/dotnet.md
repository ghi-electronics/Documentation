
# .NET

---

![.NET C#](../images/cSharp.png)

The .NET DUE library allows full .NET programs to access physical sensors and actuators. This allows complex .NET programs to do all the heavy lifting and send only the necessary components to control devices.

The provided library is implemented in C# but the user can use any .NET system, such as Visual Basic.

## Setup
This page assumes the user is already familiar with .NET C# and there is a development machine that is already setup to build and run .NET programs. No changes are needed there but we are using Microsoft Visual Studio Code as a personal preference.

> [!TIP]
> If this is the first time you use your device, start by visiting the [Hardware](../../hardware/intro.md) page and load your device with the appropriate firmware. The [Console](../console.md) is also a great place to start.

Start a new project with a simple line of code to test out the project is running

> [!TIP]
> C# Top level statements feature is being utilized.

```csharp
Console.WriteLine("Hello, World!");

```

Download and install the latest library from NuGet.org. Alternatively, get it from the [Downloads](../downloads.md) page.

## Blinky!
Our first program will blink the on-board LED 20 times, where it comes on for 200ms and then it is off for 800ms.

> [!NOTE]
> We can access which COM port our DUE enable device is connected to by calling the GetConnectionPort()

```csharp
using GHIElectronics.Due;
Console.WriteLine("Hello DUE!");
var availablePort = DueController.GetConnectionPort();
var dev = new DueController(availablePort);
dev.Led.Set(200, 800, 20);
Console.WriteLine("Bye DUE!");
```

## .NET API

The provided API mirrors DUE Script [Core library](../due-script/corelib/corelib.md). Referencing those APIs is a good place to learn about the available functionality.
