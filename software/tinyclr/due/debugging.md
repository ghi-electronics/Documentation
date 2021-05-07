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
", true);// enable debugging
```

Once debugging option is enabled, an event `script.DebugEvent += DebugStep_DebugEvent` is raised for every program step. In teh event handler, the user has the option to continue, step into or step over.

```cs
private static void DebugStep_DebugEvent(ScriptEngine sender, DebugEventArgs e) {
	Debug.WriteLine($"Executing: {e.SrcLine} : {e.SrcCol}..{e.SrcCol + e.SrcLength}");
	Debug.WriteLine("Locals");
	foreach(var v in e.Locals) {
		Debug.WriteLine($"{v.Name} = {v.Value}");
	}
	Debug.WriteLine("");
	e.Action = DebugAction.StepInto; // Step into next statement
}
```

## Breakpoints

A breakpoint is set through `script.SetBreakpoint(lineNumber)`. Once execution hits a breakpoint, the debug event is raised with `e.Breakpoint` set to true.

```cs
private static void DebugBreakpoint_DebugEvent(ScriptEngine sender, DebugEventArgs e) {
if (e.Breakpoint) {
    // we hit a breakpoint
    }
} else {
    // This will get hit once on start up, because when we start debugging the debugger breaks on the first
    // executable statement, without requiring an explicit breakpoint
}
e.Action = DebugAction.Continue; // Run until next breakpoint
}
```
> [!TIP]
> `e.Action` will default to `DebugAction.Continue` if not set.

Clearing breakpoints is done through `ScriptEngine.ClearBreakpoint`. The entire list of breakpoint can be fetched using `ScriptEngine.GetBreakpoints`, which return an array of line numbers.

## Pausing 
When a program is `Run` with Continue option and there is no breakpoints, the current thread will continue to be active. If pause is needed, the `Run` must be called in a secondary thread, allowing the first thread to call `script.Pause()`. This only works when `Run` is fired with debug flag is set to true.
