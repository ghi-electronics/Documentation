# User Interface
You can use the `GHIElectronics.TinyCLR.UI` library to create user interfaces for your application. It is inspired by WPF on the desktop.

## Application Management
There is no special requirements when simply [drawing](drawing.md). However, the user interface has internal management requirements, that is handled by the application class. Your starting point will look like the following code. Do not forget to add the `GHIElectronics.TinyCLR.UI` NuGet package.

```cs
using GHIElectronics.TinyCLR.UI;
using GHIElectronics.TinyCLR.Devices.Display;

namespace UserInterfaceExample {
    class Program : Application {
        public Program(DisplayController d) : base(d) {
        }
        static void Main() {
            var disp = DisplayController.GetDefault();

            disp.SetConfiguration(new ParallelDisplayControllerSettings {
                //Your display configuration
            });

            disp.Enable();

            var app = new Program(disp);
            app.Run(Program.CreateWindow(disp));
        }
        private static Window CreateWindow(DisplayController disp) {
            var window = ...
            return window;
        }
    }
}
```

## Windows

You can have multiple windows in your application but you will at least need one. Here is a complete example that shows a window with a gradient brush background. The code is for UCM Dev board with 4.3 display and UC5550 UCM.

```cs
using GHIElectronics.TinyCLR.UI;
using GHIElectronics.TinyCLR.Devices.Display;
using GHIElectronics.TinyCLR.Devices.Gpio;
using GHIElectronics.TinyCLR.Pins;
using GHIElectronics.TinyCLR.UI.Media;

namespace UserInterfaceExample {
    class Program : Application {
        public Program(DisplayController d) : base(d) {
        }
        static void Main() {
            var disp = DisplayController.GetDefault();

            disp.SetConfiguration(new ParallelDisplayControllerSettings {
                //Your display configuration
                Width = 480,
                Height = 272,
                DataFormat = DisplayDataFormat.Rgb565,
                HorizontalBackPorch = 46,
                HorizontalFrontPorch = 16,
                HorizontalSyncPolarity = false,
                HorizontalSyncPulseWidth = 1,
                DataEnableIsFixed = false,
                DataEnablePolarity = false,
                PixelClockRate = 16_000_000,
                PixelPolarity = false,
                VerticalBackPorch = 23,
                VerticalFrontPorch = 7,
                VerticalSyncPolarity = false,
                VerticalSyncPulseWidth = 1
            });

            disp.Enable();

            UCMStandard.SetModel(UCMModel.UC5550);
            var gpioController = GpioController.GetDefault();
            var backlight = gpioController.OpenPin(UCMStandard.GpioPin.A);
            backlight.SetDriveMode(GpioPinDriveMode.Output);
            backlight.Write(GpioPinValue.High);

            var app = new Program(disp);
            app.Run(Program.CreateWindow(disp));
        }
        private static Window CreateWindow(DisplayController disp) {
            var window = new Window {
                Height = (int)disp.ActiveConfiguration.Height,
                Width = (int)disp.ActiveConfiguration.Width
            };
            window.Background = new LinearGradientBrush(Colors.Blue, Colors.Teal, 0, 0,
               window.Width, window.Height);
            window.Visibility = Visibility.Visible;
            return window;
        }
    }
}
```
## Elements
A window is not very useful without some elements (controls). There are several built in elements and you can also custom make your own. All elements descend from the `UIElement` class. Explore the `GHIElectronics.TinyCLR.UI.Controls` namespace for available options.

For the sake of simplifying the rest of this tutorial, we will add `private static UIElement Elements()` method that creates and returns the elements. This is then assigned to the `Child` of our `Window`. You will need to add `window.Child = Elements();` right before returning from `CreateWindow`.


> [!Tip]
> This example needs a [font](font.md).

```cs
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
## Text and TextBox

These 2 elements are very basic and very useful. They are used in many of the examples throught this tutorial.

## Panel
A `Window` can carry only a single `Child`, that is a single element. This is not a concern because the single element can be a container, like a `Panel`, which holds multiple elements. You can even have panels within panels and each has its own elements. This example will introduce shapes found in the `GHIElectronics.TinyCLR.UI.Shapes` namespace. It also shows an example of the `TextBox` element. We will also set margins for a better look.

```cs
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

## StackPanel

There are also two types of elements that descend from panels, `Canvas` and `StackPanel`. The canvas allows elements to be added anywhere. Stack panels, on the other had, places elements in order.

We will modify the previous example to use vertical stack. The elements will stack and be arrange to the right and the left. Note that setting vertical alignment will be ignored as the vertical stack does overrides how elements are stacked vertically.

```cs
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

## Canvas

The canvas provides pixel level control over where element go on the screen. However, like all other components, canvas is aware of the window size and things are aligned from it sides.

```cs
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
## Border

This element allows a border to be added. The border starts from the parent element and then the child is constrained to the border's thickness. This example will demonstrate how. The border is this example i set to 10, meaning the window (the parent) will grow inwards the border's thickness and then the child element(s) will fill in. If the children do not fill in the entire space then the border will fill in more than the assigned thickness. Uncomment the 2 alignment lines to see undesired effect of how borders work.

```cs
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

The fix around this is to add a container and then the container will have a border. In this example, the parent of the border is the canvas instead of the window.

```cs
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
## Button

Buttons are a good place for user input. The button needs a child, typically text. Buttons also have `Click` event to handle the user input.

```cs
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
    // Add your code here...
}
```

## TextFlow

This element helps in adding text on multi-line and with different colors and sizes.

```cs
private static UIElement Elements() {

    var textFlow = new TextFlow();
    textFlow.TextRuns.Add("Hello ", font, Colors.Red);
    textFlow.TextRuns.Add("World!", font, Colors.Purple);
    textFlow.TextRuns.Add(TextRun.EndOfLine);
    textFlow.TextRuns.Add("TinyCLR is Great!", font, Colors.Yellow);

    return textFlow;
}
```
## ListBox

This element provides a list of options for users to select from.

```cs
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

```cs
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

## ScrollViewer

The scroll viewer allows for viewing content that are larger than the viewing area. The user input can then be used to shift the content within the viewing area.


## The Dispatcher

The User Interface libraries rely on a dispatcher internally to handle system events and updates the invalidated elements. Any changes to any of the elements needs to happen from within the dispatcher. In this example, we will show time on the screen. The time will be in a text box that is updated every second using a `Timer`. Since timers run in their own thread, a dispatcher invoke is needed.

```cs
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

```cs
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

## User Input
A user can feed in input to the graphical interface through touch or button input.

```cs
app.InputProvider.RaiseTouch(x, y, touchState, DateTime.UtcNow);
app.InputProvider.RaiseButton(btn, btnState, DateTime.UtcNow);
```

The [touch](touch.md) tutorial has further details.
