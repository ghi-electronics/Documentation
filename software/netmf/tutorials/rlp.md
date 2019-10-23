# Runtime Loadable Procedures
---

## Introduction
In .NET Micro Framework, C#  is complied to an intermediate languages that is interpreted by the Common Language Runtime (CLR). The C# you write is not executed directly by processor. In a typical application, you will not see much difference in speed as many objects used in your application are implemented as native code internally and are not interpreted. When running processor intensive tasks, like cryptography algorithms or even as simple as calculating CRC, however, you will likely notice the interpreter overhead. GHI's Runtime Loadable Procedures (RLP) allow you to write and compile native code that you load onto the device and execute from the interpreted C#.

## Installing the compiler
Since you are writing native code for an ARM device, you cannot easily use Visual Studio. Yagarto provides a helpful toolchain for compiling native code for ARM.

Download and then install the following programs in order. Make sure the install paths do not have any spaces in them. Compiling will not function if they do.

* yagarto-bu-2.23.1_gcc-4.7.2-c-c++_nl-1.20.0_gdb-7.5.1_eabi_20121222.exe
* yagarto-tools-20121018-setup.exe

You can verify the correct installation by running make --version and arm-none-eabi-gcc --version from a command prompt.

## Getting Started
Download and extract the samples found [here](http://files.ghielectronics.com/downloads/NETMF/RLP%20Examples.zip).

The RLP.h file found in the Native directory is a header that defines our extensions and helpers that make it easier to write your native code. You will also see a folder for each supported platform. Within each platform, there are four files.

makefile and LinkerScript.lds are basic scripts that we provide to get started with compiling your program. You will not normally need to edit them.

Build.bat will actually compile your code for you and produce an elf and map file as output.

NativeCode.c is an example file that shows you some basic functions. You can modify it and add your own functions. Every function you write that you want to be called from managed code must have the following signature:

```
int YourFunc(void** args);
```

When you invoke that function from the managed side, any arguments you pass will be found in that void** parameter. If you pass five arguments, then args will be an array of five void pointers. It is your job to then cast each of these pointers to their native equivalent. The following table shows the supported NETMF parameter types and their native equivalent:

| C# Parameter | Native Parameter |
| byte | unsigned char |
| sbyte | char |
| short | short |
| ushort | unsigned short |
| int | int |
| uint | unsigned int |
| long | long |
| ulong | unsigned long |
| float | float |
| double | double |
| bool | unsigned char |
| Bitmap | unsigned short[] |

Arrays of each of the above parameters (except bitmaps) are also supported. When passing a non-array parameter, it is by value. Any changes to these parameters on the native side are not seen on the managed side. Arrays, however, are passed by reference. Any change to the value of a member of an array is seen on the managed side. Make sure to not read or write past the end of the array. It is up to you to track its length, perhaps through a second parameter you pass.

For example, imagine you have passed an integer, a byte array, its length, and a boolean down to the native side. You can retrieve those parameters using the following code:

```c
int YourFunc(void** args) {
	int arg1 = *(int*)(args[0]); //the integer
	unsigned char* arg2 = (unsigned char*)(args[1]); //the byte array
	int arg3 = *(int*)(args[2]); //the length of the byte array
	unsigned char arg4 = *(unsigned char*)(args[3]); //the boolean
}
```
When you pass a primitive value, you simple cast the void pointer to a pointer of the corresponding native type and dereference it. When the argument is an array, you again cast the void pointer to a pointer of the corresponding native type but you do not reference it. You can dereference that pointer as if it were an array. Again, make sure to not read beyond its length.

> [!Warning]
> Make sure you do not store the pointer to a passed array parameter between function invocations. The array is managed by the CLR and the garbage collector may relocate it between invocations. If you want to pass data outside of the parameters to Invoke for performance reasons, you can allocate a buffer on the native side and return its address to managed code. From there, you can read and write to that buffer using Register and AddressSpace.

## Compiling
Once you have written your code, in the folder that contains makefile, LinkerScript.lds, and NativeCode.c run the file Build.bat. You will see some compiler output and an elf and a map file will appear in the directory. Both files will be called [board name]RLP. The ELF file is the one that you will need to load into RLP from the managed code.

To be able to invoke the native function from managed code, you must get the compiled ELF file into a byte array in the managed side. You can save the ELF file as a resource, to an SD card, or to the network and then read or download it.

> [!Warning]
> If the native code you execute hangs or crashes, NETMF and the device will become unresponsive. It is recommended that you do not execute any RLP code as soon as the board boots because if it crashes you will have no way to redeploy a program requiring you to completely erase and reflash the board.

## Invoking Your Function
The below code shows you how to load the byte array representing the ELF file into RLP and calling it natively. (It assumes you have added the ELF file as a resource to your C# project.) You pass the name of your native function into the FindFunction function and it will return an object that you can call Invoke() on and pass parameters. We will use the same four parameters as above, an integer, byte array, its length, and a boolean. This code requires the GHI.Hardware assembly.

```cs
using GHI.Processor;
using Microsoft.SPOT;

public class Program
{
    public static void Main()
    {
        byte[] elfBuffer = Resources.GetBytes(Resources.BinaryResources.ELFFile); //Make sure to load the ELF file you compiled into this array.

        var elfImage = new RuntimeLoadableProcedures.ElfImage(elfBuffer);

        var yourFunction = elfImage.FindFunction("YourFunc");
        var byteArray = new byte[] { 25, 5, 0 };
        int anInteger = 5;

        var result = yourFunction.Invoke(anInteger, byteArray, byteArray.Length, true);

        Debug.Print("The function returned " + result.ToString()); //Should be 5
        Debug.Print("The third element of the byte array is " + byteArray[2].ToString()); //Should be 30
    }
}
```
Now imagine we defined the native function like this:

```c
int YourFunc(void** args) {
	int arg1 = *(int*)(args[0]); //the integer
	unsigned char* arg2 = (unsigned char*)(args[1]); //the byte array
	int arg3 = *(int*)(args[2]); //the length of the byte array
	unsigned char arg4 = *(unsigned char*)(args[3]); //the boolean

	if (arg4 != 0)
		arg2[2] = arg2[0] + arg2[1];
  
	return arg1;
}
```
The first parameter, the integer, is returned from the function. You can access that value as the return value of the Invoke function in the managed side. The above C# example prints out that value.

If the fourth parameter, the boolean, is not false (0 is false, otherwise it is true) we will add the first and second elements of the byte array and store the result in the third element. You will see the change to the array in the managed side.

## Events and Tasks
Sometimes you might have a long running function that runs in RLP. Since RLP blocks the managed side, nothing else on the board will run for the duration of the that function call. Using RLP tasks, your native function can register a function to be called at some future point so that you can return to NETMF. As long as this callback function is short lived, the managed side will continue to execute.

You can break your work up into smaller chunks that are worked on during each callback invocation. When you are done, you can trigger an event on the managed side. Make sure to re-register the callback so long as there is more work to do.

The below example passes the first and only argument passed to RLP into the task and then fires that many events. It schedules itself to fire again in one second until the parameter is zero.

```c
RLP_Task task;

void TaskCallback(void* arg)
{
	unsigned int* count = (unsigned int*)arg;
	
	RLP->PostManagedEvent(*count);
		
	if (*count > 0)
	{		
		*count -= 1;
		
		RLP->Task.ScheduleTimeOffset(&task, 1000000);	
	}
	else
	{
		RLP->Task.Abort(&task);
	}
}

int StartTask(void** args)
{
	RLP->Task.Initialize(&task, TaskCallback, args[0], RLP_FALSE);
	RLP->Task.Schedule(&task);
	
	return 1;
}
```
As before, we create and invoke the RLP function object but we also subscribe to the NativeEvent event and then print out the value received. Every time PostManagedEvent is called from the native side, this event will be fired with the data passed to it. In this example, it should be fired six times, printing out 5, 4, 3, 2, 1, and then 0.

```cs
using GHI.Processor;
using Microsoft.SPOT;
using System.Threading;

public class Program
{
	public static void Main()
	{
		byte[] elfBuffer = Resources.GetBytes(Resources.BinaryResources.ELFFile); //Make sure to add an ELF file as a resource

		RuntimeLoadableProcedures.NativeEvent += RuntimeLoadableProcedures_NativeEvent;

		var elfImage = new RuntimeLoadableProcedures.ElfImage(elfBuffer);
		var startTask = elfImage.FindFunction("StartTask");
		
		startTask.Invoke(5);

		Thread.Sleep(-1);
	}

	private static void RuntimeLoadableProcedures_NativeEvent(object sender, RuntimeLoadableProcedures.NativeEventEventArgs e)
	{
		Debug.Print("We've received " + e.Data.ToString() + " from the native side."); //Should be 5 to 0
	}
}
```

## Bitmaps
You can also pass bitmaps to RLP. You will receive an unsigned short array in the argument list. Changes made to that array will be reflected in the bitmap back in C#. As with all arrays, make sure not to save it between invocations or read beyond its end. Its length is equal to bitmap.Width x bitmap.Height.

Each entry in the array represents one pixel in RGB 565 format. You can access a pixel using the following code:

```c
void SetPixel(unsigned short* bmp, int x, int y, int bitmapWidth, unsigned short color)
{
	bmp[y * bitmapWidth + x] = color;
}
```

Multiple Files
If you load more than one ELF image at a time, you must be sure that all images after the first occupy a unique location in RAM. The header and linker scripts we provide place the ELF image at a certain default location. You must change that for the second file so that you do not overwrite the first file when you load the second. When compiling, you should see a map file created as one of the outputs. This file tells you exactly how big and where each function is located. You can use it to determine where your second image must start.
