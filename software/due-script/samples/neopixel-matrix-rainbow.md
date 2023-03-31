# NeoPixel 16x16 Matrix Rainbow

This sample shows a colorful rainbow

Hardware:
- Any device supporting DUE-Script
- NeoPixel 16x16 Matrix with zig-zag matrix configuration

```basic
# NeoPixel - Rainbow
h=16:w=16
z=3.1415926/15
NeoClear()
for x=0 to 15 
  for i=4 to 8
    y = i+sin(x*z)*6
    pxl()
    if i%5=0:NeoSet(p,0,0,128):end
    if i%5=1:NeoSet(p,0,128,0):end
    if i%5=2:NeoSet(p,0,128,128):end
    if i%5=3:NeoSet(p,128,0,0):end
    if i%5=4:NeoSet(p,128,0,128):end
  next
next
neoshow(256)
exit

# Formula for index into 16x16 NeoPixel Matrix
# p=pxl(x,y)
@pxl
  p = x*w+(x&1)*(w-1)+(1-2*(x&1))*y
  return
```
