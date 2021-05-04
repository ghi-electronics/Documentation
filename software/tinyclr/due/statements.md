# DUE - Statements

---

## Language Statements

|Statement              |Description                                                            |
|:----------------------|:----------------------------------------------------------------------|
|print/cls/locate       |Special Output Console Statements								|
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

## Console Statements

These statements are a quick and dirty way to output information. By default, `locate` and `cls` do not do anything but `print` will simply call `Debug.WriteLine` internally.

The behavior can be change, to forward the output to a serial port or a display for example. See [API](api.md) page from more details.

> [!TIP]
> print will format double `ToString("N4")`

## Execution Statements
`while`, `if`/`elseif`/`else`, `continue`, `break` and 'return' work just like most globally-acceptable programming languages.

## The `end` statement

BrainDUE supports multiple code block types. When basic-style is selected, the end statement marks the end of a block.

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

## var

`var` is how variables are created. `var` will automatically select the correct type and will even change the type on the next assignment, like change it from numerical to string.

### Numerical
Variables are always double-type and must always have a starting value `var x = 10` is good but `var x` is not allowed.

### Strings

`var s = "Hello DUE"` creates a variable of a string type. 

Just like modern languages, strings can be combined. `var s = "Hello " + "DUE"`. 

With strings, numerical variable or constants are automatically converted to strings internally. `print "x= " + x`.

Both single quote and double-quote are supported and work the same. `print 'hi'`.

### Arrays

Arrays, and arrays of arrays, are supported. It is important to note that arrays hold an array of `var` and each `var` in itself can be any kind, even another array.

```
var numbers = [1, 2, 3, 4]
var names = ["DUE", "is", "amazing"]
var mix = ["Hi", 55, 96.34]
```

Arrays can even contain other arrays

```
var setsOfNumbers = [[1,3,5], [2,4,6]]
```

Array elements are indexed starting zero.

```
var numbers = [1, 2, 3, 4]
print numbers[2] // Will access the 3rd element in the array
```

Creating an empty array is supported `var arr = []`.

> [!TIP]
> Creating an empty array of specific length is supported through the `Array` functions from [Standard Library](standardlib.md).

## const

`const` is a special type of variable that can't be changed.

```
const x = 5
const s = "Hello"
// these are not allowed
x = 10
s = "Bye!"
```

Arrays are slightly different as in the values can be changed but not the array itself.

```
const a = [1, 2, 5]
a[2] = 3
// this is not allowed
a = 5
```


## Functions (func)

Functions are added using `func` statement.

```
func printsomething()
  print("Hello There!")
end
printsomething()
```

Of course, curly brackets can be used instead, and even semicolons!

```
func printsomething() {
  print "Hello There!";
}
printsomething()
```
Passing arguments to functions is supported.

```
func greet(name)
  print "Hello " + name
end

greet("Gus")
// This will show Hello Gus on the output window
```

Functions can also return values

```
func add(x, y) 
  return x + y
end

var answer = add(32, 10)
```
Functions can also be added from C# through [Extensions](extensions.md).

---

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