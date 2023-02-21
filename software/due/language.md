# DUE - Language

## Immediate & Record Modes

##### Immediate Mode
A user will know they are in this mode when their cursor prompt is the  
**_>_** character. All statements are executed as soon as entered.

```basic 
> print("Hello World")
```

> [!NOTE]
Immediate Mode is the default mode when device is first connected.

##### Record Mode
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
DUE can hold up to 26 variables one for letters a-z. The only data type used in DUE is integers. All variables created are global in nature. 

---

## Single Line Commands
Code can be concatenated together in a single line with each command joined by a **:**

```basic 
x=10:print(x):x=15:print(x)
```
---

## Looping & Conditional Statements

When coding in **Immediate** mode multi-line statements need to be coded as a single line command. When using **Record mode** multi-line statements can be used. 

|Statement              |Description                                                            |
|:----------------------|:----------------------------------------------------------------------|
|for/to/step/next       |Incremental looping                                                 |
|if/else/end            |Conditional execution of the code                                      |


### For-Loop used in Immediate mode

```basic 
for i=1 to 1000 step 10: println(i):next
```

### If statement in Record mode

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

### Built-In Functions

A list of the built-in functions can be found in the [library](library.md) section. 

### User Functions

User defined functions are functions that reside in the environment until called, they are just like any other functions however these functions are stored in flash until the chip is cleared.

##### Defining User Functions

An user function is created by simply using the **@** symbol in front of the name of the function you'd like to create. Once you've created a function any preceding commands entered go inside that function. The function can be closed with the **return** command. Functions that are not closed with the **return** command can be called using the **goto** command. 

```basic
>@Mine
>add code here
>return 
```

> [!TIP]
> Keep in mind that variables in DUE are global and any changes inside functions will affect variable values outside those functions.

##### Calling User Functions

The DUE script engine does all the necessary magic internally. The user only needs to call the function by it's name() and hit enter.

```cs
>Mine()
```

A list of the built-in functions can be found in the [library](library.md) section. 

> [!TIP]
User defined functions do not take arguments and do not return values. Think of this as a "gosub".

---

