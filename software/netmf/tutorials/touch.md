# Touch
---

## Introduction
NETMF devices have the ability to receive touch input from a touch screen.

## Getting Started
The below code draws a blue circle wherever you touch on the display. Make sure that you have configured your display properly before running this example. It requires the Microsoft.SPOT.Graphics, Microsoft.SPOT.TinyCore, and Microsoft.SPOT.Touch assemblies.

```cs
using Microsoft.SPOT;
using Microsoft.SPOT.Input;
using Microsoft.SPOT.Presentation;
using Microsoft.SPOT.Presentation.Media;
using Microsoft.SPOT.Touch;

public class Program : Application
{
    private Bitmap lcd;

    public static void Main()
    {
        Program app = new Program();

        app.Run();
    }

    public Program()
    {
        this.lcd = new Bitmap(SystemMetrics.ScreenWidth, SystemMetrics.ScreenHeight);

        Touch.Initialize(this);

        this.MainWindow = new Window();

        this.MainWindow.TouchDown += MainWindow_TouchDown;
        this.MainWindow.TouchUp += MainWindow_TouchUp;
        this.MainWindow.TouchMove += MainWindow_TouchMove;
    }

    private void MainWindow_TouchMove(object sender, TouchEventArgs e)
    {
        Debug.Print("Touch move at (" + e.Touches[0].X.ToString() + ", " + e.Touches[0].Y.ToString() + ")");

        this.lcd.DrawEllipse(Colors.Blue, e.Touches[0].X, e.Touches[0].Y, 5, 5);
        this.lcd.Flush();
    }

    private void MainWindow_TouchUp(object sender, TouchEventArgs e)
    {
        Debug.Print("Touch up at (" + e.Touches[0].X.ToString() + ", " + e.Touches[0].Y.ToString() + ")");
    }

    private void MainWindow_TouchDown(object sender, TouchEventArgs e)
    {
        Debug.Print("Touch down at (" + e.Touches[0].X.ToString() + ", " + e.Touches[0].Y.ToString() + ")");
    }
}
```

## Touch In Gadgeteer
Since Gadgeteer already creates an application instance, you cannot use the above example in a Gadgeteer program. You must instead use the pre-created application instance available under Application.Current. The below example shows you how to use touch in a Gadgeteer program.
 
> [!Tip]
> In the below example we still use a Bitmap object to draw to the display. Usually in Gadgeteer programs you will want to use the SimpleGraphics interface on a display module.

```
using Microsoft.SPOT;
using Microsoft.SPOT.Input;
using Microsoft.SPOT.Presentation;
using Microsoft.SPOT.Presentation.Media;
using Microsoft.SPOT.Touch;

public partial class Program
{
    private Bitmap lcd;

    void ProgramStarted()
    {
        this.lcd = new Bitmap(SystemMetrics.ScreenWidth, SystemMetrics.ScreenHeight);

        Touch.Initialize(Application.Current);

        this.display.WPFWindow.TouchDown += this.MainWindow_TouchDown;
        this.display.WPFWindow.TouchUp += this.MainWindow_TouchUp;
        this.display.WPFWindow.TouchMove += this.MainWindow_TouchMove;
    }

    private void MainWindow_TouchMove(object sender, TouchEventArgs e)
    {
        Debug.Print("Touch move at (" + e.Touches[0].X.ToString() + ", " + e.Touches[0].Y.ToString() + ")");

        this.lcd.DrawEllipse(Colors.Blue, e.Touches[0].X, e.Touches[0].Y, 5, 5);
        this.lcd.Flush();
    }

    private void MainWindow_TouchUp(object sender, TouchEventArgs e)
    {
        Debug.Print("Touch up at (" + e.Touches[0].X.ToString() + ", " + e.Touches[0].Y.ToString() + ")");
    }

    private void MainWindow_TouchDown(object sender, TouchEventArgs e)
    {
        Debug.Print("Touch down at (" + e.Touches[0].X.ToString() + ", " + e.Touches[0].Y.ToString() + ")");
    }
}
```

## Calibration
If your screen does not report touches close to where they actually were, your screen may need to be calibrated. NETMF provides functionality that can do this for you. It will give you a list of coordinates to touch at based on the configured screen size and then you give it the coordinates returned when you touch that spot on the display. It usually asks for five points: the four corners and the center.

The below example takes care of all of this calibration for you. It requires the Microsoft.SPOT.Native, Microsoft.SPOT.Graphics, Microsoft.SPOT.TinyCore, and Microsoft.SPOT.Touch assemblies. You begin calibration by touching the screen once. After that, touch where each of the five circles is displayed in turn. After you do that, it will show you the calibration data and show a circle wherever you touch.

```
using Microsoft.SPOT;
using Microsoft.SPOT.Input;
using Microsoft.SPOT.Presentation;
using Microsoft.SPOT.Presentation.Media;
using Microsoft.SPOT.Touch;

public class Program : Application
{
    private Bitmap lcd;
    private bool started;
    private bool finished;
    private int currentCalibrationPoint;
    private int calibrationPoints;
    private short[] screenX;
    private short[] screenY;
    private short[] uncalibratedX;
    private short[] uncalibratedY;

    public static void Main()
    {
        new Program().Run();
    }

    public Program()
    {
        this.lcd = new Bitmap(SystemMetrics.ScreenWidth, SystemMetrics.ScreenHeight);

        Touch.Initialize(this);

        this.MainWindow = new Window();
        this.MainWindow.TouchUp += this.OnTouchUp;

        this.currentCalibrationPoint = 0;
        this.calibrationPoints = 0;
        this.started = false;
        this.finished = false;

        Touch.ActiveTouchPanel.GetCalibrationPointCount(ref this.calibrationPoints);

        this.screenX = new short[this.calibrationPoints];
        this.screenY = new short[this.calibrationPoints];
        this.uncalibratedX = new short[this.calibrationPoints];
        this.uncalibratedY = new short[this.calibrationPoints];

        for (int i = 0, x = 0, y = 0; i < this.calibrationPoints; i++)
        {
            Touch.ActiveTouchPanel.GetCalibrationPoint(i, ref x, ref y);

            this.screenX[i] = (short)x;
            this.screenY[i] = (short)y;
        }

        Touch.ActiveTouchPanel.StartCalibration();
    }

    private void OnTouchUp(object sender, TouchEventArgs e)
    {
        if (this.started && !this.finished)
        {
            this.uncalibratedX[this.currentCalibrationPoint] = (short)e.Touches[0].X;
            this.uncalibratedY[this.currentCalibrationPoint] = (short)e.Touches[0].Y;

            if (++this.currentCalibrationPoint == this.calibrationPoints)
            {
                Touch.ActiveTouchPanel.SetCalibration(this.calibrationPoints, this.screenX, this.screenY, this.uncalibratedX, this.uncalibratedY);

                this.lcd.Clear();

                var str = "Screen X: [";
                for (int i = 0; i < this.calibrationPoints; i++)
                    str += this.screenX[i].ToString() + (i + 1 != this.calibrationPoints ? ", " : string.Empty);
                str += "]";
                this.lcd.DrawText(str, Resources.GetFont(Resources.FontResources.NinaB), Colors.White, 0, 0);

                str = "Screen Y: [";
                for (int i = 0; i < this.calibrationPoints; i++)
                    str += this.screenY[i].ToString() + (i + 1 != this.calibrationPoints ? ", " : string.Empty);
                str += "]";
                this.lcd.DrawText(str, Resources.GetFont(Resources.FontResources.NinaB), Colors.White, 0, 15);

                str = "Uncalibrated X: [";
                for (int i = 0; i < this.calibrationPoints; i++)
                    str += this.uncalibratedX[i].ToString() + (i + 1 != this.calibrationPoints ? ", " : string.Empty);
                str += "]";
                this.lcd.DrawText(str, Resources.GetFont(Resources.FontResources.NinaB), Colors.White, 0, 30);

                str = "Uncalibrated Y: [";
                for (int i = 0; i < this.calibrationPoints; i++)
                    str += this.uncalibratedY[i].ToString() + (i + 1 != this.calibrationPoints ? ", " : string.Empty);
                str += "]";
                this.lcd.DrawText(str, Resources.GetFont(Resources.FontResources.NinaB), Colors.White, 0, 45);

                this.lcd.Flush();

                this.finished = true;
            }
            else
            {
                this.DrawPoint(this.screenX[this.currentCalibrationPoint], this.screenY[this.currentCalibrationPoint]);
            }
        }
        else if (!this.started)
        {
            this.started = true;

            this.DrawPoint(this.screenX[0], this.screenY[0]);
        }
        else if (this.finished)
        {
            this.DrawPoint(e.Touches[0].X, e.Touches[0].Y);
        }
    }

    private void DrawPoint(int x, int y)
    {
        this.lcd.Clear();
        this.lcd.DrawEllipse(Colors.Red, x, y, 6, 6);
        this.lcd.Flush();
    }
}
```

After you calibrate your display, you can save the values in the four short arrays in the above program along with the number of calibration points. You can then pass these values at a later point, without running calibration again, to the below function.

```
Touch.ActiveTouchPanel.SetCalibration(calibrationPoints, screenX, screenY, uncalibratedX, uncalibratedY);
```