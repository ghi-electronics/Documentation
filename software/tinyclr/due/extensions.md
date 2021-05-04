## DUE - Extensions
---
Extensions are user defined functions that reside in the environment until called, they are just like any other functions in the script however these functions are provided from the TinyCLR C# side.


## Defining Extensions
A static class is used to implement the extensions. Each static method in this class become available to scripts.

```cs
static class ExtensionLibrary {
    public static void ExtensionFuncSample(string arg) {
        Debug.WriteLine("Arg: " + arg);
    }

    public static int ExtensionAdder(int arg1, int arg2) {
        return arg1 + arg2;
    }        
}
```
Constants (const in DUE) can also be made available to the DUE system using `readonly` C# keyword.

```cs
static class ExtensionLibrary {
    public static void TestSample(int arg) {
        Debug.WriteLine("Arg: " + arg);
    }
    public readonly int PE11 = 75;
```
Any members of the extension that should not be accessed from within DUE scripts should not be made `public`.

> [!TIP]
> Variable binding is not supported and should not be used, only use variables that are `readonly`.

## Acessing Extensions

The DUE `ScriptEngine` does all the necessary magic internally. The user only needs to provide the extension class.

```cs
var script = new ScriptEngine(typeof(ExtensionLibrary));

script.Run(@"ExtensionFuncSample(""Hello DUE!"")
var x = ExtensionAdder(44, 77)
ExtensionFuncSample(""x: "" + x)
");
```

Similar to any other functions in DUE, extensions can also be invoked from the engine directly `engine.Invoke("ExtensionFuncSample","Hello DUE!")`.


## Example

```cs
// Non-public functions and member variables are not loaded into the script engine
static class GpioExtension {
    private static Hashtable pins = new Hashtable();
    private static GpioController gpio = GpioController.GetDefault();

    // Public static redonly member variables will be exposed as constants in the engine
    public static readonly int On = 1;
    public static readonly int Off = 0;

    // DigitalPin - Return a Pin object for the specified pin
    public static object DigitalPin(int pinNumber) {
        if (!pins.Contains(pinNumber)) {
            pins[pinNumber] = gpio.OpenPin(pinNumber);
        }
        return pins[pinNumber];
    }

    // WritePin - Write the state to the pin
    public static void WritePin(object pin, int state) {
        if (pin is GpioPin gpioPin) {
            gpioPin.SetDriveMode(GpioPinDriveMode.Output);
            gpioPin.Write(state == 0 ? GpioPinValue.Low : GpioPinValue.High);
        }
        else {
            throw new InterpreterException("Not a valid pin");
        }
    }

    // ReadPin - Read the current state of the pin
    public static int ReadPin(object pin) {
        if (pin is GpioPin gpioPin) {
            gpioPin.SetDriveMode(GpioPinDriveMode.Input);
            return gpioPin.Read() == GpioPinValue.High ? 1 : 0;
        }
        else {
            throw new InterpreterException("Not a valid pin");
        }
    }
}
```