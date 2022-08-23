

#Persistent
CoordMode Pixel, Screen 
CoordMode Mouse, Screen 
SetTimer, WatchCursor, 1	
return

WatchCursor:
MouseGetPos X, Y 
PixelGetColor Color, %X%, %Y%, RGB

If (Color == 0x663300 || Color == 0x4d4d4d ||Color == 0xab3412 || Color == 0x808080 || Color == 0x666666 || Color == 0x7c0000 || Color == 0x7d3f00 || Color == 0x532900 || Color == 0xa31d0a)
{
	Send {Space}
	Sleep, 400
}






