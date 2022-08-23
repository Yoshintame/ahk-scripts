MsgBox, 0x4,, Start auto script?
IfMsgBox, Yes
{
    Run, https://www.backloggd.com/search/games/ 
    Sleep, 2000
    main()
}
IfMsgBox, No
{
    ExitApp
}

#Persistent
CoordMode Pixel, Screen
CoordMode Mouse, Screen
return


    

main()
{
    wbk := ComObjGet("C:\autohotkey-scripts\test.xlsx")
    CellVal := wbk.Sheets("Sheet1").Cells(StaticIncVar(1), 1).Value

    NextGame(CellVal)

    Sleep, 1000

    If GameAlreadyAdded()
    {
        main()
    }
    Else
    {
        AddNewGame()
        main()
    }
    return
}

    





;------------funcs-------------

StaticIncVar(temp) 
{
	static incVal := temp
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
