# DUE Script

DUE Scripts run internally on any DUE-enabled hardware. This allows the users to run simple quick command, called immediate mode. Additionally, users can extend the DUE language with additional functionality that can be accessed externally or can be executed onto the device. This is called recording mode.

## Operating Modes

*Immediate* mode, commands are executed immediately. In *Record* mode, commands are stored in flash and executed with the **run** command. 

**Immediate Mode**
A user will know they are in this mode when their cursor prompt is the  
**_>_** character. All statements are executed as soon as entered.

```basic 
> print("Hello World")
```

> [!NOTE]
> Immediate Mode is the default mode when device is first connected.

**Record Mode**
To enter into *Record* mode, the user enters the **$** character.
The character prompt will change to the **$** sign until *Record* mode is exited using the **>** character. All statements entered are stored directly in flash but not executed until **run** is entered. 

|Statement              |Description                                                            |
|:----------------------|:----------------------------------------------------------------------|
|$                      |Sets the device in record mode                                      |
|>                      |Exits record mode and returns to direct mode                                    |

The following statements control the program recorded in flash, but can be used in both *Immediate or Record* modes. When used in *Record* mode these special statements execute, but are not added to the program in flash. 

|Statement              |Description                                                            |
|:----------------------|:----------------------------------------------------------------------|
|run                    |Executes the program stored in flash                                     |
|new                    |Erases the program stored in flash                                    |
|list                   |Returns all the code in your program                                     |


```basic 
> $
$ PrintLn (x)
$ PrintLn (y)
$ >
> x=1:y=2
> run
1
2
>list
PrintLn(x)
PrintLn(y)
>new
```
## The DUE Console
The DUE Platform includes an on-line console to help users in accessing and testing out the available DUE features, with no software to install. The console internally handles the necessary modes and the prompt (as in **$** and **>** symbols) are hidden from the user. 

---
## Script Features
DUE Scripts are not case sensitive. Its syntax is very simple and inspired by BASIC coding language. The power of DUE Scripts comes from its simplicity rather than from feature set. This is a perfect language to teach someone coding.

Users that require serious coding should be using DUE Platform combined with one of the many available coding languages. Still, DUE Scripts can be used to extend those languages, as detailed below.

### Comments
The # character is used to identify a comment. Comments are ignored by the program, text added to help developers understand the code.

```basic
# This is a comment
x=10
print (x) # This is also a comment 
```


### Variables
DUE can hold up to 26 variables one for letters a-z. The only data type used in DUE is float. All variables created are global in nature. 

### Arrays

### For-Loop
```basic 
for i=1 to 1000 step 10
PrintLn(i)
next
```

### If-Statement

```basic 
if x=1
PrintLn("one")
else 
PrintLn("not one")
```
### Goto
A goto is useful for repeating tasks indefinitely. 

```basic
$@Loop
$add code here that runs forever
$goto loop 
```
### End & Return
End terminates the program.

```basic
Print("Hello")
End
Print("This will not get printed")
```

Return send the execution back from a called subroutine, see below.

```basic
add code
```

### Subroutine

Developers can use subroutines to implement "soft" like functions in their code. These subroutines similar to functions but do not take variables or return values. 

> [!Tip] The built-in API offers true functions and therefore do take arguments and return values, learn more about the [System functions](../corlib/systemfunctions.md). 

User subroutines are always added in recoding mode and resides in nonvolatile memory. They can then be "run" or called from immediate mode.

A user subroutine is created by using the **@** symbol in front of the name of the function you'd like to create. These names are limited to 6 characters. Once you've created a "function" any preceding commands entered go inside that function. Function are typically end with a return. 

```basic
$@Mine
$add code here
$return
```

The subroutine can then be called by its name with **()**. Note how this can be done externally from any system with access to the DUE interface, like Python.

```basic
Mine()
```


> [!TIP]
> DUE variables are global and any changes inside subroutines will affect variable values outside those subroutines.

Recorded DUE Scripts are executed immediately on power up (the run command is issued internally). If the user doesn't want any of the code to run, they can start the program with the **End** statement.

---

## Combining Commands
Multiple commands can be combined on a single line. This is especially useful when using immediate mode where a single line is required. To use multiple command, a **:** symbol is used.

This is an example of a for loop in a single line

```basic 
for i=1 to 1000 step 10:PrintLn(i):next
```
