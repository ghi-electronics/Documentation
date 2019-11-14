# Fonts

Fonts can be included in your TinyCLR application by adding them as a [resource](../resources.md). Any TrueType font can be used after being converted to the .tcfnt format with the FontConverter tool. The Font Converter tool (found under [downloads](../../downloads.md) is a command line utility which does just that. Make sure to use this tool for any fonts you need, using old fonts from NETMF will not work.

```cs
var screen = Graphics.FromHdc(displayController.Hdc);
var font = Resource.GetFont(Resource.FontResources.NinaB);
var greenPen = new Pen(Color.Green);
screen.DrawString("Hello World!", font, greenPen.Brush, 10, 100);
screen.Flush();
```

## Built-in fonts
When using systems with managed SPI display drivers, the font support is handled though an internal built-in font. This is done to reduce memory requirements.

```cs
var teal = new SolidBrush(Color.Teal);
var font = new Font("GHIMono8x5", 8);
screen.DrawString("Hello World!", font, teal, 40, 10);
screen.Flush();
```

## Font Conversion

To convert a font you must first make a .fntdef file which is a text file describing the font to convert as well as a number of other parameters. This file contains one option on each line. A minimal .fntdef file may look like this to have the standard ASCII characters.

```
SelectFont "FN:Arial,WE:400,HE:12,IT:0"
ImportRange 32 126
```

> [!TIP]
> This [third-party tool](http://informatix.miloush.net/microframework/Utilities/TinyFontTool.aspx) can be handy for generating compatible fonts.

## Font Defenition
The .fntdef file options are as follows:

> [!Note]
> The order of statements in the .fntdef file matters. For example, properties such as AntiAlias must be specified before the InputRange property.

* AddFontToProcess *path*
  
    *Path* is the path to the TrueType font you want to convert. If the path contains spaces, you must enclose it in quotes and escape any backslashes.

    Example: `AddFontToProcess C:\Windows\Fonts\Arial.ttf`

* SelectFont *"selection string"*

    *"Selection string"* is a quoted string containing comma delimited fields indicating the characteristics of the font to convert. ConvertFont searches the TrueType fonts installed on your computer, as well as any fonts in the AddFontToProcess argument, for a font matching the characteristics in the *selection string* argument. The first match is converted.

    Using spaces around the commas or colons in *selection string* will result in errors. Field types are as follows:

    * HE: Height in logical units. Use zero for default height, a positive number for cell height and a negative number for character height.
    * WI: Width. Average width of characters in logical units. Set to zero for closest match based on aspect ratio.
    * ES: Escapement angle in tenths of a degree. Negative numbers rotate clockwise, positive numbers rotate counterclockwise.
    * WE: Weight of font in range of 0 to 1000. 400 is normal, 700 is bold. Set to zero for default weight.
    * IT: Italic if set to 1 (IT:1).
    * FN: Face name. Name of the typeface.
    * FullName: Full name. The unique name of the font. For example: "Monotype:Arial Regular (Microsoft)."

  For example, `SelectFont "HE:12,WE:400,FN:Arial"` will look for a regular-weight font of height 12 with a face name of "Arial."

* AdjustAscent *adjustment*

    *Adjustment* is integer number of EM units to adjust ascent. Can be positive or negative. Can only be used once per .fntdef file. If it is used more than once, only the last occurrence will be used.

* AdjustDescent *adjustment*

    *Adjustment* is integer number of EM units to adjust descent. Can be positive or negative. Can only be used once per .fntdef file. If it is used more than once, only the last occurrence will be used.

* AdjustExternalLeading *adjustment*

    *Adjustment* is integer number of EM units to adjust the external leading. Can be positive or negative. Can only be used once per .fntdef file. If it is used more than once, only the last occurrence will be used.

* AdjustInternalLeading *adjustment*

    *Adjustment* is integer number of EM units to adjust the internal leading. Can be positive or negative. Can only be used once per .fntdef file. If it is used more than once, only the last occurrence will be used.

* AdjustLeftMargin *adjustment*

    *Adjustment* is integer number of device units to add to the left margin. Can be positive or negative. Applies to the characters specified by the ImportRange statement that most closely follows this option.

* AdjustRightMargin *adjustment*

    *Adjustment* is integer number of EM units to add to the right margin. Can be positive or negative. Applies to the characters specified by the ImportRange statement that most closely follows this statement.

* AntiAlias *level*

    *Level* can be 1, 2, 4, or 8. Font bitmaps will contain 2, 5, 17, or 65 levels of gray respectively. Must come after the SelectFont statement specifying the font to which this statement applies. May be applied to a range of characters defined by the ImportRange option.

* ImportRange *start end*

    *Start* and *end* are Unicode character codes indicating the beginning and end of the range of characters to convert (inclusive). Can be applied multiple times to convert a non-contiguous range of characters. Must come after the SelectFont statement specifying the font to which this statement applies. Both arguments are required. To specify a single character, make start and end the same number.

* ImportRangeAndMap *start end offset*

    Specifies range of characters to convert starting with Unicode character *start* + *offset* and ending with character *end* + *offset*, inclusive. Can be applied multiple times to convert a non-contiguous range of characters. Must come after the SelectFont statement specifying the font to which this statement applies.

* NoDefaultCharacter

    Specifies that no default character will be substituted for characters not converted. Must come after the SelectFont statement specifying the font to which this statement applies.

* OffsetX *adjustment*

    *Adjustment* is an integer describing the number of EM units to shift character position left or right. Positive numbers shift to the left, and negative numbers shift to the right. Applies to characters specified by any ImportRange, ImportRangeAndMap, or SetAsDefaultCharacter statements that follow it in the .fntdef file. Subsequent OffsetX statements supersede all previous OffxetX statements in the same .fntdef file.

* OffsetY *adjustment*

    *Adjustment* is an integer describing the number of EM units to shift character position up or down. Positive numbers shift down, and negative numbers shift up. Applies to characters specified by any ImportRange, ImportRangeAndMap, or SetAsDefaultCharacter statements that follow it in the .fntdef file. Subsequent OffsetX statements supersede all previous OffxetX statements in the same .fntdef file.

* SetAsDefaultcharacter *charcode*

    *"Charcode* is the Unicode character code for the default character to substitute for characters that weren't converted.

* SetDefaultcharacter

    Indicates that the default character of the currently selected TrueType font will be substituted for characters that weren't converted.

* Verbosity *level*

    > [!Note]
    > Not currently supported, set to 0.

    *Level* can be 0, 1, or 2. Level 0 displays no details, level 1 displays font properties, and level 2 displays font and character properties and a diagram of each character.

* \# Comments

    You can add comments to your .fntdef file by starting the comment line with the "#" character.

Syntax for running FontConverter is GHIElectronics.TinyCLR.FontConverter.exe *input-font* *output-font*. For example `GHIElectronics.TinyCLR.FontConverter.exe Arial.fntdef Arial.tcfnt`.

