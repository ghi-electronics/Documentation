# Reflection
---
Reflection objects are used for obtaining type information at runtime. This class is in the System.Reflection namespace.

```csharp
var i=20;
Type type = i.GetType();

//type = System.Int32
```

Another example below show how to access a private function from a different class. Let say we have ReflectionExample class with  FunctionA() and  FunctionB() are private;

```csharp
public class ReflectionExample
{
    private uint FunctionA() => 0x1234;

    private uint FunctionB(uint numPlus) => 0x1234 + numPlus;
}
```

And here is the way to aceess two those function when they are declared as private.

```csharp
var r = new ReflectionExample();

var type = r.GetType();

var methodA = type.GetMethod("FunctionA", BindingFlags.NonPublic | BindingFlags.Instance);

var valueA = methodA.Invoke(r, null);

var methodB= type.GetMethod("FunctionB", BindingFlags.NonPublic | BindingFlags.Instance);

var valueB = methodB.Invoke(r, new object[] { (uint)1 });

Debug.WriteLine("methodA : " + valueA);
Debug.WriteLine("methodB : " + valueB);
```

Output will be:

```
methodA : 4660
methodB : 4661
```


