## Functions

Functions in DUE are implements in a simple form. They do not take arguments and do not return values. However, the built in library functions do take arguments and return values, learn more about the [System functions](../universal/systemfunctions.md). 

User functions resides in nonvolatile memory using recording mode. They can then be "run" or called from immediate mode.

> [!NOTE]
> While these are called functions, they are actually just labels.

A user function is created by using the **@** symbol in front of the name of the function you'd like to create. These names are limited to 6 characters. Once you've created a "function" any preceding commands entered go inside that function. Function are typically end with a return. 

```basic
$@Mine
$add code here
$return
```

The function can then be called by its name with **()**. Note how this can be done externally from any system with access to DUE interface, like Python.

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
> DUE variables are global and any changes inside functions will affect variable values outside those functions.
