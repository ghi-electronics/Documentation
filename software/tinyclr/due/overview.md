# DUE Scripting Language
---

## Why DUE?
DUE stands for Dynamic, Universal and Extensible. A user-friendly scripting language with full [debugging](debugging.md) capabilities.

### Dynamic
Arguably, DUE is the most user-friendly programming language out there! It is so Dynamic, it supports multiple coding styles.

BASIC-style
```
If temp > 60
  Print "Too Hot!"
end
```
C-style

```
if (temp > 60) {
  print ("Too Hot!");
}
```

Python-style

```
If (temp > 60):
  Print ("Too Hot!")
```

DUE simply understand any of the most common formats. Users can even mix and match!

Mixing styles between styles within the same block is not supported. 

This code is not allowed and will raise an error:

```
If (temp > 60) {
  Print ("Too Hot!")
end
```

C-style and BASIC-style ignore white-space as how the style work. The Python-style however needs the proper indentation, just like expected by the full python language.

### Universal

DUE uses syntax that is universally used and common among most popular programming languages. Comments, variables, constants are some of the examples.

While not found in most scripting languages, DUE has full built-in [debugging](debugging.md) capability similar to any world-class language.

### Extensible

Users can extend the DUE available functions, right from C#. Learn more at the [Extensions](extensions.md) page.

---

## Getting Started

The [API](api.md) has examples on how to use DUE `ScriptEngine` to write a script using the available [statements](statements.md). DUES comes with several [Standard Library](standardlib.md) functions. Developers have a ways to securely add [Extensions](extensions.md) to give DUE additional functionality. When programs get to be more complex, [debugging](debugging.md) will come in handy.


## Comments
Comments are ignored text added to help developers read code.

```
// This is a comment
print x // This is also a comment 
#this is a python-style comment
```

## Understanding Environment

The `ScriptEngine` takes a script and compiles it and then it will run any top level statements. Any functions and variables are loaded in the environment, and will still be there even when execution has completed.

This script `Foo(x)` will raise an error. There is no `Foo` function and no variable `x` in the script.

Now this script is ran:

```
x=5
func Foo(s)
	print s
end
```

While the earlier script will not do anything, it actually load the environment with a variable and a function.

Running the first script now works fine `Foo(x)`.

Additionally, `Run` only returns when it has completed running the script. If the script has an infinite loop then `Run` will never return. A good option would be to spin a thread for `Run`. The rest fo teh system will continue to run normally and the thread can be terminated to abort `Run` is desired.

---

## Samples

### Recursion

```
func factorial(n)
    if n == 0 return 1 end
    return n * factorial(n - 1)
end

print(factorial(5))
```

### if

```
func ToWords(i)
    if i < 10
        return i + " units"
    elseif i < 100
        return i + " tens"
    elseif i < 1000
        return i + " hundreds"
    else
        return i + " thousands"
    end
end

print(ToWords(3))
print(ToWords(55))
print(ToWords(432))
print(ToWords(2342))
```

### while

```
var i = 1
while i <= 10
    print(i)
    i = i + 1
end
```

### PI

```
const scale = 10000
const arrinit = 2000

func pi_digits(digits)
    var carry = 0
    var arr = []
    var result = []

    // Adjust digits for groups of 4
    digits = (digits * 14) / 4

    // Initialize array
    var i  = 0
    while i < digits + 1
        append(arr, arrinit)
        i = i + 1
    end

    // Calculate digits
    i = digits
    while i > 0
        var sum = 0
        var j = i
        while j > 0
            sum = sum * j + scale * arr[j]
            arr[j] = sum % (j * 2 - 1)
            sum = trunc(sum / (j * 2 - 1))
            j = j - 1
        end
        append(result, carry + trunc(sum / scale))
        carry = sum % scale
        i = i - 14
    end
    return result
end

var result = pi_digits(20)
```
