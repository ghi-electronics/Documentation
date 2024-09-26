# Script

---

These methods allow developers to control DUE Scripts right from within .NET

| Method                       | Description                                        |
| :---                         |:---                                                |
| Script.Execute()	   	       | Executes the single line of code immediately       |
| Script.IsRunning()	   	   | Checks if DUE Script is running                    |
| Script.Load()	   	           | Loads the line into internal buffer                |
| Script.New()	   	           | Clears the program stored in flash                 |
| Script.Read()	   	           | Read the program stored in flash and return as string |
| Script.Record()	   	       | Sends the internal buffer to the device, overwriting any previous programs |
| Script.Run()	   	           | Runs the program stored in flash                   |

This example will load a simple program line by line and then record it.

```csharp
due.Script.Load("c = 10");
due.Script.Load("@Blink");
due.Script.Load("Led(100,100,c)");
due.Script.Record();
```

This is an example to execute a single line(immediate mode). This does not modify the application stored in flash. 

```csharp
due.Script.Execute("LED(200,200,10)");
```

You can also access a previously recorder program using goto (to label) or by calling a function that has a return. This example calls the recorded program above.

```csharp
due.Script.Execute("c=5:goto Blink");
```

 