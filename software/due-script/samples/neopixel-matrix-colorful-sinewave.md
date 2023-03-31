# NeoPixel 16x16 Matrix colorful sine wave

This sample shows a colorful sine wave scrolling along the matrix


Hardware:
- Any device supporting DUE-Script
- NeoPixel 16x16 Matrix with zig-zag matrix configuration

```basic
# NeoPixel - Colorful Moving sine wave
h=16:w=16
i=0
z=3.1415926/6
@loop
  NeoClear()
  for x=0 to 15
    d = x+i
    y = 8+sin(d*z)*6
    pxl()
    NeoSet(p,128,0,0)

    y = 8+sin((d+1)*z)*6
    pxl()
    NeoSet(p,0,128,0)

    y = 8+sin((d+2)*z)*6
    pxl()
    NeoSet(p,0,0,128)
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
