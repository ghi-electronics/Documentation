# IP Protection
---
Designed with security as a top priority, your intellectual property is protected through application protection, secure encrypted in-field update, and secure booting.

## Application Protection

Companies need a way to protect their applications from piracy: TinyCLR OS running on SITCore devices gives you exactly what you need!

### Disabling the Debug Interface

As USB and serial ports are used for application deployment and debugging, these interfaces can also be used by unauthorized parties to read or pirate your application. TinyCLR OS can prevent unauthorized access with a single command that disables the debug interface:

```csharp
GHIElectronics.TinyCLR.Update.Application.Lock()
```

As this instruction is stored internally in non-volatile flash, it is persistent and the chip can only be unlocked by completely erasing the device through the bootloader. This also erases your application, so locking the chip provides a great deal of security for your application.

You can also check what interface is active, or if it is disabled:

```csharp
GHIElectronics.TinyCLR.Native.DeviceInformation.DebugInterface
```

Once you lock your device, everyone, including you and GHI Electronics, is locked out of accessing and debugging your application. So how do you update your device?

The first step is to create an encrypted copy of the application. This is easily done using TinyCLR Config tool. You need to enter a key, or the tool will generate a key for you. The tool will then read the application, encrypt it, and store the encrypted application and the key as files on your machine. Of course, this needs to be done before you disable the debug interface on your device!

You can now use the application deployment to deploy to other devices. This is good for mass production as well. Do not forget that you need the key if you are sending the deployment to a contract manufacturer.

## In-Field Update

The application deployment can be loaded by your customer securely. You can send the application deployment to the field (the customer) as a file in an email or automate it using the cloud. You have options. Of course, when you send the application deployment out to the field, you would not send the key with it. They key is securely stored inside your application, in your in-field update code. Check out our [In-Field Update](in-field-update.md) tutorial for implementation information.
