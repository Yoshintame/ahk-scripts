;global userInput
;InputBox, userInput, Cell Number, Enter number of game cell.,,,
;if ErrorLevel
;    ExitApp
;Numpad3::
;Send, % userInput
;lobal globUserInput = userInput
;#Persistent
;CoordMode Pixel, Screen
;CoordMode Mouse, Screen
;return


XButton1::main()

main()
{
    ;Send, % globUserInput

    wbk := ComObjGet("C:\autohotkey-scripts\test.xlsx")

    CellVal := wbk.Sheets("Sheet1").Cells(StaticIncVar(%userInput%), 1).Value

    NextGame(CellVal)

    Sleep, 1000

    If GameAlreadyAdded()


    {
        MsgBox % "Game already added."
        Sleep, 1000
        main()
    }
    Else
    {
        MsgBox, 4096,, Add first game in the list?
        IfMsgBox, Yes
        {
            Sleep, 500
            AddNewGame()
            main()
        }
        IfMsgBox, No
        {
            Sleep, 500
            main()
        }
    }
    return
}

    





;------------funcs-------------

StaticIncVar(temp) 
{
	static incVal := 182
	incVal++
	return incVal
}

NextGame(_cellVal)
{
    WinGet nAHK_ID_ZipSearch, ID, Search 
    ControlClick x1200 y125, ahk_id %nAHK_ID_ZipSearch%,,,, pos NA
    ControlSend ahk_parent , %_cellVal%, ahk_id %nAHK_ID_ZipSearch%
    Send {Enter}
}

GameAlreadyAdded()
{
    PixelGetColor Color, 1407, 300, RGB
    If(Color != 0xEA377A)  
    {
    return False
    }
    return True
}

AddNewGame()
{
    WinGet nAHK_ID_ZipSearch, ID, Search 
    ControlClick x1405 y305, ahk_id %nAHK_ID_ZipSearch%,,,, pos NA
    return
}
