#Persistent
CoordMode Pixel, Screen
CoordMode Mouse, Screen
return

!1::
SetTimer, WatchCursor, 100


WatchCursor:
MouseGetPos X, Y
PixelGetColor Color, %X%, %Y%, RGB

If(Color != 0xFC6399)  ;if NOT white
{
    ToolTip, %Color%
    ;other stuff here
}
else  ;it must be white then
    ToolTip, %Color%

return