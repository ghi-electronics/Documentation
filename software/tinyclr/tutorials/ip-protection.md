# IP Protection
---
Designed with security as a top priority, TinyCLR OS provides protection for both code and data.

## Application Protection
Companies need a way to protect their applications from piracy -- TinyCLR OS running on SITCore devices gives you exactly what you need!

### Secure Assemblies
Secure assemblies are assemblies that are deployed only to flash memory internal to the processor. As this secure code never leaves the SITCore processor, it is very difficult for anyone to access or copy your code. By default, all assemblies are deployed to internal flash memory. Unless external flash is enabled, assemblies will never be deployed to external flash.

However, if external flash is enabled, assemblies will be deployed to external flash when the amount of internal flash is running low. In such cases, we have provided a way to protect your most sensitive code. By tagging an assembly as secure, you can ensure that it will never be deployed to external flash. If there is not enough internal flash to hold all of the secure assemblies, an out of memory exception will be raised.

To tag an assembly as secure, you will have to edit the `AssemblyInfo.cs` file in the `Properties` folder within your project's folder. Change the line `[assembly: AssemblyConfiguration("")]` to `[assembly: AssemblyConfiguration("secure")]` (the word "secure" is case insensitive). If this is not done, by default the assembly will not be secure. Note that this only matters when external flash is enabled and the size of the assemblies is larger than the internal flash capacity.

During deployment Visual Studio will display an allocation table showing both the secure and unsecure assemblies and their address, so it is easy to check the security status of your assemblies. This is found in the `TinyCLR Device Deployment` Visual Studio output window.

### Disabling the Debug Interface
As USB and serial ports are used for application deployment and debugging, these interfaces can also be used by unauthorized parties to read or pirate your application. TinyCLR OS supports disabling of the debug interface to prevent unauthorized access. You can disable the debug interface with the [TinyCLR Config](../tinyclr-config.md) utility program or with the following method:

```cs
GHIElectronics.TinyCLR.Update.Application.Lock()
```

As this instruction is stored internally in non-volatile flash, it is persistent and the chip can only be unlocked by completely erasing the device through the bootloader. This also erases your application, so locking the chip provides a great deal of security for your application.

You can also check what interface is active, or if it is disabled:

```cs
GHIElectronics.TinyCLR.Native.DeviceInformation.DebugInterface
```

Once you lock your device, everyone, including you and GHI Electronics, is locked out of accessing and debugging your application. So how do you update the application code on your device?

The first step is to create an encrypted copy of the application. This is easily done using the [TinyCLR Config](../tinyclr-config.md) tool. You need to enter a key, or the tool will generate a key for you. The tool will then read the application, encrypt it, and store the encrypted application and the key as files on your machine. Of course, this needs to be done before you disable the debug interface on your device!

You can now use application deployment to deploy to other devices. This is good for mass production as well. If you are sending the deployment to a contract manufacturer, remember to send the key too!

### In-Field Update
You can use [TinyCLR Config](../tinyclr-config.md) to create an encrypted application deployment that can be securely loaded by your customer. You can send this application deployment to the field (the customer) as a file in an email or automate it using the cloud. You have options. Of course, when you send the application deployment out to the field, you would not send the key with it. They key is securely stored inside your application, in your in-field update code. Check out our [In-Field Update](in-field-update.md) tutorial for implementation information.

## Secure RAM
SITCore devices provide security for your sensitive data by using RAM that is inside the processor, making it almost impossible to get at your data. However, sometimes additional RAM is needed by your application. TinyCLR OS allows you to extend the heap into external SDRAM (if supported by your hardware). Please refer to the [External Memory](external-memory.md) page for more info. However, the impact upon data security must be considered when the heap is extended.

### Extending Heap
While extending the heap into external SDRAM provides more RAM for your application, it also reduces security as it is possible for bad actors to probe the memory interface and reconstruct your data.

If you are storing sensitive data in RAM, extending heap memory will reduce security. To keep data secure it is best not to extend the heap. If you need more RAM and must extend the heap, encrypt or obfuscate sensitive data before storing it in RAM if possible. The other option is to include a physical barrier to the circuit, such as potting the circuit board, to make it more difficult to probe the data.