# Memory Management
---

## RAM Memory
This memory type loses its content when the system is turned off. The system uses this memory at runtime to function. TinyCLR OS is a managed operating system. Allocated objects are automatically tracked and freed as needed. The Garbage Collector (GC) runs when the system runs low on available RAM, where it will look for unused objects and frees the memory they had occupied. You may also invoke the GC at any time using `GC.Collect()`.

RAM is used a lot at runtime. It is important to understand needed memory and plan accordingly. When creating a data receiving buffer from UART for example, use a reasonable size that you really need.

### RAM Memory Size
Free and used memory sizes can be measured at runtime. This helps in optimizing systems.

```cs
var freeRam = GHIElectronics.TinyCLR.Native.Memory.ManagedMemory.FreeBytes;
var usedRam = GHIElectronics.TinyCLR.Native.Memory.ManagedMemory.UsedBytes;
```

### Allocating Memory
TinyCLR OS Garbage Collector allocates and frees objects automatically on the heap. When the memory gets fragmented, the system will compact the heap. This is the desired behavior, but this also creates a problem when sharing resource between TinyCLR OS and native drivers. In advance setup, a user may have a buffer that gets written to from an interrupt routine. Assuming this is implemented in native code, we would need a buffer that always sits at a fixed address. Using `var buffer = new byte[12];` will not work as the garbage collector may move the buffer to compact the heap.

A fixed location buffer can be allocated using `GHIElectronics.TinyCLR.Native.Memory.ManagedMemory.Allocate()`. Keep in mind that this is not managed memory anymore and you are responsible to free this memory using `GHIElectronics.TinyCLR.Native.Memory.ManagedMemory.Free()`.

### Memory Allocation Cost
Creating/disposing objects is costly, especially when used in inner loops. Assuming there is a method that sends a byte array over a buses/network. Also assuming we there is a byte that needs to be sent. We will need to create a byte array of size one.

```cs
void WritByte(byte b) {
    var ba = new byte[1];
    // use that byte
    ba[0] = b;
    Network.SendByteArray(ba);
}
```

The code will work just fine but if it is being used in inner loops and it is being called 1000/second, then it will need to create and lose 1000 individual arrays. The system will run better if the array is created only once.

```cs
byte[] ba = new byte[1];
void WritByte(byte b) {
    // use that byte
    ba[0] = b;
    Network.SendByteArray(ba);
}
```

### Disposing Objects
With TinyCLR OS being managed system that monitors and frees resources, memory/object leaks become less of a concern. However, there is still chance that issues can arise, especially in embedded systems, where objects can be a combination of memory and a physical thing. Take a GPIO pin for example. What happens when we no longer have a reference to a pin? Will the GC free the object? Will the pin change in state when the GC frees the pin? And finally, why would a pin (or any physical object) be left for the GC to decide how it should be freed? The right answer is that we need to understand and track these resources manually.

This example code will turn an LED on but we it not be able to control that pin anymore. The `BadExample` method uses a pin but it doesn't free it.

```cs
class Program {
    static void BadExample() {
        var led = GpioController.GetDefault().OpenPin(SC20100.GpioPin.PB0);
        led.SetDriveMode(GpioPinDriveMode.Output);
        led.Write(GpioPinValue.High);
    }

    static void Main() {
        BadExample();
        // This code will raise an exception
        var led = GpioController.GetDefault().OpenPin(SC20100.GpioPin.PB0);
        led.SetDriveMode(GpioPinDriveMode.Output);
        led.Write(GpioPinValue.Low);
        //...
    }
}
```

This example will `Dispose` the pin and the code will work; however, disposing the pin may take the pin back to the default state. There is no exact definition on what a piece of hardware (pin in this example) does when disposed.

```cs
class Program {
    static void GoodExample() {
        var led = GpioController.GetDefault().OpenPin(SC20100.GpioPin.PB0);
        led.SetDriveMode(GpioPinDriveMode.Output);
        led.Write(GpioPinValue.High);
        // Free the pin, but this may change the pin status to default
        led.Dispose();
    }

    static void Main() {
        GoodExample();
        // This code will now work
        var led = GpioController.GetDefault().OpenPin(SC20100.GpioPin.PB0);
        led.SetDriveMode(GpioPinDriveMode.Output);
        led.Write(GpioPinValue.Low);
        //...
    }
}
```

In this basic example, the fix can be in moving the LED object to be always available and accessible to the entire class.

```cs
class Program {
    static GpioPin led;

    static void Example() {
        led.Write(GpioPinValue.High);
    }

    static void Main() {
        // Init the hardware
        led = GpioController.GetDefault().OpenPin(SC20100.GpioPin.PB0);
        led.SetDriveMode(GpioPinDriveMode.Output);
        // You can use the pin everywhere now
        // ... in the method
        Example();
        // ... and here
        led.Write(GpioPinValue.Low);
        //...
    }
}
```

### Garbage Collection

TinyCLR OS automatically disposes of objects that are no longer needed. Garbage collection eliminates the need to manage memory manually, and reduces or eliminates some types of bugs.

The act of garbage collection can temporarily reduce the responsiveness of your system, so it may be beneficial to actively manage garbage collection to improve real time response. Garbage collection will usually only run when there is a failed memory allocation, so by properly structuring your program you should be able to eliminate garbage collection or greatly reduce it. String operations are particularly troublesome in the creation of garbage as strings are immutable.

To reduce garbage collection, minimize the use of dynamically allocated buffers and minimize allocations in routines that get called often by preallocating or using static objects. Minimize string manipulation. As strings are immutable, manipulating a string creates a new string and the old string becomes garbage. Using StringBuilder to manipulate strings may help reduce garbage generation.

You can use `GC.GetTotalMemory(true)` to find out how much memory is being used. Checking free memory often during program execution will let you know if the amount of free memory is decreasing and how quickly. 

You can use `Debug.GC(true)` to force garbage collection. You might use this to ensure that garbage collection occurs during a period when responsiveness is less important.

`Debug.EnableGCMessages(true)` can be used to make sure that garbage collection messages are sent out over the debug port.

TinyCLR also supports unmanaged heaps. Unmanaged heap space can be used for large graphic buffers, for example. In unmanaged heap space, it is up to the programmer to make sure memory is correctly allocated/deallocated. Read more about unmanaged heap space [here]().

### Battery Backed RAM

SITCore devices support 4 Kbytes of battery backed RAM. Details can be found in the [Real Time Clock Tutorial](real-time-clock.md).

## Flash Memory
Flash memory does not lose its content on power loss, like an SD memory card for example. There are special requirements to write to flash but you can read Flash just like RAM. When deploying a program, the `TinyCLR Device Deployment` window will show what is being loaded and how large it is. It will then show how much free Flash is still available. 

> Assemblies deployed. There are 2,408,408 bytes left in the deployment area.

Flash is not typically written to at runtime. The system will function even with no free available FLASH.

### Resources
TinyCLR OS allows resources, like fonts and images, to be merged into the project as a resource and then deployed to the device's flash. Those resources can then be fetched into RAM and used at runtime. The [Resource](resources.md) tutorial has more details.

### Direct Access
Unsupported at this time.

> [!Tip]
> You can only read from Flash, not write.




