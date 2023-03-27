## Looping & Conditional Statements


|Statement              |Description                                                            |
|:----------------------|:----------------------------------------------------------------------|
|for/to/step/next       |Incremental looping                                                 |
|if/else/end            |Conditional execution of the code                                      |


### For-Loop used in Immediate mode

```basic 
for i=1 to 1000 step 10: println(i):next
```

### If-Else statement used in Record mode

```basic 
$
$new
$if x=1
$println("one")
$else 
$println("not one")
$end
$>
>x = 1
>run
one
>x = 2
>run
not one
```

