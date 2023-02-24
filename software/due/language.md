# Due - Language

## Immediate & Record Modes

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
$ println (x)
$ println (y)
$ >
> x=1:y=2
> run
1
2
>list
println(x)
println(y)
>new
```
---

## Comments
The # character is used to identify a comment. Comments are ignored by the program, text added to help developers understand the code.

```basic
# This is a comment
x=10
print (x) # This is also a comment 
```
---

## Variables
Due can hold up to 26 variables one for letters a-z. The only data type used in Due is integers. All variables created are global in nature. 

---

## Single Line Commands
Code can be concatenated together in a single line with each command joined by a **:** When coding in **Immediate** mode multi-line statements need to be coded as a single line command. When using **Record mode** multi-line statements can be used. 

```basic 
x=10:print(x):x=15:print(x)
```
---

## Looping & Conditional Statements


|Statement              |Description                                                            |
|:----------------------|:----------------------------------------------------------------------|
|for/to/step/next       |Incremental looping                                                 |
|if/else/end            |Conditional execution of the code                                      |


### For-Loop used in Immediate mode

```basic 
for i=1 to 1000 step 10: println(i):next
```

### If-Else statement used in Record mode

```basic 
$
$new
$if x=1
$println("one")
$else 
$println("not one")
$end
$>
>x = 1
>run
one
>x = 2
>run
not one
```


---

## Functions

Functions in Due are implements in a simple form. They do not take arguments and do not return values. However, the built in library functions do take arguments and return values, learn more about the [library](library.md) functions. 

User functions resides in nonvolatile memory using recording mode. They can then be "run" or called from immediate mode.

> [!NOTE]
> While these are called functions, they are actually just labels.

A user function is created by using the **@** symbol in front of the name of the function you'd like to create. These names are limited to 6 characters. Once you've created a "function" any preceding commands entered go inside that function. Function are typically end with a return. 

```basic
$@Mine
$add code here
$return
```

The function can then be called by its name with **()**. Note how this can be done externally from any system with access to Due interface, like Python.

```basic
>Mine()
```
A goto can also be used to call a function but in this case the function is treated as a label and a **return** should not be expected. 

```basic
$@Loop
$add code here
$goto loop 
```

> [!TIP]
> Due variables are global and any changes inside functions will affect variable values outside those functions.

---
## Extending Due

User "functions" stored in flash, can be called externally. This allows a function to be called from ANY outside source or program. 


This will enter recording mode and then records a function
```basic
$
@Count
for x=0 to a
println(x)
next
return
```

The above "function" can now be called from inside *Immediate* mode as an example. Make sure to switch to immediate mode!

```basic
>a=5
>Count()
```




