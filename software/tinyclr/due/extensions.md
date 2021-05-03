## DUE - Extensions
---
Extensions are user defined functions that reside in the environment until called, they are just like any other functions in the script however these functions are provided in C# on the TinyCLR side.


## Defining the extension

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

## Executing the extension

From the script

```cs
var script = new ScriptEngine(typeof(ExtensionLibrary));

script.Run(@"ExtensionFuncSample(""Hello DUE!"")
var x = ExtensionAdder(44, 77)
ExtensionFuncSample(""x: "" + x)
");
```

Similar to any other functions in DUE, extensions can also be invoked from the engine directly `engine.Invoke("ExtensionFuncSample ","Hello DUE!")`