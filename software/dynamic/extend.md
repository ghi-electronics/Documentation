## Extending DUE

User "functions" stored in flash, can be called externally. This allows a function to be called from ANY outside source or program. 


This will enter recording mode and then records a function
```basic
$
@Count
for x=0 to a
PrintLn(x)
next
return
```

The above "function" can now be called from inside *Immediate* mode as an example. Make sure to switch to immediate mode!

```basic
>a=5
>Count()
```

