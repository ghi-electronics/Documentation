# User Interface

---

You can use the `GHIElectronics.Endpoint.UI` library to create user interfaces for your application. The UI library is inspired by Windows Presentation Foundation on the desktop.

## Application Management
The UI library requires internal management that is handled by the application class. The following code provides a good starting point.

> [!Tip]
> Needed NuGets: GHIElectronics.Endpoint.Drawing, GHIElectronics.Endpoint.UI

```cs

using GHIElectronics.Endpoint.UI;

namespace UserInterfaceExample {
	class Program : Application {
		public Program(int width, int height) : base(width, height) {
		
		}

		static void Main(string[] args) {
			// Initialize Display
			InitDisplay();

			// Initialize Touch
			InitializeTouch();

			var app = new Program(display);
			app.Run(Program.CreateWindow(display));
		}

		private static Window CreateWindow(int width, int height)
		{
			var window = new Window
			{
				Height = height,
				Width = width
			};
			window.Background = new LinearGradientBrush(Colors.Blue, Colors.Teal, 0, 0,
			window.Width, window.Height);

			//window.Background = null;

			return window;
		}

		static void InitDisplay()
		{
			var backlightPort = EPM815.Gpio.Pin.PD14 / 16;
			var backlightPin = EPM815.Gpio.Pin.PD14 % 16;

			var gpioDriver = new LibGpiodDriver(backlightPort);
			var gpioController = new GpioController(PinNumberingScheme.Logical, gpioDriver);

			gpioController.OpenPin(backlightPin, PinMode.Output);
			gpioController.Write(backlightPin, PinValue.High); // low is on


			var configuration = new FBDisplay.Configuration()
			{
				Clock = 10000,
				Width = 480,
				Hsync_start = 480 + 2,
				Hsync_end = 480 + 2 + 41,
				Htotal = 480 + 2 + 41 + 2,
				Height = 272,
				Vsync_start = 272 + 2,
				Vsync_end = 272 + 2 + 10,
				Vtotal = 272 + 2 + 10 + 2,

			};

			var setting = $"{configuration.Clock},";

			setting += $"{configuration.Width},{configuration.Hsync_start},{configuration.Hsync_end},{configuration.Htotal},";
			setting += $"{configuration.Height},{configuration.Vsync_start},{configuration.Vsync_end},{configuration.Vtotal},";
			setting += $"{configuration.Num_modes},{configuration.Dpi_width},{configuration.Dpi_height},{configuration.Bus_flags},{configuration.Bus_format},{configuration.Connector_type},{configuration.Bpc}";

			Console.WriteLine(setting);

			var fbDisplay = new FBDisplay(configuration);

			displayController = new DisplayController(fbDisplay);
		}

		public static void InitializeTouch()
		{
			var resetPin = EPM815.Gpio.Pin.PF2 % 16;
			var resetPort = EPM815.Gpio.Pin.PF2 / 16;

			var gpioController = new GpioController(PinNumberingScheme.Logical, new LibGpiodDriver(resetPort));
			gpioController.OpenPin(resetPin);
			gpioController.Write(resetPin, PinValue.Low);

			Thread.Sleep(100);

			gpioController.Write(resetPin, PinValue.High);



			// On dev
			//EPM815.I2c.Initialize(EPM815.I2c.I2c6);
			//var touch = new FT5xx6Controller(EPM815.I2c.I2c6, EPM815.Gpio.Pin.PF12);

			// On Domino
			EPM815.I2c.Initialize(EPM815.I2c.I2c5);
			var touch = new FT5xx6Controller(EPM815.I2c.I2c5, EPM815.Gpio.Pin.PB11);

			touch.TouchDown += (a, b) =>
			{
				//Console.WriteLine("Touch down " + b.X + ", " + b.Y);
				Program.MainApp.InputProvider.RaiseTouch(b.X, b.Y, GHIElectronics.Endpoint.UI.Input.TouchMessages.Down, System.DateTime.Now);
			};

			touch.TouchUp += (a, b) =>
			{
				//Console.WriteLine("Touch up " + b.X + ", " + b.Y);

				Program.MainApp.InputProvider.RaiseTouch(b.X, b.Y, GHIElectronics.Endpoint.UI.Input.TouchMessages.Up, System.DateTime.Now);
			};

			//Thread.Sleep(-1);
		}
	}
}
```

---

## Windows

While you can have multiple windows in your UI application, it is mandatory to have at least one window. 

---

## Elements
A window is not very useful without some elements (controls). There are many available standard elements, and you can make your own custom elements as well. All elements descend from the `UIElement` class. Explore the `GHIElectronics.Endpoint.UI.Controls` namespace to see what's available.

For the sake of simplifying the rest of this tutorial, we've added the `private static UIElement Elements()` method that creates and returns the elements. This is then assigned to the child of our window. You will need to add `window.Child = Elements()` right before returning from `CreateWindow`.


```cs
private static UIElement Elements() {
    var txt = new TextBox {
        Font = new Font(14),
        Text = "Hello World!",
        HorizontalAlignment = HorizontalAlignment.Center,
        VerticalAlignment = VerticalAlignment.Center
    };
    return txt;
}
```

### TextBox
The TextBox allows for both single line and multiple line text input.

```cs
var textBox = new TextBox() {
    Text = "This is TextBox",
    Font = new Font(14),
    Width = 120,
    Height = 25,
    HorizontalAlignment = HorizontalAlignment.Center,
    VerticalAlignment = VerticalAlignment.Center,

};
```

### Panel
A `Window` can carry only a single `Child`, that is a single element. This is not a concern because the single element can be a container, like a `Panel`, which holds multiple elements. You can even have panels within panels with each having its own elements. This example will introduce shapes found in the `GHIElectronics.Endpoint.UI.Shapes` namespace. It also shows an example of the `TextBox` element. We will also set margins for a better look.

```cs
private static UIElement Elements() {
    var panel = new Panel();

    var txt1 = new TextBox() {
        HorizontalAlignment = HorizontalAlignment.Left,
        VerticalAlignment = VerticalAlignment.Top,
    };

    txt1.Font = new Font(14);
    txt1.SetMargin(20);
    txt1.Text = "Hello World!";

    var txt2 = new Text(new Font(14), "Endpoint is Great!") {
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

```cs
private static UIElement Elements() {
    var panel = new StackPanel(Orientation.Vertical);

    var txt1 = new TextBox() {
        HorizontalAlignment = HorizontalAlignment.Left,
        VerticalAlignment = VerticalAlignment.Top,
    };

    txt1.Font = new Font(14);
    txt1.SetMargin(20);
    txt1.Text = "Hello World!";

    var txt2 = new Text(new Font(14), "Endpoint is Great!") {
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

```cs
private static UIElement Elements() {
    var canvas = new Canvas();

    var txt = new Text(new Font(14), "Endpoint is Great!") {
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

```cs
private static UIElement Elements() {
    var border = new Border();
    border.SetBorderThickness(10);
    border.BorderBrush = new SolidColorBrush(Colors.Red)

    var txt = new TextBox() {
        //HorizontalAlignment = HorizontalAlignment.Center,
        //VerticalAlignment= VerticalAlignment.Center,
    };

    txt.Font = new Font(14);
    txt.Text = "Endpoint is Great!";
    border.Child = txt;

    return border;
}
```

The fix is to add a container and then the container will have a border. In this example, the parent of the border is the canvas instead of the window.

```cs
private static UIElement Elements() {
    var canvas = new Canvas();
    var border = new Border();

    border.SetBorderThickness(10);
    border.BorderBrush = new SolidColorBrush(Colors.Red);

    Canvas.SetLeft(border, 20);
    Canvas.SetTop(border, 20);

    var txt = new TextBox();
    txt.Font = new Font(14);
    txt.Text = "Endpoint is Great!";

    border.Child = txt;
    canvas.Children.Add(border);

    return canvas;
}
```

### Button

Buttons are simple controls that accept user input in the form of a click, which in embedded devices is usually a finger tap on a touch screen. The button needs a child, typically text, which describes the button's function. Buttons have a `Click` event to respond to user input.

```cs
private static UIElement Elements() {
    var txt = new Text(new Font(14), "Push me!") {
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

```cs
private static UIElement Elements() {
    var textFlow = new TextFlow();
    textFlow.TextRuns.Add("Hello ", font, Colors.Red);
    textFlow.TextRuns.Add("World!", font, Colors.Purple);
    textFlow.TextRuns.Add(TextRun.EndOfLine);
    textFlow.TextRuns.Add("Endpoint is Great!", font, Colors.Yellow);

    return textFlow;
}
```

### ListBox

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

### ScrollViewer

The scroll viewer allows for viewing content that is larger than the viewing area. User input is used to shift the content within the viewing area.

```cs
// Create a scrollviewer
var scrollViewer = new ScrollViewer {
	Background = new SolidColorBrush(Colors.Gray),

	// scroll line by line with 10 pixels per line
	ScrollingStyle = ScrollingStyle.LineByLine,
	LineWidth = 10,
	LineHeight = 10    
};
    
```

Register Touch event, items in scrollViewer will go up or down every time touched. 

```cs
scrollViewer.TouchUp += ScrollViewer_TouchUp;
```

```cs
private void ScrollViewer_TouchUp(object sender, GHIElectronics.Endpoint.UI.Input.TouchEventArgs e) {
	var s = (ScrollViewer)sender;

	s.LineDown();
}
```

### MessageBox

```cs
var font = "user font"; //new Font(14)
var messageBox = new MessageBox(font);

messageBox.Show("Is this messageBox?", "MessageBox caption", MessageBox.MessageBoxButtons.YesNo);

messageBox.ButtonClick += (a, b) =>
{
	Debug.WriteLine(b.DialogResult.ToString());

};
```

### Slider

```cs
var slider = new Slider(30, 150);

slider.Direction = Orientation.Vertical;
slider.OnValueChanged += (a, b) => Debug.WriteLine("new value = " + b.Value);	
```

### DataGrid

```cs
var gridWidth = 400;
var rowCount = 5;
var columnWidth = 60;
var rowHeight = 60;
var font = "user font";

var dataGrid = new DataGrid(gridWidth, rowHeight, rowCount, font);

var colum1 = new DataGridColumn("Column 1", columnWidth);
var colum2 = new DataGridColumn("Column 2", columnWidth);
var colum3 = new DataGridColumn("Column 3", columnWidth);


var item123 = new DataGridItem(new string[] { "item 1", "item 2", "item 3" });
var item456 = new DataGridItem(new string[] { "item 4", "item 5", "item 6" });

// Add column
dataGrid.AddColumn(colum1);
dataGrid.AddColumn(colum2);
dataGrid.AddColumn(colum3);


// Add Item
dataGrid.AddItem(item123);
dataGrid.AddItem(item456);

// Touch Event
dataGrid.TapCellEvent += (a, b) =>
{
	Debug.WriteLine(b.ToString());
};
```

### Chart

```cs
var chartData = new ArrayList();

var random = new Random();
for (var i = 0; i < 10; i++) {
	chartData.Add(new DataItem() { Value = random.Next(100), Name = $"N{i}" });
}

var chart = new Chart(400, 200) {

	Font = 'your font', // need font
	DivisionAxisX = 1,
	DivisionAxisY = 10,
	RadiusPoint = 10,
	ChartTitle = "Endpoint Chart",
	Items = chartData,
	Mode = ChartMode.RectangleMode
};

```

### The Dispatcher

The User Interface libraries rely on a dispatcher to handle system events and update invalidated elements. All elements are changed and updated from within the dispatcher. In this example, we will show the time on the screen. The time will be in a text box that is updated every second using a `Timer`. Since timers run in their own thread, a dispatcher invoke is needed.

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

You can also use the dispatcher timer directly:

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

### User Input
A user can feed input to the graphical interface through touch or button input.

#### Touch input
```cs
app.InputProvider.RaiseTouch(x, y, touchState, DateTime.UtcNow);
app.InputProvider.RaiseButton(btn, btnState, DateTime.UtcNow);
```

The [touch](touch-screen.md) tutorial has further details.

#### Button input

User can map gpio pin to button left, right, back, home or select. Below is how to use left, right on MessageBox, assuming that Left is Yes, Right is No.

```
//Declare gpio pin cs

var buttonLeft = gpioController.OpenPin(SC20100.GpioPin.PE3);

var buttonRight = gpioController.OpenPin(SC20100.GpioPin.PB7);

buttonLeft.SetDriveMode(GpioPinDriveMode.InputPullUp);
buttonRight.SetDriveMode(GpioPinDriveMode.InputPullUp);

buttonLeft.DebounceTimeout = TimeSpan.FromMilliseconds(50);
buttonRight.DebounceTimeout = TimeSpan.FromMilliseconds(50);

buttonLeft.ValueChangedEdge = GpioPinEdge.RisingEdge;
buttonRight.ValueChangedEdge = GpioPinEdge.RisingEdge;

// Map to Input event
buttonLeft.ValueChanged += (a, b) =>
{
    Program.MainApp.InputProvider.RaiseButton(GHIElectronics.Endpoint.UI.Input.HardwareButton.Left, true, DateTime.UtcNow);
};

buttonRight.ValueChanged += (a, b) =>
{
    Program.MainApp.InputProvider.RaiseButton(GHIElectronics.Endpoint.UI.Input.HardwareButton.Right, true, DateTime.UtcNow);
};

// Usage:

void TestMessageBox(int counter)
{	
    var messageBox = new MessageBox(this.font12); // assuming font12 load from resource. Example: font12 = Resources.GetFont(Resources.FontResources.droid_reg12);
    this.mainStackPanel.Children.Add(messageBox); //  messagebox to parent Element, here is this.mainStackPanel: example mainStackPanel = new StackPanel(Orientation.Vertical);
    messageBox.AddHandler(Buttons.ButtonUpEvent, new RoutedEventHandler(ProcessMessageboxButtons), true);
    messageBox.Show("Counter " + counter.ToString() + ". Are you sure?", "Confirm", MessageBox.MessageBoxButtons.YesNo);
    Buttons.Focus(messageBox); // focus event to messagebox

	// Use touch if touch is available.
    messageBox.ButtonClick += (a, b) =>
    {
        if (b.DialogResult == MessageBox.DialogResult.Yes)
        {
            Debug.WriteLine("Press yes");
        }

    };

	// Process gpio button events
    void ProcessMessageboxButtons(object sender, RoutedEventArgs e)
    {
        var buttonSource = (GHIElectronics.Endpoint.UI.Input.ButtonEventArgs)e;                       
        switch (buttonSource.Button)
        {
            case GHIElectronics.Endpoint.UI.Input.HardwareButton.Left:                
                Debug.WriteLine("Button left - "Yes" pressed");
                break;

            case GHIElectronics.Endpoint.UI.Input.HardwareButton.Right:
                Debug.WriteLine("Button Right - "No" pressed");
                break;

            case GHIElectronics.Endpoint.UI.Input.HardwareButton.Select:
                Debug.WriteLine("Button Select pressed");
                break;

        }
        messageBox.Close(); // close messagebox       
    }
    this.mainStackPanel.Invalidate(); // parent Invalidate
}

```

## Avalonia UI
Creating beautiful and functional User Interfaces is much easier on a hardware device when developers can use existing .NET APIs. 

Avalonia UI is an open-source UI framework for building stunning desktop, mobile, web, and embedded applications using a .NET single codebase.  Their API can be found [here.](https://docs.avaloniaui.net/docs/welcome)

Endpoint takes advantage of Avalonia UI's cross-platform WPF. The `GHIElectronics.Endpoint.Drivers.Avalonia.Input` combined with the standard Avalonia NuGet package includes everything you need. 

Included on the [Endpoint Samples Repo](https://github.com/ghi-electronics/endpoint-samples) is a simple working example to get started with. 

---

## Virtual Keyboard
To help create a seamless UI experience on embedded devices we've created a virtual keyboard driver. This virtual keyboard is built into the Avalonia driver and can also be used stand-alone in any project. Implementation is simple.

```cs
var keyboard = new VirtualKeyboard(displayController);

touch.TouchUp += (a, b) =>{
keyboard.UpdateKey(b.X, b.Y);
};

keyboard.Show();
```

The [Endpoint Samples Repo](https://github.com/ghi-electronics/endpoint-samples) contains the full virtual keyboard example.