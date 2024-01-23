[IN PROGRESS](error.md) 
# Reflection
---
Reflection objects are used for obtaining type information at runtime. This class is in the System.Reflection namespace.

```cs
var i=20;
Type type = i.GetType();

//type = System.Int32
```

Another example below shows how to access a private function from a different class. Let's say we have a class named ReflectionExample with private functions named FunctionA() and FunctionB().

```cs
public class ReflectionExample {
    private uint FunctionA() => 0x1234;

    private uint FunctionB(uint numPlus) => 0x1234 + numPlus;
}
```

Reflection provides a way to access these two functions even though they are declared as private.

```cs
var r = new ReflectionExample();

var type = r.GetType();

var methodA = type.GetMethod("FunctionA", BindingFlags.NonPublic | BindingFlags.Instance);

var valueA = methodA.Invoke(r, null);

var methodB= type.GetMethod("FunctionB", BindingFlags.NonPublic | BindingFlags.Instance);

var valueB = methodB.Invoke(r, new object[] { (uint)1 });

Debug.WriteLine("methodA : " + valueA);
Debug.WriteLine("methodB : " + valueB);
```

The output will be:

```
methodA : 4660
methodB : 4661
```


