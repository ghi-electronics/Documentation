## DUE - This is copy and pasted from GITHUB for Reference. DELETE when section is completed. 
---

## Dynamic
Arguably, DUE is the most user-friendly programming language out there! Consider the following examples and try to guess what programming language each one these use.

Does this look like BASIC?
```
If temp > 60
  Print "Too Hot!"
end
```

Does this look like C and Java?

```
if (temp > 60) {
  print ("Too Hot!");
}
```

Does this look like Python?

```
If (temp > 60):
  Print ("Too Hot!")
```

Here is a surprise for you! All above is allowed and completely supported in DUE! Yes, it is very much Dynamic!

## Universal
Learn coding and how computers work instead of learning the language. DUE only supports ~~two statements, if and while~~. Those statements are universally acceptable in most programming languages.

Variables are simply `var`. All numerical variables are double precision. New learners can now focus on coding vs understanding the different variable types. Also, `var` is common among different languages. String and arrays are also supported in universal form.

The built in professional-grade debugging is part of the language. Yes! You are stepping through code, inspecting variable, using breakpoints and even available call trace. BrainDUE is simple, not weak! Universally, all professional tools include debugging, and now it is also available to students, thanks to BrainDUE.

## Expandable
Start coding in minutes, just like block coding. But, you can keep growing and not hit a brick wall, like the case is with block coding. BrainDUE is not designed to be powerful. Instead, it is designed to teach you things that move forward with you. Once comfortable, you can move to C#, to Python, to Java, or to the language of your choice. The BrainPad, for example, starts users with BrainDUE to start coding in minutes. It then moves users to coding using C# in Visual Studio. This is the same tools professionals use to make th most complex applications.

---

# EBNF
```
<stmt>	        = | <if>
                  | <while>
                  | <vardecl>
                  | <assign>
                  | <funcdecl>
                  | <funccall>
                  | <return>
                  | <print>
                  | <cls>

<vardecl>	= ("var"|"const") <ident> "=" <expr>
<arraydecl>     = ("var"|"const") <ident> "[" <expr> "]" ["=" <expr>]
<assign>	= <ident> "=" <expr>
<if>		= "if" <expr> 
                      (<stmt> {<elseif>} [<else>])
                      | <stmtlist> {<elseif>} [<else>] "end"
<elseif>	= "elseif" <expr> <stmtlist> (<elseif> | <else> | "end")
<else>	        = <stmt> | <stmntlist> "end"
<while>	        = "while" <expr> (<stmt> | <stmtblock>)
<break>         = "break"
<continue>	= "continue"
<funcdecl>	= "func" <ident> "(" <identlist> ")" (<stmt> | <stmtblock>)
<funccall>      = <expr> "(" <exprlist> ")"
<return>    	= "return" <expr>
<locate>        = "locate" <expr>, <expr>
<print>         = "print" <expr>
<cls>           = "cls"

<stmtblock>     = <stmtlist> "end"
<stmtlist>	= <stmt>*
<identlist>     = <ident> {"," <ident>}
<exprlist>	= <expr>  {"," <exprlist>}

<expr>	        = <orexpr>
<orexpr>	= <andexpr> {("or" | "||") <andexpr>}
<andexpr>	= <relexpr> {("and" | "&&") <relexpr>}
<relexpr>	= <addexpr> {<relop> <addexpr>}
<addexpr>	= <multexpr> {<addop> <multexpr>}
<multexpr>	= <factor> {multop <factor>}
<factor>	= <number>
                  | <string>["["<expr>"]"]
                  | <funccall>["["<expr>"]"]
                  | <ident>["["<expr>"]"]
                  | "(" <expr> ")"
                  | "["<exprlist>"]"

<relop>	        = "==" | ("!=" | "<>") | "<" | "<=" | ">" | ">="
<addop>	        = "+" | "-"
<multop>	= "*" | "/" | "%"

<number>	= <digit>* ["." <digit>*]
<ident>	        = "_"|<letter> {<letter> | <digit> | "_"}
<digit>	        = "0"|"1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9"
<letter>	= [a..zA..Z]
```

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

# Built-in Functions
Built-in functions provides a wide range of available options. These functions are interpreter and device independent but we try to keep them unified across all devices. See [this](builtin.md)

---

# Comments
Comments are ignored text added to help developers read code.

```
// This is a comment
print x // This is also a comment 
```

---

# Case Insensitive
By default, BrainDUE is case insensitive, x and X are essentially the same thing. However, as most serious programming languages are case sensitive, BrainDUE can become case sensitive to force users to start getting used to case sensitive environment. You can enable case sensitive by adding `% CASE: SENSETIVE` at the top of the code, or `% CASE: INSENSETIVE`.

# Enforcing Styles
There is great flexibility in using BASIC-like vs C-like vs Python-like coding style. BrainDUE does not care which one is in use. The code can even be a mix of styles! When ready, students can be forced to use a specific style using one of the following directives.

```
% STYLE: BASIC
% STYLE: C-JAVA
% STYLE: PYTHON
% STYLE: ANY 
```

# Include
How do we include/import other files?


