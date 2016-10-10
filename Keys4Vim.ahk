; Auto-execute section {{{
Process, Priority, , AboveNormal    ; Эта запись сообщает операционной системе уделить больше внимания к исполнению данных команд

;GroupAdd VimGroup, ahk_exe cmd.exe ; cmd
;GroupAdd VimGroup, ahk_exe MathcadPrime.exe
;GroupAdd VimGroup, ahk_class Photo_Lightweight_Viewer ; Photo_Viewer_windows

;GroupAdd VimGroup

GroupAdd VimGroup
;GroupAdd, VimGroup, , , , Klavarog

;GroupAdd VimGroup, ahk_exe acad.exe
;GroupAdd VimGroup, ahk_exe chrome.exe
;GroupAdd VimGroup, ahk_exe sublime_text.exe
;GroupAdd AllWindons

; vim_verbose: 0 - no message; 1 - short message; 2 - full message
vim_verbose=0


VimMode=Numpad
Vim_g=0
Vim_n=0
VimLineCopy=0

HFONT := GetHFONT("s6", "Arial")
ToolTipEx("S", 1326, 766, 2,HFONT, "Black", "White",,"S")


#UseHook On ; Make it a bit slow, but can avoid infinitude loop
            ; Same as "$" for each hotkey
#InstallKeybdHook ; For checking key history
                  ; Use ~500kB memory?

#HotkeyInterval 2000 ; Hotkey inteval (default 2000 milliseconds).
#MaxHotkeysPerInterval 70 ; Max hotkeys perinterval (default 50).
Suspend
+<!r::Reload  ; Assign LShift-RAlt-R as a hotkey to restart the script.
~vkC0 & F2::ExitApp     ;` & F2
Return

<^Space::
;+LButton::
Suspend
;ToolTip % (A_IsSuspended) ? "S": Return , 1336, 757
If (A_IsSuspended)
{
HFONT := GetHFONT("s6", "Arial")
ToolTipEx("S", 1326, 766, 2,HFONT, "Black", "White",,"S")
Return
}
else if (VimMode ="Insert")
{
HFONT := GetHFONT("s6", "Arial")
ToolTipEx("I", 1326, 766, 2,HFONT, "Yellow", "Black",,"S")
Return
}
else if (VimMode ="Normal")
{
HFONT := GetHFONT("s6", "Arial")
ToolTipEx("N", 1326, 766, 2,HFONT, "Red", "Black",,"S")
Return
}
else (VimMode ="Numpad")
{
HFONT := GetHFONT("s6", "Arial")
ToolTipEx("N", 1326, 766, 2,HFONT, "Blue", "White",,"S")
Return
}
Return

#Include, AddonsForKeys4Vim.ahk
#Include, ToolTipEx.ahk

#IfWInActive, ahk_group VimGroup


;}}}

; Set Mode {{{

VimSetMode(Mode="", g=0, n=0, LineCopy=-1) {
  global
  if(Mode!=""){
    VimMode=%Mode%
  }
  if (g != -1){
    Vim_g=%g%
  }
  if (n != -1){
    Vim_n=%n%
  }
  if (LineCopy!=-1) {
    VimLineCopy=%LineCopy%
  }
  VimCheckMode(vim_verbose,Mode,g,n,LineCopy)
  Return
}
VimCheckMode(verbose=0,Mode="", g=0, n=0, LineCopy=-1) {
  global
  if(verbose<1) or ((Mode=="" ) and (g==0) and (n==0) and (LineCopy==-1)) {
    Return
  }else if(verbose=1){
    TrayTip,VimMode,%VimMode%,1,, ; 1 sec is minimum for TrayTip
  }else if(verbose=2){
    TrayTip,VimMode,%VimMode%`r`ng=%Vim_g%`r`nn=%Vim_n%,1,,
  }
  if(verbose=3){
    Msgbox,
    (
    VimMode: %VimMode%
    Vim_g: %Vim_g%
    Vim_n: %Vim_n%
    VimLineCopy: %VimLineCopy%
    )
  }
  Return
}

;^!+sc1E::    ;sc1E key  - a
^!+a::    ;sc1E key  - a
  VimCheckMode(3,VimMode)
  Return
; }}}

; Enter vim normal mode {{{
#IfWInActive, (ahk_group VimGroup) && (VimMode == "Insert")
;+sc14:: ; Just send Esc at converting, long press for normal Esc.
+t:: ; Just send Esc at converting, long press for normal Esc.
  ;KeyWait, sc14, T0.5   ; sc14 key - t
  KeyWait, t, T0.5   ; sc14 key - t
  if (ErrorLevel){ ; long press
    Send,{Esc}
    Return
  }
  else {
    VimSetMode("Normal")
  }
  Return



/*
^[:: ; Go to Normal mode (for vim) with IME off even at converting.
  KeyWait, [, T0.5
  if (ErrorLevel){ ; long press to Esc
    Send,{Esc}
    Return
  }
*/


; }}}

; Toogle mode {{{

#If WInActive("ahk_group VimGroup")  && (VimMode =="Insert")

t::
VimSetMode("Numpad")  ;q
HFONT := GetHFONT("s6", "Arial")
ToolTipEx("N", 1326, 766, 2,HFONT, "Blue", "White",,"S")
Return
;sc10::VimSetMode("Numpad")  ;q
;sc14::VimSetMode("Normal")  ;t
q::
VimSetMode("Normal")  ;t
HFONT := GetHFONT("s6", "Arial")
ToolTipEx("N", 1326, 766, 2,HFONT, "Red", "Black",,"S")
Return

#If WInActive("ahk_group VimGroup") && (VimMode=="Normal")

q::
VimSetMode("Insert")  ;t
HFONT := GetHFONT("s6", "Arial")
ToolTipEx("I", 1326, 766, 2,HFONT, "Yellow", "Black",,"S")
Return
;sc14::VimSetMode("Insert")  ;t
;sc10::VimSetMode("Numpad")  ;q
t::
VimSetMode("Numpad")  ;q
HFONT := GetHFONT("s6", "Arial")
ToolTipEx("N", 1326, 766, 2,HFONT, "Blue", "White",,"S")
Return

#If WInActive("ahk_group VimGroup") && (VimMode=="Numpad")

t::
VimSetMode("Insert")  ; q
HFONT := GetHFONT("s6", "Arial")
ToolTipEx("I", 1326, 766, 2,HFONT, "Yellow", "Black",,"S")
Return
;sc10::VimSetMode("Insert")  ; q
;sc14::VimSetMode("Normal")  ; t
q::
VimSetMode("Normal")  ; t
HFONT := GetHFONT("s6", "Arial")
ToolTipEx("N", 1326, 766, 2,HFONT, "Red", "Black",,"S")
Return

;}}}

; Insert mode {{{

;3::VimSetMode("Insert")



#If WInActive("ahk_group VimGroup") && (VimMode == "Insert")
SetKeyDelay, -1

vk41 & vk56::Send, {Blind}{vk51}           ;a & v ;q
vk46 & vk5A::Send, {Blind}{vk5A}           ;f & z ;z
;======================= a =======================
vk41 & vk53::Send, {Blind}{vk4C}           ;a & s ;l
vk41 & vk44::Send, {Blind}{vk49}           ;a & d ;i
vk41 & vk46::Send, {Blind}{vk57}           ;a & f ;w
;======================= z =======================
vk5A & vk58::Send, {Blind}{vk4E}           ;z & x ;n
vk5A & vk43::Send, {Blind}{vk50}           ;z & c ;p
vk5A & vk56::Send, {Blind}{vk4A}           ;z & v ;j

;======================= s =======================
vk53 & vk41::Send, {Blind}{vk4F}           ;s & a ;o
vk53 & vk44::Send, {Blind}{vk41}           ;s & d ;a
vk53 & vk46::Send, {Blind}{vk43}           ;s & f ;c
;======================= x =======================
vk58 & vk5A::Send, {Blind}{vk4D}           ;x & z ;m
vk58 & vk43::Send, {Blind}{vk46}           ;x & c ;f
vk58 & vk56::Send, {Blind}{vk47}           ;x & v ;g

;======================= d =======================
vk44 & vk41::Send, {Blind}{vk59}           ;d & a ;y
vk44 & vk53::Send, {Blind}{vk45}           ;d & s ;e
vk44 & vk46::Send, {Blind}{vk48}           ;d & f ;h
;======================= c =======================
vk43 & vk5A::Send, {Blind}{vk52}           ;c & z ;r
vk43 & vk58::Send, {Blind}{vk53}           ;c & x ;s
vk43 & vk56::Send, {Blind}{vk58}           ;c & v ;x

;======================= f =======================
vk46 & vk41::Send, {Blind}{vk55}           ;f & a ;u
vk46 & vk53::Send, {Blind}{vk44}           ;f & s ;d
vk46 & vk44::Send, {Blind}{vk54}           ;f & d ;t
;======================= v =======================
vk56 & vk5A::Send, {Blind}{vk42}           ;v & z ;b
vk56 & vk58::Send, {Blind}{vk4B}           ;v & x ;k
vk56 & vk43::Send, {Blind}{vk56}           ;v & c ;v

#If WInActive("ahk_group VimGroup") && (VimMode == "Insert")

1::
2::
3::
4::
5::
6::
Alt::
a::
s::
d::
f::
z::
x::
c::
v::
N:=0
Loop {
   N++
   KeyWait, %A_ThisHotkey%
   KeyWait, %A_ThisHotkey%, D T0.1
} Until ErrorLevel
   Gosub % IsLabel(L := A_ThisHotkey . "_" . N) ? L : "NotCombs"
Return
NotCombs:
;   MsgBox % "You have exceeded the number of combinations " . A_ThisHotkey . " : " . N
Return

Alt_1:
send, {Enter}
Return
a_2:
send, {'}{'}{Left}
Return
s_2:
send, {|}
Return
d_2:
send, {\}
Return
f_2:
send, {"}{"}{Left}
Return
z_2:
send, {?}
Return
x_2:
send, {/}{/}{Left}
Return
c_2:
send, {`;}
Return
v_2:
send, {:}
Return
1_1:
send, {!}                 ; 1
Return
1_2:
send, {&}                 ; 1
Return
1_3:
send, {<}{>}{Left}                 ; 1
Return

2_1:
send, {@}                 ; 2
Return
2_2:
send, {*}                 ; 2
Return
2_3:
send, {(}{)}{Left}        ; 2
Return

3_1:
send, {#}                 ; 3
Return
3_2:
send, {,}                 ; 3
Return
3_3:
send, {?}                 ; 3
Return

4_1:
send, {$}                 ; 4
Return
4_2:
send, {.}                 ; 4
Return
4_3:
send, {/}                 ; 4
Return

5_1:
send, {`%}                ; 5
Return
5_2:
send, {-}                 ; 5
Return
5_3:
send, {_}                 ; 5
Return

6_1:
send, {^}                 ; 6
Return
6_2:
send, {=}                 ; 6
Return
6_3:
send, {+}                 ; 6
Return

/*
z::send {F7}              ; z
c::send {F9}              ; c
v::send {F10}             ; v
b::send {F11}             ; b
*/


b::send {F8}              ; b
g::Send, {BackSpace}      ; g
w::Send, {Left}           ; w
e::Send, {Right}          ; e
r::Send, ^{BackSpace}     ; r
+r::Send, ^{vk41}{BackSpace}     ; +r -> ^a and BackSpace
Return

; }}} Insert mode

; Normal mode {{{

#If WInActive("ahk_group VimGroup") && (VimMode == "Normal")

f::Send,{Down}                       ; f
d::Send,{Up}                         ; d
e::Send,+{Left}                      ; e
w::Send,{Home}                       ; w
c::Send,+{Right}                     ; c
x::Send,{End}                        ; x
v::Send,+^{Left}                     ; v
b::Send,+^{Right}                    ; b
s::Send, {Left}                      ; s
g::Send, {Right}                     ; g
z::Send,{Del}                        ; z
a::Send,{BackSpace}                  ; a
r::Send,^{BackSpace}                 ; r
Return

; }}} Normal mode

; Numpad mode {{{
#If WInActive("ahk_group VimGroup") and (VimMode="Numpad")

;Space::send {vkD}        ; NumpadEnter
x::send {1}               ; x (Numpad1)
c::send {2}               ; c (Numpad2)
v::send {3}               ; v (Numpad3)
s::send {4}               ; s (Numpad4)
d::send {5}               ; d (Numpad5)
f::send {6}               ; f (Numpad6)
w::send {7}               ; w (Numpad7)
e::send {8}               ; e (Numpad8)
r::send {9}               ; r (Numpad9)
z::send {.}               ; b (NumpadDel)
+z::send {,}               ; b (NumpadDel)

1::send {=}                ; =
2::send {_}                ; _
3::send {Enter}                ; -
4::send {/}                ; 4 (NumpadDiv)
5::send {*}                ; 5 (NumpadMult)
6::send {-}                ; 6 (NumpadSub)
g::send {+}               ; g (NumpadAdd)
a::send {0}               ; a (Numpad0)
b::send {BackSpace}       ; z (BackSpace)
`::Run, calc.exe          ; 1 (Calculator)
LControl::
;LShift & LButton::
send {Space}           ;  (Space)
Return
;}}} Numpad

; Other {{{
/*
; Numpad  {{
;Space::send {vkD}        ; NumpadEnter
sc2D::send {1}               ; x (Numpad1)
sc2E::send {2}               ; c (Numpad2)
sc2F::send {3}               ; v (Numpad3)
sc1F::send {4}               ; s (Numpad4)
sc20::send {5}               ; d (Numpad5)
sc21::send {6}               ; f (Numpad6)
sc11::send {7}               ; w (Numpad7)
sc12::send {8}               ; e (Numpad8)
sc13::send {9}               ; r (Numpad9)
sc30::send {.}               ; b (NumpadDel)

sc5::send {/}                ; 4 (NumpadDiv)
sc6::send {*}                ; 5 (NumpadMult)
sc7::send {-}                ; 6 (NumpadSub)
sc22::send {+}               ; g (NumpadAdd)
sc1E::send {0}               ; a (Numpad0)
sc2::send {=}                ; =
sc3::send {_}                ; _
sc4::send {-}                ; -
sc2C::send {BackSpace}       ; z (BackSpace)
sc29::Run, calc.exe          ; 1 (Calculator)
LControl::
;LShift & LButton::
send {Space}           ;  (Space)
Return
;}} Numpad
*/
/*
; Normal mode {{

#If WInActive("ahk_group VimGroup") && (VimMode == "Normal")

sc21::Send,{Down}                       ; f
sc20::Send,{Up}                         ; d
sc12::Send,+{Left}                      ; e
sc11::Send,{Home}                       ; w
sc2E::Send,+{Right}                     ; c
sc2D::Send,{End}                        ; x
sc2F::Send,+^{Left}                     ; v
sc30::Send,+^{Right}                    ; b
sc1F::Send, {Left}                      ; s
sc22::Send, {Right}                     ; g
sc2C::Send,{Del}                        ; z
sc1E::Send,{BackSpace}                  ; a
sc13::Send,^{BackSpace}                 ; r
Return

; }} Normal mode
*/
/*
sc2::send, {&}               ; 1
sc3::send, {*}               ; 2
sc4::send, {(}               ; 3
sc5::send, {)}               ; 4
sc6::send, {_}               ; 5
sc7::send, {-}               ; 6


sc2C::send {F7}              ; z
sc2D::send {F8}              ; x
sc2E::send {F9}              ; c
sc2F::send {F10}             ; v
sc30::send {F11}             ; b
sc22::Send, {BackSpace}      ; g
sc11::Send, {Left}           ; w
sc12::Send, {Right}          ; e
sc13::Send, ^{BackSpace}     ; r
*/
;}}}
