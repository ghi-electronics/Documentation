# DUE - Debugging

---

No modern system should exist if it does not have debugging, and DUE has just what is needed.

## Stepping

Debugging is simply enabled through a flag on the `Run` method. `script.Run()`

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
	
	OnOff()

", GHIElectronics.TinyCLR.DUE.Debugging.DebugLevel.Line);// enable debugging
```

Once debugging option is enabled, an event `script.DebugEvent += DebugStep_DebugEvent` is raised for every program step. In teh event handler, the user has the option to continue, step into or step over.

```cs
private static DebugAction Script_DebugEvent(IDebuggee debuggee) {
	Debug.WriteLine($"Executing: {debuggee.SrcLine} : {debuggee.SrcCol}..{debuggee.SrcCol + debuggee.SrcLength}");
	Debug.WriteLine("Locals");
	foreach (var v in debuggee.GetLocals())
	{
		Debug.WriteLine($"{v.Name} = {v.Value}");
	}
	Debug.WriteLine("");


	return DebugAction.StepInto; // Step into next statement
}
```

## Breakpoints

A breakpoint is set through `script.ToggleBreakpoint(lineNumber)`. Once execution hits a breakpoint, the debug event is raised with `e.Breakpoint` set to true.

```cs
private static DebugAction Script_DebugEvent(IDebuggee debuggee) {
	if (e.Breakpoint) {
		// we hit a breakpoint
		}
	} else {
		// This will get hit once on start up, because when we start debugging the debugger breaks on the first
		// executable statement, without requiring an explicit breakpoint
	}
	return DebugAction.Continue; // Run until next breakpoint
}
```