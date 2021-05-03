## DUE - Statements
---

# Language Statements

|Statement              |Description                                                            |
|:----------------------|:----------------------------------------------------------------------|
|cls                    |Clears the console and moves the cursor to the top left corner         |
|print                  |Prints the following expression to the console and moves to the next line |
|locate                 |Locates where the print will take place in rows, columns               |
|if/elseif/else         |Conditional execution of the code                                      |
|while                  |Executes a block of code until the condition is false                  |
|break                  |Breaks out of the current while loop                                   |
|continue               |Continues the current while loop skipping the rest of the body         |
|end                    |Used in BASIC-style to indicate the end of `if` or `while`             |
|var                    |Declares a variable                                        |
|const                  |Declares a constant, a variable that can't be modified!    |
|func                   |Declares a function block                                  |
## Output Statements
cls, print and locate statements effect the output window. They differ from the built-in functions by not requiring parentheses. Also, unlike the built-in drawing functions, they immediately modify the screen, not requiring a screen refresh command.

The example code below will print a counter on a specific spot on the screen.

```
cls
var i=0
while 1
  locate 5, 3 // this is row,column character location and not x,y pixels
  print i
  i=i+1
end
```

## Execution Statement
while, if, continue and break work just like most globally acceptable programming languages.

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
## var
### Numerical
Variables are always double-type and must always have a starting value `var x = 10` is good but `var x` is not allowed. When converting to strings, fractions are fixed at 2 decimal places but if fraction is 0 then fractions are eliminated, meaning `54.342234` will be always treated as `54.34` but 48.00 will be treated as `48`. Note that `33.2` will also be converted to 2 decimal places `33.20`.

### Strings
Strings are supported `string s = "TinyCLR"` Assigning a number to a string will automatically convert to strings
```
var s = "BrainDUE "
var x = 2.2
s = s+x
// s is now "BrainDUE 2.20"
```

### Arrays
Arrays are supported.

```
var numbers = [1, 2, 3, 4]
var names = ["Gus", "Dat", "Greg"]
```

Arrays can have mixed data types

```
var namesAndAges = ["Gus", 32, "Dat", 20, "Greg", 30]
```

Arrays can even contain other arrays

```
var setsOfNumbers = [[1,3,5], [2,4,6]]
```

Array elements can be accessed. Remember array indexes start at 0

```
var numbers = [1, 2, 3, 4]
print(numbers[2]) // Will access the 3rd element in the array
```
## const
const is a special type of variable that can't be changed

```
const x = 5
// this is not allowed
x = 10
```

## Functions (func)

Functions are added using `func` statement.

```
func printsomething()
  print("Hello There!")
end
printsomething()
```

Of course, we can use curly brackets instead, and add semicolons!

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

---