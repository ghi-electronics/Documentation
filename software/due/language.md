# DUE - Language

## Comments
Comments are ignored, text added to help developers read code.

```
# This is a comment
print x # This is also a comment 
```

## Variables
DUE can hold up to 26 variables one for letters A-Z. The only data type used in DUE is integers. All variables created are global in nature. 


## Statements

|Statement              |Description                                                            |
|:----------------------|:----------------------------------------------------------------------|
|print/cls		        |Special Output Console Statements								|
|print                  |Prints the following expression to the console and moves to the next line |
|locate                 |Locates where the print will take place in rows, columns               |
|if/elseif/else         |Conditional execution of the code                                      |
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



## Console Statements

These statements are a quick and dirty way to output information. By default, `cls` does not do anything but `print` will simply call `Debug.WriteLine` internally.

The behavior can be change, to forward the output to a serial port or a display for example. See [API](api.md) page from more details.

> [!TIP]
> print will format double `ToString("N4")`

## Execution Statements
`while`, `if`/`elseif`/`else`, `continue`, `break` and 'return' work just like most globally-acceptable programming languages.

## The `end` statement

DUE supports multiple code block types. When basic-style is selected, the end statement marks the end of a block.

```
if x > 10
  print x
end
```

In the case other style is used, like C-style, using end is not needed and not allowed.
```
if (x>10) {
  print(x);
}
```

This is not allowed
```
if (x>10){
  print(x);
end
```


### Numerical
Variables are always integers and must always have a starting value `x = 10` is good but `var x` is not allowed.



## const

`const` is a special type of variable that can't be changed.

```
const x = 5
const s = "Hello"
// these are not allowed
x = 10
s = "Bye!"
```
 


## Boolean Operators

Some programming languages use && and some use AND to check of 2 statements are true, similarly they have || and OR.

```
if speed > 100 AND temp < 32
	print "Slow down!"
end
if (speed > 200 && temp < -40) {
	print("Goodbye!");
}
```
## Bitwise Operators

Not currently supported.