# DUE - Standard Library

---

## General

| Function			                    |Description                                                            |
|:--------------------------------------|:----------------------------------------------------------------------|
|Delay(int ms)                          |Sleeps for specified duration in milliseconds                          |
|Millis()			                    |Returns the number of current time in milliseconds                     |

## Array & Strings

| Function			                    |Description                                                            |
|:--------------------------------------|:----------------------------------------------------------------------|
|Len(object o)                          |Returns the length of an array or string                               |
|Left(object o, int count)              |Returns array or string based on count from left of the object         |
|Right(object o, int count)             |Returns an array or string based on count from right of the object     |
|Mid(object o, int index, int count)    |Returns an array or string based on index and count                    |
|IndexOf(object o, object value)        |Returns the Index of an array or string based on object value passed   |
|Val(string s)                          |Returns string as a Double                                             |
|Append(ArrayList arr, object value)    |Appends a value to an array                                            |
|RemoveAt(ArrayList arr, int value)     |Removes a value from an array at a specific array index                |
|InsertAt(ArrayList arr, object value)  |Inserts a value into an array at a specific array index                |

# Math

| Function			                    |Description                                                            |
|:--------------------------------------|:----------------------------------------------------------------------|
|IsNan(double d)                        |Returns either 1 or 0 based on value passed                            |
|Abs(double d)                          |Returns the absolute value of a number                                 |
|Sqrt(double d)                         |Returns the square root of a number                                    |
|Sin(double rad)                        |Returns the sine of an number                                          |
|Cos(double rad)                        |Returns the cosine of an number                                        |
|Tan(double rad)                        |Returns the tangent of an number                                       |
|Acos(double rad)                       |Returns the arc cosine value of a number                               |
|Asin(double rad)                       |Returns the arc sine value of a number                                 |
|Atan(double rad)                       |Returns the arctangent value of a number                               |
|Atan2(double y, double x)              |Returns the arctangent of x & y                                        |
|Trunc(double d)                        |Returns the integer part of number by removing fractional digits       |
|Round(double d)                        |Returns the value of a number rounded to the nearest integer           |
|Rnd()                                  |Returns the next pseudorandom double                                   |
