# Pulse Flappy Birds

![Pulse Falling Bird](images/pulse-falling-bird.gif)


This sample creates a falling bird game just like the NeoPixel version [NeoPixel version](falling-bird.md)  of the game. The object is for the player to move to avoid random obstacles.
Hardware:
- Brainpad Pulse

```basic
u=4       # Player X position
v=8       # Player Y position
t=0       # Player tail Y offset
b=31      # Wall X position
h=4       # Wall height
g=6       # Wall gap
BtnEnable('a', 1)
# Game loop
@loop
  LcdClear(0)
  plyr()
  wall()
  coll()
  LcdShow()
goto loop
# Handle the player
@plyr
  if BtnDown('a')
    if v>0:v=v-1:end
    t=1
  else
    if v<15:v=v+0.5:end
    t=-1
  end
  x=u
  y=trunc(v)
  pxl()
  x=x-1
  y=y+t
  pxl()
return
# Update wall
@wall
  b=b-0.5
  if b<=0
    b=31
    g=4+rnd(2)
    h=2+rnd(6)
  end
  x=trunc(b)
  for y=0 to h
    pxl()      
  next
  for y=h+g to 15
    pxl()
  next
return
# Check collision
@coll
  i=trunc(b)
  if i != u:return:end
  if v<=h:goto die:end
  if v>=h+g:goto die:end
return
# Player died
@die
  for i=0 to 20
    x=(u-2)+rnd(4)
    y=(v-2)+rnd(4)
    pxl()
    LcdShow()
  next
  b=31
return
# Plot large pixel
# p=pxl(x,y)
@pxl
  #for i=0 to 2: for j=0 to 3:LcdPixel(1, x*4+j, y*3+i):next:next
  LcdPixel(1, x*4, y*3)
  LcdPixel(1, x*4+1, y*3)
  LcdPixel(1, x*4+2, y*3)
  LcdPixel(1, x*4+3, y*3)
  LcdPixel(1, x*4, y*3+1)
  LcdPixel(1, x*4+1, y*3+1)
  LcdPixel(1, x*4+2, y*3+1)
  LcdPixel(1, x*4+3, y*3+1)
  LcdPixel(1, x*4, y*3+2)
  LcdPixel(1, x*4+1, y*3+2)
  LcdPixel(1, x*4+2, y*3+2)
  LcdPixel(1, x*4+3, y*3+2)
return
```