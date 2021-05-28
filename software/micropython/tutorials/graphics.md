# Graphics

---

The built in [Display](display.md) support includes a graphics library. the flowing methods draw to a frame buffer. Calling `display.show()` will send the frame buffer to the screen.


```
display.fill(0)                         # fill entire screen with color=0
display.pixel(0, 10)                    # get pixel at x=0, y=10
display.pixel(0, 10, 1)                 # set pixel at x=0, y=10 to color=1
display.hline(0, 8, 4, 1)               # draw horizontal line x=0, y=8, width=4, color=1
display.vline(0, 8, 4, 1)               # draw vertical line x=0, y=8, height=4, color=1
display.line(0, 0, 127, 63, 1)          # draw a line from 0,0 to 127,63
display.rect(10, 10, 107, 43, 1)        # draw a rectangle outline 10,10 to 107,43, color=1
display.fill_rect(10, 10, 107, 43, 1)   # draw a solid rectangle 10,10 to 107,43, color=1
display.text('Hello World', 0, 0, 1)    # draw some text at x=0, y=0, color=1
display.scroll(20, 0)                   # scroll 20 pixels to the right
```

It is also possible to create other frame buffers, which are then rendered on top the display's frame buffer.'

```
import framebuf
fbuf = framebuf.FrameBuffer(bytearray(8 * 8 * 1), 8, 8, framebuf.MONO_VLSB)
fbuf.line(0, 0, 7, 7, 1)
display.blit(fbuf, 10, 10, 0)           # draw on top at x=10, y=10, key=0
display.show()
```
