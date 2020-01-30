# User Interface
---
You can use the `GHIElectronics.TinyCLR.UI` library to create user interfaces for your application. The UI library is inspired by Windows Presentation Foundation on the desktop.

## Application Management
The UI library requires internal management that is handled by the application class. The following code provides a good starting point. Do not forget to add the `GHIElectronics.TinyCLR.UI` NuGet package.

```csharp
using GHIElectronics.TinyCLR.UI;
using GHIElectronics.TinyCLR.Devices.Display;

namespace UserInterfaceExample {
    class Program : Application {
        public Program(DisplayController d) : base(d) {
        }

        static void Main() {
            var display = DisplayController.GetDefault();

            display.SetConfiguration(new ParallelDisplayControllerSettings {
                //Your display configuration
            });

            display.Enable();

            var app = new Program(display);
            app.Run(Program.CreateWindow(display));
        }

        private static Window CreateWindow(DisplayController display) {
            var window = ...
            return window;
        }
    }
}
```

## Windows

While you can have multiple windows in your UI application, it is mandatory to have at least one window. Here is a complete example that shows a window with a gradient brush background. The code is for SC20260D Dev board with the 4.3 inch display.

```csharp
using GHIElectronics.TinyCLR.UI;
using GHIElectronics.TinyCLR.UI.Media;
using GHIElectronics.TinyCLR.Devices.Display;
using GHIElectronics.TinyCLR.Devices.I2c;
using GHIElectronics.TinyCLR.Devices.Gpio;
using GHIElectronics.TinyCLR.Pins;
using System.Drawing;
using GHIElectronics.TinyCLR.Native;

namespace UserInterfaceExample
{
    class Program : Application
    {
        public Program(DisplayController d) : base(d)
        {
        }

        static Program app;

        static void Main()
        {
            GpioPin backlight = GpioController.GetDefault().OpenPin(SC20260.GpioPin.PA15);
            backlight.SetDriveMode(GpioPinDriveMode.Output);
            backlight.Write(GpioPinValue.High);
            var display = DisplayController.GetDefault();

            var controllerSetting = new 
                GHIElectronics.TinyCLR.Devices.Display.ParallelDisplayControllerSettings
            {
                Width = 480,
                Height = 272,
                DataFormat = GHIElectronics.TinyCLR.Devices.Display.DisplayDataFormat.Rgb565,
                PixelClockRate = 10000000,
                PixelPolarity = false,
                DataEnablePolarity = false,
                DataEnableIsFixed = false,
                HorizontalFrontPorch = 2,
                HorizontalBackPorch = 2,
                HorizontalSyncPulseWidth = 41,
                HorizontalSyncPolarity = false,
                VerticalFrontPorch = 2,
                VerticalBackPorch = 2,
                VerticalSyncPulseWidth = 10,
                VerticalSyncPolarity = false,
            };

            display.SetConfiguration(controllerSetting);
            display.Enable();

            var screen = Graphics.FromHdc(display.Hdc);
            var controller = I2cController.GetDefault();
            var ptr = Memory.UnmanagedMemory.Allocate(640 * 480 * 2);
            var data = Memory.UnmanagedMemory.ToBytes(ptr, 640 * 480 * 2);

            app = new Program(display);
            app.Run(Program.CreateWindow(display));
        }

        private static Window CreateWindow(DisplayController display)
        {
            var window = new Window
            {
                Height = (int)display.ActiveConfiguration.Height,
                Width = (int)display.ActiveConfiguration.Width
            };

            window.Background = new LinearGradientBrush
                (Colors.Blue, Colors.Teal, 0, 0, window.Width, window.Height);

            window.Visibility = Visibility.Visible;

            return window;
        }
    }
}
```

This code is for the SC20100 Dev Board with the N18 1.8 inch display.

```csharp
using System;
using System.Drawing;
using GHIElectronics.TinyCLR.Devices.Display;
using GHIElectronics.TinyCLR.Devices.Gpio;
using GHIElectronics.TinyCLR.Devices.Spi;
using GHIElectronics.TinyCLR.Drivers.Sitronix.ST7735;
using GHIElectronics.TinyCLR.Pins;
using GHIElectronics.TinyCLR.UI;
using GHIElectronics.TinyCLR.UI.Media;

namespace SC20100_N18_WPF{
    class Program : Application{
        public Program(DisplayController d) : base(d){
        }

        private static ST7735Controller st7735;
        private const int SCREEN_WIDTH = 160;
        private const int SCREEN_HEIGHT = 128;

        private static void Main(){
            var spi = SpiController.FromName(SC20100.SpiBus.Spi3);
            var gpio = GpioController.GetDefault();

            st7735 = new ST7735Controller(
                spi.GetDevice(ST7735Controller.GetConnectionSettings
                (SpiChipSelectType.Gpio, SC20100.GpioPin.PD10)), //CS pin.
                gpio.OpenPin(SC20100.GpioPin.PC4), //RS pin.
                gpio.OpenPin(SC20100.GpioPin.PE15) //RESET pin.
            );

            var backlight = gpio.OpenPin(SC20100.GpioPin.PE5);
            backlight.SetDriveMode(GpioPinDriveMode.Output);
            backlight.Write(GpioPinValue.High);

            var displayController = DisplayController.FromProvider(st7735);
            st7735.SetDataAccessControl(true, true, false, false); //Rotate the screen.

            displayController.SetConfiguration(new SpiDisplayControllerSettings{
                Width = SCREEN_WIDTH,
                Height = SCREEN_HEIGHT,
                DataFormat = DisplayDataFormat.Rgb565
            });

            displayController.Enable();
            Graphics.OnFlushEvent += Graphics_OnFlushEvent;

            var app = new Program(displayController);
            app.Run(Program.CreateWindow(displayController));      
        }

        private static void Graphics_OnFlushEvent(IntPtr hdc, byte[] data){
            st7735.DrawBuffer(data);
        }

        private static Window CreateWindow(DisplayController display){
            var window = new Window{
                Height = (int)display.ActiveConfiguration.Height,
                Width = (int)display.ActiveConfiguration.Width
            };

            window.Background = new LinearGradientBrush
                Colors.Blue, Colors.Red, 0, 0, window.Width, -20);

            window.Visibility = Visibility.Visible;

            return window;
        }
    }
}
```

## Elements
A window is not very useful without some elements (controls). There are many available standard elements, and you can make your own custom elements as well. All elements descend from the `UIElement` class. Explore the `GHIElectronics.TinyCLR.UI.Controls` namespace to see what's available.

For the sake of simplifying the rest of this tutorial, we've added the `private static UIElement Elements()` method that creates and returns the elements. This is then assigned to the child of our window. You will need to add `window.Child = Elements();` right before returning from `CreateWindow`.


> [!Tip]
> This example needs a [font](font-support.md).

```csharp
private static UIElement Elements() {
    var txt = new TextBox {
        Font = font,
        Text = "Hello World!",
        HorizontalAlignment = HorizontalAlignment.Center,
        VerticalAlignment = VerticalAlignment.Center
    };

    return txt;
}
```

### Label, TextBlock, and TextBox     Text and TextBox
A TextBlock just displays text that cannot be changed at runtime. A TextBlock could be used for a window title, for example. A Label is like a TextBlock, but Label text can be changed at runtime. The Label control can also host controls other than text strings. The TextBox allows for both single line and multiple line text input.

### Panel
A `Window` can carry only a single `Child`, that is a single element. This is not a concern because the single element can be a container, like a `Panel`, which holds multiple elements. You can even have panels within panels with each having its own elements. This example will introduce shapes found in the `GHIElectronics.TinyCLR.UI.Shapes` namespace. It also shows an example of the `TextBox` element. We will also set margins for a better look.

```csharp
private static UIElement Elements() {
    var panel = new Panel();

    var txt1 = new TextBox() {
        HorizontalAlignment = HorizontalAlignment.Left,
        VerticalAlignment = VerticalAlignment.Top,
    };

    txt1.Font = font;
    txt1.SetMargin(20);
    txt1.Text = "Hello World!";

    var txt2 = new Text(font, "TinyCLR is Great!") {
        ForeColor = Colors.White,
        HorizontalAlignment = HorizontalAlignment.Right,
    };

    txt2.SetMargin(20);

    var rect = new Rectangle(200, 10) {
        Fill = new SolidColorBrush(Colors.Green),
        HorizontalAlignment = HorizontalAlignment.Center,
    };

    panel.Children.Add(txt1);
    panel.Children.Add(txt2);
    panel.Children.Add(rect);

    return panel;
}
```

### StackPanel

There are also two types of elements that descend from panels, `Canvas` and `StackPanel`. The Canvas control allows elements to be added anywhere. StackPanels, on the other hand, place elements in order.

We will modify the previous example to use a vertical StackPanel. The elements will stack and be arranged to the right and the left. Note that setting vertical alignment will be ignored as the vertical StackPanel overrides how elements are stacked.

```csharp
private static UIElement Elements() {
    var panel = new StackPanel(Orientation.Vertical);

    var txt1 = new TextBox() {
        HorizontalAlignment = HorizontalAlignment.Left,
        VerticalAlignment = VerticalAlignment.Top,
    };

    txt1.Font = font;
    txt1.SetMargin(20);
    txt1.Text = "Hello World!";

    var txt2 = new Text(font, "TinyCLR is Great!") {
        ForeColor = Colors.White,
        HorizontalAlignment = HorizontalAlignment.Right,
    };

    txt2.SetMargin(20);

    var rect = new Rectangle(200, 10) {
        Fill = new SolidColorBrush(Colors.Green),
        HorizontalAlignment = HorizontalAlignment.Center,
    };

    panel.Children.Add(txt1);
    panel.Children.Add(txt2);
    panel.Children.Add(rect);

    return panel;
}
```

### Canvas

The Canvas element provides pixel level control over the placement of its child controls. The `Width` and `Height` properties of Canvas are requested dimensions, but the actual size depends on the size of the parent element. The `ActualWidth` and `ActualHeight` properties can be used to determine the actual size of the Canvas. Controls within a Canvas are positioned relative to the four edges of the Canvas.

```csharp
private static UIElement Elements() {
    var canvas = new Canvas();

    var txt = new Text(font, "TinyCLR is Great!") {
        ForeColor = Colors.White,
    };

    var rect = new Rectangle(150, 30) {
        Fill = new SolidColorBrush(Colors.Green),
        HorizontalAlignment = HorizontalAlignment.Center,
    };

    Canvas.SetLeft(rect, 20);
    Canvas.SetBottom(rect, 20);

    canvas.Children.Add(rect);

    Canvas.SetLeft(txt, 30);
    Canvas.SetBottom(txt, 25);

    canvas.Children.Add(txt);

    return canvas;
}
```

### Border

This element defines a border inside another element. The position of child elements is constrained to the area inside the border. In this example the border thickness is set to 10, but if the children do not fill the area within the border, the border's thickness will automatically increase. Uncomment the two alignment lines to see an undesired effect of how borders work.

```csharp
private static UIElement Elements() {
    var border = new Border();
    border.SetBorderThickness(10);
    border.BorderBrush = new SolidColorBrush(Colors.Red)

    var txt = new TextBox() {
        //HorizontalAlignment = HorizontalAlignment.Center,
        //VerticalAlignment= VerticalAlignment.Center,
    };

    txt.Font = font;
    txt.Text = "TinyCLR is Great!";
    border.Child = txt;

    return border;
}
```

The fix is to add a container and then the container will have a border. In this example, the parent of the border is the canvas instead of the window.

```csharp
private static UIElement Elements() {
    var canvas = new Canvas();
    var border = new Border();
    border.SetBorderThickness(10);
    border.BorderBrush = new SolidColorBrush(Colors.Red);
    Canvas.SetLeft(border, 20);
    Canvas.SetTop(border, 20);

    var txt = new TextBox();
    txt.Font = font;
    txt.Text = "TinyCLR is Great!";

    border.Child = txt;
    canvas.Children.Add(border);

    return canvas;
}
```

### Button

Buttons are simple controls that accept user input in the form of a click, which in embedded devices is usually a finger tap on a touch screen. The button needs a child, typically text, which describes the button's function. Buttons have a `Click` event to respond to user input.

```csharp
private static UIElement Elements() {
    var txt = new Text(font, "Push me!") {
        VerticalAlignment = VerticalAlignment.Center,
        HorizontalAlignment = HorizontalAlignment.Center,
    };

    var button = new Button() {
        Child = txt,
        Width = 100,
        Height = 40,
    };

    button.Click += Button_Click;
    return button;
}

private static void Button_Click(object sender, RoutedEventArgs e) {
    // Add button click event code here...
}
```

### TextFlow

TextFlow is a more powerful version of TextBlock that supports more advanced text formatting, and works well with large blocks of text.

```csharp
private static UIElement Elements() {
    var textFlow = new TextFlow();
    textFlow.TextRuns.Add("Hello ", font, Colors.Red);
    textFlow.TextRuns.Add("World!", font, Colors.Purple);
    textFlow.TextRuns.Add(TextRun.EndOfLine);
    textFlow.TextRuns.Add("TinyCLR is Great!", font, Colors.Yellow);

    return textFlow;
}
```

### ListBox

This element provides a list of options for users to select from.

```csharp
private static UIElement Elements() {
    var listBox = new ListBox();
    listBox.Items.Add(new Text(font, "Item 1"));
    listBox.Items.Add(new Text(font, "Item 2"));
    listBox.Items.Add(new Text(font, "Item 3"));
    listBox.Items.Add(new Text(font, "Item 4"));

    return listBox;
}
```

It is also possible to add a separator between items, simply by using a rectangle. This item will be set to be not selectable.

```csharp
private static UIElement Elements() {
    var rect = new Rectangle() {
        Height = 1,
        Width=30,
        Stroke = new Pen(Colors.Black),
    };

    var separator = new ListBoxItem() {
        Child = rect,
        IsSelectable = false,
    };

    separator.SetMargin(2);

    var listBox = new ListBox();

    listBox.Items.Add(new Text(font, "Item 1"));
    listBox.Items.Add(new Text(font, "Item 2"));
    listBox.Items.Add(separator);
    listBox.Items.Add(new Text(font, "Item 3"));
    listBox.Items.Add(new Text(font, "Item 4"));

    return listBox;
}
```

### ScrollViewer

The scroll viewer allows for viewing content that is larger than the viewing area. The user input can then be used to shift the content within the viewing area.


### The Dispatcher

The User Interface libraries rely on a dispatcher internally to handle system events and updates the invalidated elements. Any changes to any of the elements needs to happen from within the dispatcher. In this example, we will show the time on the screen. The time will be in a text box that is updated every second using a `Timer`. Since timers run in their own thread, a dispatcher invoke is needed.

```csharp
static void Counter(object o) {
    Application.Current.Dispatcher.Invoke(TimeSpan.FromMilliseconds(1), _ => {
        Text txt = (Text)o;
        txt.TextContent = DateTime.Now.ToString();
        txt.Invalidate();
        return null;
    }, null);
}

private static UIElement Elements() {
    var txt = new Text(font, "Hello World!") {
        ForeColor = Colors.White,
        VerticalAlignment = VerticalAlignment.Center,
        HorizontalAlignment = HorizontalAlignment.Center,
    };

    Timer timer = new Timer(Counter, txt, 2000, 1000);
    return txt;
}
```

You can also use the dispatcher timer directly

```csharp
private static UIElement Elements() {
    var txt = new Text(font, "Hello World!") {
        ForeColor = Colors.White,
        VerticalAlignment = VerticalAlignment.Center,
        HorizontalAlignment = HorizontalAlignment.Center,
    };

    var timer = new DispatcherTimer();
    timer.Tag = txt;
    timer.Tick += Counter;
    timer.Interval = new TimeSpan(0, 0, 1);
    timer.Start();
    return txt;
}

private static void Counter(object sender, EventArgs e) {
    var txt = (Text)((DispatcherTimer)sender).Tag;
    txt.TextContent = DateTime.Now.ToString();
    txt.Invalidate();
}
```

### User Input
A user can feed in input to the graphical interface through touch or button input.

```csharp
app.InputProvider.RaiseTouch(x, y, touchState, DateTime.UtcNow);
app.InputProvider.RaiseButton(btn, btnState, DateTime.UtcNow);
```

The [touch](touch-screen.md) tutorial has further details.
