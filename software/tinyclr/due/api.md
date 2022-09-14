# DUE - API
---

The DUE API is designed to give full access of the `ScriptEngine` in a simple user-friendly way.

> [!TIP]
> We will assume `GpioExtension` sample from [Extensions](extensions.md) is being used.

## Run

This method will execute a script.

```cs
var script = new ScriptEngine(typeof(GpioExtension));

script.Run(@"
	var led = DigitalPin(4*16+11)//PE11
	func OnOff()
		writePin(led, On)
		Delay(100)
		writePin(led, Off)
		Delay(100)
	end
");
```

`Run` only returns when it has completed running the script. If the script has an infinite loop then `Run` will never return. A good option would be to spin a thread for `Run`. The rest of the system will continue to run normally and the thread can be terminated to abort `Run` is desired.

## SetConsole

Redirects the Console Statements. For example, the output can be forwarded to a display.

```cs
class MyConsole : IConsole {
    private int row = 0;
    private const int charHeight = 9;

    // I2C Display
    static I2cController i2c = I2cController.FromName(SC13048.I2cBus.I2c1);
    static SSD1306Controller ssd1306 = new SSD1306Controller(i2c.GetDevice(new I2cConnectionSettings(0x3d)));

    // Basic Graphics
    static BasicGraphics basicGfx = new BasicGraphics(128, 64, ColorFormat.OneBpp);
    public void Cls() { 
        basicGfx.Clear();
        this.row = 0;
    }
    public void Locate(int row, int col) { }// deprecated!
    public void Print(string s) {
        if (row >= (basicGfx.Height / charHeight)) {
            Cls();
            row = 0;
        }
        basicGfx.DrawString(s, BasicGraphics.ColorFromRgb(0xff, 0xff, 0xff), 0, row * charHeight);
        ssd1306.DrawBufferNative(basicGfx.Buffer);
        row++;
    }
}
```
The `IConsole` interface is then passed to the engine.

```cs
var script = new ScriptEngine();
var console = new MyConsole();
script.SetConsole(console);
script.Run(@"
    cls
    print('Hello World!')   
    cls // will clear the previous prints
    print('Hello World!')   
    print   
    print 'TinyCLR'
    print ""with DUE""   
    print 'is the best!'
");
```
