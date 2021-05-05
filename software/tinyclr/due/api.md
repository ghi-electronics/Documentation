# DUE - API
---

The DUE API is designed to give full access of the `ScriptEngine` in a simple user-friendly way.

> [!TIP]
> We will assume `GpioExtension` sample from [Extensions](extensions.md) is being used.

## Run

This method will execute a script.

```cs
var script = new ScriptEngine(typeof(GpioExtension));

script.Run(@"
	var led = DigitalPin(4*16+11)//PE11
	func OnOff()
		writePin(led, On)
		Delay(100)
		writePin(led, Off)
		Delay(100)
	end
");
```
## Invoke
A function that is found in a script can be executed from C# directly using `script.Invoke("OnOff")`. 

Arguments are passed to `Invoke` with a returned result, `sum = Invoke("Add", a, b)`.

## GetFunction

A faster way to invoke a function will be by reference

```cs
var OnOffPointer = script.GetFunction("OnOff");
script.Invoke(OnOffPointer);
```
## GetVariable

Returns the value of a specific variable `x = script.GetVariable("x")`

The return value is an object. In the case of returned variable being an array in DUE, ArrayList is returned.

## SetVariable

Sets a variable that lives in a DUE script from C# `script.SetVariable("x",123)`.

## SetConsole

Redirects the Console Statements.

```cs
class ConsoleExample : IConsole {
	public void Cls() { }
	public void Locate(int row, int col) { }
	public void Print(string s) => Debug.WriteLine(s);
}
```
## GetGlobalVariables

Returns an array of `Variable` objects for all the global variables. `Variable` has the name, value and a flag indicting if it is a constant or not.

```cs
public class Variable {
	public string Name { get; private set; }
	public object Value { get; private set; }
	public bool IsConstant { get; private set; }
}
```

```cs
script.Run(@"
const PI = 3.14159265359		
var x = 5
var y = 50		
");

var variableList = script.GetGlobalVariables();

foreach (var v in variableList) {
	Debug.WriteLine($"{v.Name} = {v.Value} Is constant = {v.IsConstant}");
}
```


Returned variables objects types can be: int, double, string and ArrayList.

## GetAllFunctions

Returns an array of strings with all the function signatures found in current environment.

> [!NOTE]
> Extensions functions arguments names are returned as arg0..argN. However, the DUE functions will have the parameter name as specified in the source code.

## ResetEnvironment

When a script is executed, it leaves all declared functions and variables available in the environment. Can be accessed though later scripts.
