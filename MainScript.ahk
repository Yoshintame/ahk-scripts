; *********************** Header - some configuration  *********************************
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors. (disabled by default)
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
setTitleMatchMode, 2 ; set title match mode to "contains"

; **************************************************************************************
;			              Reload/Execute this script.ahk file
; **************************************************************************************



; **************************************************************************************
;                        Configured region - selected functions  
; ************************************************************************************** 

; Keyboard shortcuts Matrix
; (hash)                #    Windows logo key
; (exclamation mark)    !    ALT
; (caret)               ^    CTRL
; (plus)                +    Shift

; *********************************** Programs Hotkeys *********************************
                     
; Open or activate Edge Browser
; Usage: Win + B
#b::ActivateOrOpen("ahk_exe msedge.exe", "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe")

; Open or activate Yandex Browser
; Usage: Win + B
;#b::ActivateOrOpen("ahk_exe browser.exe", "C:\Users\ursus\AppData\Local\Yandex\YandexBrowser\Application\browser.exe")
	
; Open or activate Terminal
; Usage: Win + T	
#t::ActivateOrOpen("ahk_exe WindowsTerminal.exe", WT)
^!t::ActivateOrOpen("ahk_exe WindowsTerminal.exe", WT)

; Open or activate Spotify
; Usage: Win + Y
#y::ActivateOrOpen("ahk_exe Spotify.exe", "C:\Users\ursus\AppData\Roaming\Spotify\Spotify.exe")

; Open or activate Discord
; Usage: Win + C
#c::ActivateOrOpen("ahk_exe Discord.exe", "C:\Users\ursus\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Discord Inc\Discord.lnk")

; Open or activate Telegram
; Usage: Win + H
#h::ActivateOrOpen("ahk_exe Telegram.exe", "C:\Users\ursus\AppData\Roaming\Telegram Desktop\Telegram.exe")

; Open or activate Notion
;#h::ActivateOrOpen("ahk_exe Telegram.exe", "C:\Users\ursus\AppData\Roaming\Telegram Desktop\Telegram.exe")

; Open or activate Steam
;#h::ActivateOrOpen("ahk_exe steam.exe", "C:\Program Files (x86)\Steam\Steam.exe")

; Open or activate Code
#f::ActivateOrOpen("ahk_exe Code.exe", "C:\Program Files\Microsoft VS Code\Code.exe")

; ********************* Text replacements for most used keywords *********************


; Google Search highlighted text
; Usage: Ctrl + Shift + C
^+c::GoogleSearch()

; Create new text file
; Usage: F4
F4::New_Text_File()

; Convert selected text to lower case
;    Ex: THIS_is-a_tESt -> this_is-a_test
; Usage: Windows_Key + Alt + Down Arrow
#!Down::Convert_Lower()

; Convert selected text to upper case
;    Ex: THIS_is-a_tESt -> THIS_IS-A_TEST
; Usage: Windows_Key + Alt + Up Arrow
#!Up::Convert_Upper()

; Fast scroll
; Usage: Shift + WheelDown(Up) 
$+WheelDown::send, {WheelDown 5}
$+WheelUp::send, {WheelUp 5}

; Close window
; Usage: Win + W
#w::CloseActiveWindow()

; Force close window
; Usage: Win + Shift + W
#+w::Send, ^!F4

; Minimize window
; Usage: Win + Q
#q::WinMinimize, A

; ScrollToTop in Edge Browser
; Usage: MMB
#IfWinActive ahk_exe msedge.exe
MButton::ScrollToTop()

; Close tab in Edge Browser
; Usage: LMB (Dont release) + RMB
#IfWinActive ahk_exe msedge.exe
~LButton & RButton::^w

; Reload/Execute this script.ahk file
; Usage: Ctrl + Alt + Scroll Lock
^!ScrollLock::          
Run, "D:\Files\OneDrive\Documents\$MyDocs\Packs\Windows Pack\autohotkey-scripts\littel-scripts.ahk"
Return

; **************************************************************************************
;                          Engine region - Provided Functions  
; ************************************************************************************** 

GoogleSearch()
{
    Send, ^c
    Sleep 50
    Run, http://www.google.com/search?q=%clipboard%
    Return
}

New_Text_File()
{
    Macro1:
    Click, Right, 1
    Sleep, 10
    SendRaw, wt
    Return
}

Convert_Lower()
{
    Clip_Save:= ClipboardAll
    Clipboard:= ""
    Send ^c{delete}
    StringLower Clipboard, Clipboard
    Send %Clipboard%
    Len:= Strlen(Clipboard)
    Send +{left %Len%}
    Clipboard:= Clip_Save
}

Convert_Upper()
{
    Clip_Save:= ClipboardAll
    Clipboard:= ""
    Send ^c{delete}
    StringUpper Clipboard, Clipboard
    Send %Clipboard%
    Len:= Strlen(Clipboard)
    Send +{left %Len%}
    Clipboard:= Clip_Save
}

CloseActiveWindow()
{
    WinGetTitle, Title, A
    PostMessage, 0x112, 0xF060,,, %Title%
    return
}


ScrollToTop(){
	if (A_cursor = "Arrow"){
		SendInput ^{Home}	
	} else {
		Send {MButton}
	}
}


ActivateOrOpen(window, program)
{
	setTitleMatchMode, 2 ; set title match mode to "contains"
	; check if window exists
	if WinExist(window)
	{
		WinActivate,   ; Uses the last found window.
	}
	else
	{   ; else start requested program
		if (window = "ahk_exe WindowsTerminal.exe")
		{
			Run, wt
		}
		else
		{
			Run cmd /c "start ^"^" ^"%program%^"",, Hide ;use cmd in hidden mode to launch requested program
			WinWait, %window%,,5		; wait up to 5 seconds for window to exist
			IfWinNotActive, %window%, , WinActivate, %window%
			{
				WinActivate  ; Uses the last found window.
			}
		}
		
	}
	return
}