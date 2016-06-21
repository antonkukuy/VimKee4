#UseHook On

;Количество нажатий
F10::
F11::
F12::
N:=0
Loop {
   N++
   KeyWait, %A_ThisHotkey%
   KeyWait, %A_ThisHotkey%, D T0.3
} Until ErrorLevel
If N=1
   Send, {%A_ThisHotkey%}
Else
   Gosub % IsLabel(L := A_ThisHotkey . "_" . N) ? L : "NotCombo"
Return

NotCombo:
   MsgBox % "Количество нажатий " . A_ThisHotkey . " : " . N
Return

F11_2:
   MsgBox % "Количество нажатий " . A_ThisHotkey . " : " . N
Return

F11_3:
   MsgBox % "Количество нажатий " . A_ThisHotkey . " : " . N
Return


; Font, color 
;ToolTipFont(Options, Name)
;Sets the font options and name for subsequent calls to the ToolTip command.
;Parameters are the same as for Gui Font.
;Pass "Default" for Options to restore the font setting to default.


;ToolTipColor(Background, Text)
;Sets the background and text colours for subsequent calls to the ToolTip command.
;Parameters are the same as for Gui Color.
;Pass "Default" for either parameter to restore it to its default. If both are default, the system visual style is used.

;Examples
;ToolTipFont("s20", "Comic Sans MS")    s20 - set 20-points Comic Sans MS
;ToolTipColor("Red", "Blue")

ToolTipFont(Options := "", Name := "", hwnd := "") {
    static hfont := 0
    if (hwnd = "")
        hfont := Options="Default" ? 0 : _TTG("Font", Options, Name), _TTHook()
    else
        SendMessage 0x30, hfont, 0,, ahk_id %hwnd%
}

ToolTipColor(Background := "", Text := "", hwnd := "") {
    static bc := "", tc := ""
    if (hwnd = "") {
        if (Background != "")
            bc := Background="Default" ? "" : _TTG("Color", Background)
        if (Text != "")
            tc := Text="Default" ? "" : _TTG("Color", Text)
        _TTHook()
    }
    else {
        VarSetCapacity(empty, 2, 0)
        DllCall("UxTheme.dll\SetWindowTheme", "ptr", hwnd, "ptr", 0, "ptr", bc tc != "" ? &empty : 0)
        if (bc != "")
            SendMessage 1043, %bc%,,, ahk_id %hwnd%
        if (tc != "")
            SendMessage 1044, %tc%,,, ahk_id %hwnd%
    }
}

_TTHook() {
    static hook := 0
    if !hook
        hook := DllCall("SetWindowsHookExW", "int", 4
            , "ptr", RegisterCallback("_TTWndProc", "F"), "ptr", 0
            , "uint", DllCall("GetCurrentThreadId"), "ptr")
}

_TTWndProc(nCode, _wp, _lp) {
    Critical 999
   ;lParam  := NumGet(_lp+0*A_PtrSize)
   ;wParam  := NumGet(_lp+1*A_PtrSize)
    uMsg    := NumGet(_lp+2*A_PtrSize)
    hwnd    := NumGet(_lp+3*A_PtrSize)
    if (nCode >= 0 && (uMsg = 1081 || uMsg = 1036) && WinExist("ahk_class tooltips_class32 ahk_id " hwnd)) {
        ToolTipColor(,, hwnd)
        ToolTipFont(,, hwnd)
    }
    return DllCall("CallNextHookEx", "ptr", 0, "int", nCode, "ptr", _wp, "ptr", _lp, "ptr")
}

_TTG(Cmd, Arg1, Arg2 := "") {
    static htext := 0, hgui := 0
    if !htext {
        Gui _TTG: Add, Text, +hwndhtext
        Gui _TTG: +hwndhgui +0x40000000
    }
    Gui _TTG: %Cmd%, %Arg1%, %Arg2%
    if (Cmd = "Font") {
        GuiControl _TTG: Font, %htext%
        SendMessage 0x31, 0, 0,, ahk_id %htext%
        return ErrorLevel
    }
    if (Cmd = "Color") {
        hdc := DllCall("GetDC", "ptr", htext, "ptr")
        SendMessage 0x138, hdc, htext,, ahk_id %hgui%
        clr := DllCall("GetBkColor", "ptr", hdc, "uint")
        DllCall("ReleaseDC", "ptr", htext, "ptr", hdc)
        return clr
    }
}


#IfWinActive ahk_exe swf_player.exe
vk20::send {vk20}   ;space to space
;LControl::
ESC::
MouseClick, left,  1166,  721
Sleep, 100
MouseClick, left,  1166,  721
Sleep, 100
MouseMove, 683, 390
Sleep, 100
Return


#IfWinActive

#IfWinActive ahk_exe chrome.exe
+^Space::
send ^{Right}   ;space to space
Return
#IfWinActive

/*
#IfWinActive, ahk_exe ugol.exe
;$vk5D::                            ; vk20 - Space
;$^vk20::                            ; vk20 - Space
;$^LButton::                            ; vk20 - Space
;sc1Dsc39::                            ; vk20 - Space
Esc::
;LButton::
MouseClick, left,  1010,  730
Sleep, 100
MouseClick, left,  1166,  721
Sleep, 100
MouseMove, 683, 390
Sleep, 100
Return



#IfWinActive, ahk_exe swf_player.exe

vk20::send {vk20}   ;space to space
;Esc::
LControl::
;LButton::
MouseClick, left,  1010,  730
Sleep, 100
MouseClick, left,  1166,  721
Sleep, 100
MouseClick, left,  1166,  721
Sleep, 100
MouseMove, 683, 390
Sleep, 100
Return
IfWinExist, Playlist
;MouseClick, left, 343, 19
;Sleep, 100
WinKill ; Использует окно, найденное выше.

#IfWinActive
*/
