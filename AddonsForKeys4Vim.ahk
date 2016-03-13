#UseHook On


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


#IfWinActive ahk_exe swf_player.exe
vk20::send {vk20}   ;space to space
LControl::
MouseClick, left,  1010,  730
Sleep, 100
MouseClick, left,  1166,  721
Sleep, 100
MouseClick, left,  1166,  721
Sleep, 100
MouseMove, 683, 390
Sleep, 100
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