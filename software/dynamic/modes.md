## Immediate & Record Modes

*Immediate* mode, commands are executed immediately. In *Record* mode, commands are stored in flash and executed with the **run** command. 

**Immediate Mode**
A user will know they are in this mode when their cursor prompt is the  
**_>_** character. All statements are executed as soon as entered.

```basic 
> print("Hello World")
```

> [!NOTE]
> Immediate Mode is the default mode when device is first connected.

**Record Mode**
To enter into *Record* mode, the user enters the **$** character.
The character prompt will change to the **$** sign until *Record* mode is exited using the **>** character. All statements entered are stored directly in flash but not executed until **run** is entered. 

|Statement              |Description                                                            |
|:----------------------|:----------------------------------------------------------------------|
|$                      |Sets the device in record mode                                      |
|>                      |Exits record mode and returns to direct mode                                    |

The following statements control the program recorded in flash, but can be used in both *Immediate or Record* modes. When used in *Record* mode these special statements execute, but are not added to the program in flash. 

|Statement              |Description                                                            |
|:----------------------|:----------------------------------------------------------------------|
|run                    |Executes the program stored in flash                                     |
|new                    |Erases the program stored in flash                                    |
|list                   |Returns all the code in your program                                     |


```basic 
> $
$ println (x)
$ println (y)
$ >
> x=1:y=2
> run
1
2
>list
println(x)
println(y)
>new
```