# User Interface

---
## Avalonia UI
Creating beautiful and functional User Interfaces is much easier on a hardware device when developers can use existing .NET APIs. 

Avalonia UI is an open-source UI framework for building stunning desktop, mobile, web, and embedded applications using a .NET single codebase.  Their API can be found [here.](https://docs.avaloniaui.net/docs/welcome)

Endpoint takes advantage of Avalonia UI's cross-platform WPF. The `GHIElectronics.Endpoint.Drivers.Avalonia.Input` combined with the standard Avalonia NuGet package includes everything you need. 

Included on the [Endpoint Samples Repo](https://github.com/ghi-electronics/endpoint-samples) is a simple working example to get started with. 

---

## Virtual Keyboard
To help create a seamless UI experience on embedded devices we've created a virtual keyboard driver. This virtual keyboard is built into the Avalonia driver and can also be used stand-alone in any project. Implementation is simple.

```cs
var keyboard = new VirtualKeyboard(displayController);

touch.TouchUp += (a, b) =>{
keyboard.UpdateKey(b.X, b.Y);
};

keyboard.Show();
```

The [Endpoint Samples Repo](https://github.com/ghi-electronics/endpoint-samples) contains the full virtual keyboard example.