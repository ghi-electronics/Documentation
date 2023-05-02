# DUE Script
---

DUE Scripts run internally on any DUE-enabled [hardware](../../hardware/intro.md). This allows users to run simple quick commands, called *Immediate mode*. Additionally, users can extend the DUE language with additional functionality that can be accessed externally or can be executed onto the device. This is called *Recording mode*.

## Operating Modes

*Immediate mode*, commands are executed immediately. In *Record mode*, commands are stored in flash and executed with the `run` command. 

When using the [DUE Console](../../software/console.md) these modes are automatically handled when you press the `REC` button and the code is recorded to the flash.The `Play` button runs the code on the device. The `Stop` button stops the program running on the device.  If you want to send your DUE script and execute the code immediately use the *Code to execute immediately* text window and hit `arrow` button

**Immediate Mode**

A user will know they are in this mode when their cursor prompt is the  
`>` character. All statements are executed as soon as entered.

```basic 
> print("Hello World")
```

> [!NOTE]
> Immediate Mode is the default mode when device is first connected.

**Record Mode**
To enter into *Record mode*, the user enters the `$` character.
The character prompt will change to the `$` sign until *Record mode* is exited using the `>` character. All statements entered are stored directly in flash but not executed until `run` is entered. 

|Statement              |Description                                                            |
|:----------------------|:----------------------------------------------------------------------|
|$                      |Sets the device in record mode                                      |
|>                      |Exits record mode and returns to direct mode                                    |

The following statements control the program recorded in flash, but can be used in both *Immediate or Record modes*. When used in *Record mode* these special statements execute, but are not added to the program in flash. 

|Statement              |Description                                                            |
|:----------------------|:----------------------------------------------------------------------|
|Run                    |Executes the program stored in flash                                     |
|New                    |Erases the program stored in flash                                    |
|List                   |Returns all the code in your program                                     |

> [!TIP]
> A running program can be terminated by hitting the ESC key, DEL Key, or Backspace Key. 

```basic 
> $
$ PrintLn (x)
$ PrintLn (y)
$ >
> x=1:y=2
> Run
1
2
>List
PrintLn(x)
PrintLn(y)
>new
```

> [!NOTE]
> The [DUE Console](../console.md) hides the prompts and automatically switches to the appropriate mode.


---
## Script Features
DUE Scripts are not case sensitive. Its syntax is very simple and inspired by BASIC coding language. The power of DUE Scripts comes from its simplicity rather than from its feature set. This is a perfect language to teach someone coding.

Users that require serious coding should be using the DUE Platform combined with one of the many available coding languages. Still, DUE Scripts can be used to extend those languages, as detailed below.

### Comments
The `#` character is used to identify a comment. Comments are ignored by the program, text added to help developers understand the code.

```basic
# This is a comment
x=10
Print(x) # This is also a comment 
```

### Variables
DUE Script has a fixed set of 26 variables, one for each letter, assigned to `a` to `z`. The only data type used in DUE is float. All variables created are global in nature. To use a variable, simply use `x=5.5` 

### Arrays
Similarly to variables, arrays are fixed to 26 arrays. They are assigned to letters `a` to `z`. DUE Script differentiates between variable `a` and array `a[]` when square brackets are used. Arrays are size zero by default and can be sized, or resized using `Dim`.

This is an example that uses both, variables and arrays:

```basic
Dim a[10]
For i=0 to 9:a[i]=i*2:Next
For i=0 to 9:PrintLn(a[i]):Next
```

The output will look like:

```
0
2
4
6
8
10
12
14
16
18
```

> [!TIP]
> Use `Dim a[0]` to free up the memory reserved for array `a[]`.


### For-Loop

```basic 
For i=1 to 1000 Step 10
PrintLn(i)
Next
```

### If-Statement
If statements must end with the `End` command. This will only end the If statement and not your program. 

```basic 
If x=1
PrintLn("one")
Else 
PrintLn("not one")
End
```
### Labels

Labels are needed to redirect the program. They are used by `Goto` and when calling a subroutine.

A Label is created by using the `@` symbol in front of the desired label. Labels are limited to 6 characters. 

### Goto

A `Goto` is useful for repeating tasks indefinitely. 

```basic
$@Loop
$ add code here that runs forever
$Goto Loop 
```

### End & Return

End terminates the program except when used to close an `if` statement. 

```basic
Print("Hello")
End
Print("This will not get printed")
```

`Return` send the execution back from a called subroutine, see Subroutines below.

### Subroutine

Developers can use subroutines to implement "soft" like functions in their code. These subroutines are similar to functions but do not take variables or return values. 

> [!Tip] 
> The built-in API offers true functions and therefore do take arguments and return values.

User subroutines are always added in recoding mode and resides in nonvolatile memory. A user subroutine starts with a label and ends with a `Return`. 

```basic
$@Mine
$ add code here
$Return
```

The subroutine can then be called by its name followed by `()`.

```basic
Mine()
```

 Note how a subroutine can be called externally from *Immediate Mode*. This allows for extending DUE Scripts with new commands that can then later be called from *Immediate Mode* and in turn be called from a high level language, like Python, when connected to a Host.

> [!TIP]
> DUE variables are global and any changes inside subroutines will affect variable values outside those subroutines.

Recorded DUE Scripts are executed immediately on power up (the run command is issued internally). If the user doesn't want any of the code to run, they can start the program with the `End` statement.

---

## Combining Commands
Multiple commands can be combined on a single line. This is especially useful when using immediate mode where a single line is required. To use multiple command, a `:` symbol is used.

This is an example of a for loop in a single line

```basic 
For i=1 to 1000 Step 10:PrintLn(i):Next
```
