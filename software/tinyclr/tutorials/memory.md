# Memory Management
---

## RAM Memory
This memory type loses its contents when the system is turned off. The system uses this memory at runtime to quickly store and retrieve data. TinyCLR OS is a managed operating system -- objects in RAM are automatically tracked and freed as needed. The Garbage Collector (GC) runs when the system is low on available RAM, where it will look for unused objects and free the memory they occupy. You may also invoke the GC at any time using `System.GC.Collect()`.

RAM is the main workspace for your application -- running out of memory will cause your application to fail. It is important to understand the memory needs of your application and to plan accordingly. When creating a buffer for a UART for example, use a reasonable size buffer that's large enough to handle your communication needs without being so large as to waste memory.

### RAM Memory Size
The amount of free and used memory can be shown at runtime, which can be helpful for debugging and optimizing your application.

```cs
var freeRam = GHIElectronics.TinyCLR.Native.Memory.ManagedMemory.FreeBytes;
var usedRam = GHIElectronics.TinyCLR.Native.Memory.ManagedMemory.UsedBytes;
```

### Allocating Memory
The TinyCLR OS Garbage Collector allocates and frees objects automatically on the heap. When the memory gets fragmented, the system will compact the heap. This is desired behavior, but this also creates a problem when sharing resource between TinyCLR OS and native drivers. In a more advanced application, a user may have a buffer that gets written from an interrupt routine. Assuming this is implemented in native code, we would need a buffer that always sits at a fixed address. Using `var buffer = new byte[12]` will not work as the garbage collector may move the buffer to compact the heap.

A fixed location buffer can be allocated using `GHIElectronics.TinyCLR.Native.Memory.ManagedMemory.Allocate()`. Keep in mind that this is not managed memory anymore, and you are responsible for freeing this memory using `GHIElectronics.TinyCLR.Native.Memory.ManagedMemory.Free()`.

### Memory Allocation Cost
Creating and disposing of objects is costly, especially when done in inner loops. The following code sends 10,000 bytes from an array over a network one byte at a time.

```cs
for (int i=0; i<10000; i++) {
    var byteArray = new byte[1];
    
    byteArray[0] = arrayData[i];

    Network.SendByteArray(byteArray);
}
```

The code will work just fine, but as byteArray[] is created within the loop, 10,000 single element byte arrays will be created and disposed of. It is much more efficient to create the array only once.

```cs
byte[] byteArray = new byte[1];

for (int i=0; i<10000; i++) {
    byteArray[0] = arrayData[i];

    Network.SendByteArray(byteArray);
}
```

### Disposing of Objects
As TinyCLR OS is a managed system that monitors and frees resources, memory leaks are less of a concern than they are for unmanaged systems. However, there is still chance that issues can arise, especially in embedded systems where objects can be a combination of memory and other hardware. Take a GPIO pin for example. What happens when we no longer have a reference to a GPIO pin? Will the GC free the object? Will the pin change in state when the GC frees the pin? And finally, why would a pin (or any physical object) be left for the GC to decide how it should be freed? The answer is that we need to understand and track these resources manually.

This example code will declare and initialize a GPIO pin in a function, causing the main program to lose control of the pin. The `BadExample` method uses the LED's GPIO pin, but it doesn't free it.

```cs
class Program {
    static void Main() {
        BadExample();

        //The following line will raise an exception:
        var led = GpioController.GetDefault().OpenPin(SC20100.GpioPin.PE11);
        led.SetDriveMode(GpioPinDriveMode.Output);
        led.Write(GpioPinValue.Low);
    }

    static void BadExample() {
        var led = GpioController.GetDefault().OpenPin(SC20100.GpioPin.PE11);
        led.SetDriveMode(GpioPinDriveMode.Output);
        led.Write(GpioPinValue.High);
    }
}
```

The next example will `Dispose` of the pin and the code will work; however, disposing the pin may take the pin back to its default state. There is no exact definition on what a piece of hardware (the GPIO pin in this example) does when disposed.

```cs
class Program {
    static void Main() {
        GoodExample();

        //This code will now work
        var led = GpioController.GetDefault().OpenPin(SC20100.GpioPin.PE11);
        led.SetDriveMode(GpioPinDriveMode.Output);
        led.Write(GpioPinValue.Low);
        //...
    }    

    static void GoodExample() {
        var led = GpioController.GetDefault().OpenPin(SC20100.GpioPin.PE11);
        led.SetDriveMode(GpioPinDriveMode.Output);
        led.Write(GpioPinValue.High);

        //Free the pin, but this may cause the pin to revert to its default state.
        led.Dispose();
    }
}
```

The following example shows the best way to handle the situation by moving the LED object declaration, so it is available and accessible to the entire class.

```cs
class Program {
    static GpioPin led; //You can now use 'led' anywhere within 'Program'

    static void Main() {
        // Init the hardware
        led = GpioController.GetDefault().OpenPin(SC20100.GpioPin.PE11);
        led.SetDriveMode(GpioPinDriveMode.Output);

        Example();

        led.Write(GpioPinValue.Low);
    }

    static void Example() {
        led.Write(GpioPinValue.High);
    }
}
```

### Garbage Collection

TinyCLR OS automatically disposes of objects that are no longer needed. Garbage collection eliminates the need to manage memory manually and reduces or eliminates some types of bugs.

The act of garbage collection can temporarily reduce the responsiveness of your system, so it may be beneficial to actively manage garbage collection to improve real time response. Garbage collection will usually only run when there is a failed memory allocation, so by properly structuring your program you should be able to eliminate garbage collection or greatly reduce it. String operations are particularly troublesome in the creation of garbage as strings are immutable.

To reduce garbage collection, minimize the use of dynamically allocated buffers and minimize allocations in routines that get called often by preallocating or using static objects. Minimize string manipulation. As strings are immutable, manipulating a string creates a new string and the old string becomes garbage. Using [StringBuilder](encoding-decoding.md) to manipulate strings may help reduce garbage generation.

You can use `System.GC.GetTotalMemory(true)` to find out how much memory is being used. the "true" argument forces full garbage collection. Checking free memory often during program execution will let you know if the amount of free memory is decreasing and how quickly. 

`System.Diagnostics.Debug.GC(true)` will force garbage collection. You might use this to ensure that garbage collection occurs during a period when responsiveness is less important.

`System.Diagnostics.Debug.EnableGCMessages(true)` can be used to make sure that garbage collection messages are sent out over the debug port.

TinyCLR also supports unmanaged heap space. Unmanaged heap space can be used for large graphic buffers, for example. In unmanaged heap space, it is up to the programmer to make sure memory is correctly allocated and deallocated. Read more about unmanaged heap space [here](unmanaged-heap.md).
#### Finalizers

The Garbage Collector does a lot of work in the background. To keep the system running smoothly, some of this work is done when the system is idle, like running finalizers and compacting the heap. When the system running a tight loop with continuous allocations, there will be no idle time for the Garbage Collector to finish its tasks. In this case, it is possible to force the Garbage Collector to finish the tasks.

```cs
System.GC.Collect();
System.GC.WaitForPendingFinalizers();

```

### Battery Backed RAM

SITCore devices support 4 KBytes of battery backed RAM. Details can be found in the [Real Time Clock Tutorial](real-time-clock.md).

---

## Flash Memory
Flash memory does not lose its contents on power loss. There are special requirements to write to Flash, but you can read Flash just like RAM. When deploying a program, the `TinyCLR Device Deployment` window will show what is being loaded and how large it is. It will then show how much free Flash is still available.

> Assemblies deployed. There are 2,408,408 bytes left in the deployment area.

Flash is not typically written to at runtime. The system will function even with no free available FLASH.

### Resources
TinyCLR OS allows resources, like fonts and images, to be merged into the project as a resource and then deployed to the device's Flash. Those resources can then be fetched into RAM and used at runtime. The [Resource](resources.md) tutorial has more details.

### Direct Access
Writing to Flash (persistent storage) is supported securely through [secure storage.](secure-storage.md)



