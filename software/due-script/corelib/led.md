# LED

This function is used to take control of the on-board LED. It is non-blocking so it can be used as a status indicator for your programs while they run. 


## [Python](#tab/py)
- **Led.Set(highPeriod, lowPeriod, count)**<br>
**highPeriod:** The duration in milliseconds the LED is on.<br>
**lowPeriod:** The duration in milliseconds the LED is off.<br>
**count:** The number of times the LED will blink. <br>

```py
duelink.Led.Set(1000, 1000, 10)
```

## [JavaScript](#tab/js)
- **Led.Set(highPeriod, lowPeriod, count)**<br>
**highPeriod:** The duration in milliseconds the LED is on.<br>
**lowPeriod:** The duration in milliseconds the LED is off.<br>
**count:** The number of times the LED will blink. <br>

```js
await duelink.Led.Set(1000, 1000, 10)
```

## [.NET](#tab/net)
- **Led.Set(int highPeriod, int lowPeriod, int count)**<br>
**highPeriod:** The duration in milliseconds the LED is on.<br>
**lowPeriod:** The duration in milliseconds the LED is off.<br>
**count:** The number of times the LED will blink. <br>

```cs
duelink.Led.Set(1000, 1000, 10);
```

## [DUE Script](#tab/due)
- **LED(high, low, count)**<br>
  **high:** The duration in milliseconds the LED is on.<br>
**low:** The duration in milliseconds the LED is off.<br>
**count:** The number of times the LED will blink. <br>

```basic
LED(1000,1000,10)
```
___

> [!TIP] 
> Setting count to **-1** will blink the LED forever, and **0** will turn off the LED.


Hardware's on-board LED can also be accessed directly using the [`Digital.Write`](../corelib/digital.md) function.

## [Python](#tab/py)

```py
Digital.Write('L',1)
```

## [JavaScript](#tab/js)


```js
Digital.Write('L',1)
```

## [.NET](#tab/net)


```cs
Digital.Write('L',1)
```

## [DUE Script](#tab/due)


```basic
DWrite('L',1)
```