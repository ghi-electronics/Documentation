# Pulse Bouncing Ball

This sample bounces a ball of the 4 edges of the screen

<img src="https://www.brainpad.com/wp-content/uploads/2021/06/BrainPadPulse-4-1.png" width="20%" height="20%" />

Hardware:
- Brainpad Pulse


```basic
# Pulse - LCD Bouncing ball
x=64 # Ball X location
y=32 # Ball Y location
r=5  # Ball radius
a=3  # Ball X Speed
b=2  # Ball Y Speed
@loop
   LCDClear(0)        # Clear the screen
   LCDCircle(1,x,y,r) # Draw the ball
   LCDShow()          # Update the screen

   x=x+a:y=y+b        # Move the ball
   
   # Check if the ball hit one of the edges
   #  if it did then reverse the direction and make a sound
   if x<r || x>=(128-r):a=-a:sound(100,16,100):end
   if y<r || y>=(64-r):b=-b:sound(100,16,100):end
goto loop
```
