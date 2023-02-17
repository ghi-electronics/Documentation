## DUE - Extensions

---

Extensions are user defined functions that reside in the environment until called, they are just like any other functions however these functions are stored in flash until the chip is cleared.


## Defining Extensions/Functions
An extension is created by simply using the "@" symbol in front of the name the extension you'd like to create, flowed by the code inside your extension. Closing with "return". Once the enter key is pressed the extension is flashed to the chip. 

To call the extension you only have to type the name of the extension you created and hit enter. These extensions don't take arguments but use and manipulte the global variables of the environment. 

```cs
>@myfunction()//This creates the function
>add code here
>return//This ends the function. Pressing the enter key adds the functions to memory.
```


> [!TIP]
> Keep in mind that variables in Due are global and any changes inside functions will affect their values outside those functinons.

## Acessing Extensions/Functions

The DUE `ScriptEngine` does all the necessary magic internally. The user only needs to call the function by it's name and hit enter.

```cs
>myfunction
```

## Example

```cs





```