# DUE - Language

## Comments
Comments are ignored, text added to help developers read code.

```
# This is a comment
print (x) # This is also a comment 
```

## Variables
DUE can hold up to 26 variables one for letters A-Z. The only data type used in DUE is integers. All variables created are global in nature. 


## Statements

|Statement              |Description                                                            |
|:----------------------|:----------------------------------------------------------------------|
|print()   		        |Prints the argument to the console on the same line				    |
|println()              |Prints the argument to the console and moves to the next line          |
|locate                 |Locates where the print will take place in rows, columns               |
|if/else/endif          |Conditional execution of the code                                      |
|while                  |Executes a block of code until the condition is false                  |
|break                  |Breaks out of the current while loop                                   |
|continue               |Continues the current while loop skipping the rest of the body         |
|return		            |Returns a value from a function				         |
|end                    |Used in BASIC-style to indicate the end of `if` or `while`             |
|var                    |Declares a variable                                        |
|const                  |Declares a constant, a variable that can't be modified!    |
|func                   |Declares a function block                                  |
|AND/OR					|Boolean operators											|

## Functions

### Built-In Functions
A list of the built-in functions can be found in the [library](library.md) section. 



### User Functions

User defined functions are functions that reside in the environment until called, they are just like any other functions however these functions are stored in flash until the chip is cleared.


#### Defining User Functions
An extension is created by simply using the "@" symbol in front of the name the function you'd like to create, flowed by the code inside your function. Closing with "return", and hitting enter. Once the enter key is pressed the function is flashed to the chip. 

To call the function you only have to type the name of the extension you created and hit enter. These extensions don't take arguments.

```basic
>@DoSomething 
>add code here
>return 
```


> [!TIP]
> Keep in mind that variables in Due are global and any changes inside functions will affect their values outside those functinons.

#### Calling User Functions

The DUE `ScriptEngine` does all the necessary magic internally. The user only needs to call the function by it's name and hit enter.

```cs
>@DoSomething
```


A list of the built-in functions can be found in the [functions](functions.md) section. 

> [!TIP]
User defined fuinctions do not take arguments and do not return values. Think of this as a "gosub".


---
