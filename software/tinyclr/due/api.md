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
A function that is found in a script can be executed from C# directly.

```cs
script.Invoke("OnOff");
```
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

## ResetEnvironment

When a script is executed, it leaves all declared functions and variables available in the environment. Can be accessed though later scripts.
