# NeoPixel 16x16 Matrix sine wave

This sample shows a sine wave scrolling along the matrix

Hardware:
- Any device supporting DUE-Script
- NeoPixel 16x16 Matrix with zig-zag matrix configuration

```basic
# NeoPixel - Moving sine wave
h=16:w=16
z=3.1415926/6
i=0
@loop
  NeoClear()
  for x=0 to 15
    y = 8+sin((x+i)*z)*6
    pxl()
    NeoSet(p,0,128,0)
  next
  NeoShow(256)
  i=i+1
goto loop

# Formula for index into 16x16 NeoPixel Matrix
# p=pxl(x,y)
@pxl
  p = x*w+(x&1)*(w-1)+(1-2*(x&1))*y
  return
```
