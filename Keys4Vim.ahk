
Process, Priority, , AboveNormal    ; ��� ������ �������� ������������ ������� ������� ������ �������� � ���������� ������ ������



; Auto-execute section {{{
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


vim_verbose=1


VimMode=Insert
Vim_g=0
Vim_n=0
VimLineCopy=0


Return
; }}}

; Basic Settings, HotKeys, Functions {{{
; Settings

#UseHook On ; Make it a bit slow, but can avoid infinitude loop
            ; Same as "$" for each hotkey
#InstallKeybdHook ; For checking key history
                  ; Use ~500kB memory?

#HotkeyInterval 2000 ; Hotkey inteval (default 2000 milliseconds).
#MaxHotkeysPerInterval 70 ; Max hotkeys perinterval (default 50).


~` & F2::ExitApp
Return

+Space::
;^LButton::
Suspend
Return


#Include, d:\KEYBOARD\VimKee4\AddonsForKeys4Vim.ahk


; Vim mode {{{
#IfWInActive, ahk_group VimGroup

; Reset Modes {{{

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

; {{ Toogle mode

#If WInActive("ahk_group VimGroup")  && (VimMode =="Insert")

q::VimSetMode("Numpad")  ;q
;sc10::VimSetMode("Numpad")  ;q
;sc14::VimSetMode("Normal")  ;t
t::VimSetMode("Normal")  ;t
Return

#If WInActive("ahk_group VimGroup") && (VimMode=="Normal")

t::VimSetMode("Insert")  ;t
;sc14::VimSetMode("Insert")  ;t
;sc10::VimSetMode("Numpad")  ;q
q::VimSetMode("Numpad")  ;q
Return

#If WInActive("ahk_group VimGroup") && (VimMode=="Numpad")

q::VimSetMode("Insert")  ; q
;sc10::VimSetMode("Insert")  ; q
;sc14::VimSetMode("Normal")  ; t
t::VimSetMode("Normal")  ; t
Return

;}}

; 4keys {{{{
; Insert mode {{{

;3::VimSetMode("Insert")

#If WInActive("ahk_group VimGroup") && (VimMode == "Insert")

;~sc1E::  ; a
~a::  ; a
Input, UserInput, I C T0.7 *,,aa,as,ad,af,��,��,��,��,��,��,s,d,f,�,�

if UserInput = as
    Send, {backspace 1}n
else if UserInput = ��
    Send, {backspace 1}�
else if UserInput = ad
    Send, {backspace 1}p
else if UserInput = ��
    Send, {backspace 1}�
else if UserInput = af
    Send, {backspace 1}j
else if UserInput = ��
    Send, {backspace 1}�
else if UserInput = a
    Send, {backspace 1}{Space}
else if UserInput = �
    Send, {backspace 1}{Space}
else if UserInput = s
    Send, {backspace 1}l
else if UserInput = �
    Send, {backspace 1}�
else if UserInput = d
    Send, {backspace 1}i
else if UserInput = �
    Send, {backspace 1}�
else if UserInput = f
    Send, {backspace 1}w
else if UserInput = aa       ;ENG
    Send, {backspace 1}.
else if UserInput = ��
    Send, {backspace 1}.
else if UserInput = ��
    Send, {backspace 1}�
else if UserInput = ��
    Send, {backspace 1}�
return


;~+sc1E::  ; a
~+a::  ; a
Input, UserInput, I C T0.7 *,,AS,AD,AF,AA,��,��,��,��,��,��,��,S,D,F,�,�,�
SetKeyDelay, -1

if UserInput = AS
    Send, {backspace 1}N
else if UserInput = ��
    Send, {backspace 1}�
else if UserInput = AD
    Send, {backspace 1}P
else if UserInput = ��
    Send, {backspace 1}�
else if UserInput = AF
    Send, {backspace 1}J
else if UserInput = ��
    Send, {backspace 1}�
else if UserInput = S
    Send, {backspace 1}L
else if UserInput = �
    Send, {backspace 1}�
else if UserInput = D
    Send, {backspace 1}I
else if UserInput = �
    Send, {backspace 1}�
else if UserInput = F
    Send, {backspace 1}W
else if UserInput = �      ; RU
    Send, {backspace 1}�
else if UserInput = A      ; ENG
    Send, {backspace 1}{Space}
else if UserInput = �
    Send, {backspace 1}{Space}
else if UserInput = AA
    Send, {backspace 1}.
else if UserInput = ��
    Send, {backspace 1}.
else if UserInput = ��
    Send, {backspace 1}�
else if UserInput = ��
    Send, {backspace 1}�
return

/*
~sc1E & sc1F ::send {backspace}{sc26} ; as to l
~sc1E & sc20::send {backspace}{sc17} ; ad to i
~sc1E & sc21::send {backspace}{sc11}  ; af to w
*/

;~sc1F::   ;s
~s::   ;s
Input, UserInput, I C T0.7 *,,ss,sa,sd,sf,��,��,��,��,��,a,d,f,�,�,�
SetKeyDelay, -1
if UserInput = sa
    Send, {backspace 1}m
else if UserInput = ��
    Send, {backspace 1}�
else if UserInput = sd
    Send, {backspace 1}f
else if UserInput = ��
    Send, {backspace 1}�
else if UserInput = sf
    Send, {backspace 1}g
else if UserInput = ��
    Send, {backspace 1}�
else if UserInput = a
    Send, {backspace 1}o         ;RU
else if UserInput = �
    Send, {backspace 1}�
else if UserInput = ss
    Send, {backspace 1}a         ; ENG
else if UserInput = ��
    Send, {backspace 1}�         ; RU
else if UserInput = d
    Send, {backspace 1}h
else if UserInput = �
    Send, {backspace 1}�         ;RU
else if UserInput = f
    Send, {backspace 1}c         ;ENG
else if UserInput = �            ;RU
    Send, {backspace 1}�
else if UserInput = ��
    Send, {backspace 1}�         ;RU
else if UserInput = ��
    Send, {backspace 1}�
return


;~+sc1F::       ;s
~+s::           ;s

Input, UserInput, I C T0.7 *,,SS,SA,SD,SF,��,��,��,��,��,A,D,F,�,�,�
SetKeyDelay, -1
if UserInput = SA
    Send, {backspace 1}M
else if UserInput = ��
    Send, {backspace 1}�
else if UserInput = SD
    Send, {backspace 1}F
else if UserInput = ��
    Send, {backspace 1}�
else if UserInput = SF
    Send, {backspace 1}G
else if UserInput = ��
    Send, {backspace 1}�
else if UserInput = A
    Send, {backspace 1}O         ;RU
else if UserInput = �
    Send, {backspace 1}�
else if UserInput = SS
    Send, {backspace 1}A         ; ENG
else if UserInput = ��
    Send, {backspace 1}�         ; RU
else if UserInput = D
    Send, {backspace 1}H
else if UserInput = �
    Send, {backspace 1}�         ;RU
else if UserInput = F
    Send, {backspace 1}C         ;ENG
else if UserInput = �            ;ru
    Send, {backspace 1}�
else if UserInput = ��
    Send, {backspace 1}�         ;RU
else if UserInput = ��
    Send, {backspace 1}�
return

/*
~sc1F & sc1E::send {backspace}�  ; sa to o
~sc1F & sc20::send {backspace}�  ; sd to h
~sc1F & sc21::send {backspace}�  ; sf to c
*/


;~sc20::  ; d
~d::  ; d
Input, UserInput, I C T0.7 *,,dd,da,ds,df,��,��,��,��,��,a,f,�,�,�
SetKeyDelay, -1
if UserInput = da
    Send, {backspace 1}r
else if UserInput = ��
    Send, {backspace 1}�         ;RU
else if UserInput = ds
    Send, {backspace 1}s
else if UserInput = ��
    Send, {backspace 1}�         ;RU
else if UserInput = df
    Send, {backspace 1}x
else if UserInput = ��
    Send, {backspace 1}�
else if UserInput = a
    Send, {backspace 1}y
else if UserInput = �
    Send, {backspace 1}�
else if UserInput = s
    Send, {backspace 1}t
else if UserInput = �
    Send, {backspace 1}�         ;RU
else if UserInput = dd
    Send, {backspace 1}e
else if UserInput = ��
    Send, {backspace 1}�         ;RU
else if UserInput = f
    Send, {backspace 1}v
else if UserInput = �
    Send, {backspace 1}�         ;RU
else if UserInput = ��
    Send, {backspace 1}�
return

;~+sc20::  ; D
~+d::  ; D
Input, UserInput, I C T0.7 *,,DD,DA,DS,DF,��,��,��,��,��,A,S,F,�,�,�,�
SetKeyDelay, -1
if UserInput = DA
    Send, {backspace 1}R
else if UserInput = ��
    Send, {backspace 1}�      ;RU
else if UserInput = DS
    Send, {backspace 1}S
else if UserInput = ��
    Send, {backspace 1}�      ;RU
else if UserInput = DF
    Send, {backspace 1}X
else if UserInput = ��
    Send, {backspace 1}�
else if UserInput = A
    Send, {backspace 1}Y
else if UserInput = �
    Send, {backspace 1}�
else if UserInput = S
    Send, {backspace 1}T
else if UserInput = �
    Send, {backspace 1}�      ;RU
else if UserInput = DD
    Send, {backspace 1}E
else if UserInput = ��
    Send, {backspace 1}�      ;RU
else if UserInput = F
    Send, {backspace 1}V
else if UserInput = �
    Send, {backspace 1}�      ;RU
else if UserInput = ��
    Send, {backspace 1}�
return

/*
~sc20 & sc1E::send {backspace}{sc15}  ; da to y
~sc20 & sc1F::send {backspace}{sc14}  ; ds to t
~sc20 & sc21::send {backspace}{sc2F}  ; df to v
*/

;~sc21::  ; f
~f::  ; f
Input, UserInput, I T0.7  *,,ff,fa,fs,fd,��,��,��,��,��,��,a,s,d,�,�,�
SetKeyDelay, -1
if UserInput = fa
    Send, {backspace 1}b
else if UserInput = ��        ; fa to b
    Send, {backspace 1}�
else if UserInput = fs
    Send, {backspace 1}k
else if UserInput = ��        ; fs to k
    Send, {backspace 1}�
else if UserInput = fd
    Send, {backspace 1}z
else if UserInput = ��  ; fd to z
    Send, {backspace 1}�
else if UserInput = a
    Send, {backspace 1}u
else if UserInput = �  ; fa to u
    Send, {backspace 1}�
else if UserInput = s
    Send, {backspace 1}d
else if UserInput = �  ; fs to d
    Send, {backspace 1}�
else if UserInput = d
    Send, {backspace 1}q
else if UserInput = �  ; fd to q
    Send, {backspace 1}�
else if UserInput = ff
    Send, {backspace 1},
else if UserInput = ��      ; RU
    Send, {backspace 1},
else if UserInput = ��
    Send, {backspace 1}�
else if UserInput = ��
    Send, {backspace 1}�
return


;~+sc21::  ; F
~+f::  ; F
Input, UserInput, I T0.7  *,,FA,FS,FD,��,��,��,��,��,A,S,D,F,�,�,�,�
SetKeyDelay, -1
if UserInput = FA
    Send, {backspace 1}B
else if UserInput = ��        ; fa to b
    Send, {backspace 1}�
else if UserInput = FS        ; fs to k
    Send, {backspace 1}K
else if UserInput = ��        ;RU
    Send, {backspace 1}�
else if UserInput = FD        ; fd to z
    Send, {backspace 1}Z
else if UserInput = ��        ;RU
    Send, {backspace 1}�
else if UserInput = A
    Send, {backspace 1}U
else if UserInput = �         ; fa to u
    Send, {backspace 1}�
else if UserInput = S
    Send, {backspace 1}D
else if UserInput = �        ; fs to d
    Send, {backspace 1}�
else if UserInput = D        ; fd to q
    Send, {backspace 1}Q
else if UserInput = �        ;RU
    Send, {backspace 1}�
else if UserInput = F
    Send, {backspace 1},
else if UserInput = �        ; RU
    Send, {backspace 1},
else if UserInput = ��
    Send, {backspace 1}
else if UserInput = ��
    Send, {backspace 1}�
return

/*
~sc21 & sc1E::send {backspace}{sc16}  ; fa to u
~sc21 & sc1F::send {backspace}{sc20}  ; fs to d
~sc21 & sc20::send {backspace}{sc10}  ; fd to q
Return
*/
; (else if UserInput = )(.{1,2})(.*)\r(    Send, {backspace 1})(.{1,2})(.*)


#If WInActive("ahk_group VimGroup") && (VimMode == "Insert")

1::
2::
3::
4::
5::
6::
N:=0
Loop {
   N++
   KeyWait, %A_ThisHotkey%
   KeyWait, %A_ThisHotkey%, D T0.3
} Until ErrorLevel
   Gosub % IsLabel(L := A_ThisHotkey . "_" . N) ? L : "NotCombs"
Return
NotCombs:
   MsgBox % "You have exceeded the number of combinations " . A_ThisHotkey . " : " . N
Return

1_1:
send, {!}                 ; 1
Return
1_2:
send, {&}                 ; 1
Return
1_3:
send, {<}                 ; 1
Return

2_1:
send, {@}                 ; 2
Return
2_2:
send, {*}                 ; 2
Return
2_3:
send, {>}                 ; 2
Return

3_1:
send, {#}                 ; 3
Return
3_2:
send, {(}                 ; 3
Return
3_3:
send, {?}                 ; 3
Return

4_1:
send, {$}                 ; 4
Return
4_2:
send, {)}                 ; 4
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


z::send {F7}              ; z
x::send {F8}              ; x
c::send {F9}              ; c
v::send {F10}             ; v
b::send {F11}             ; b
g::Send, {BackSpace}      ; g
w::Send, {Left}           ; w
e::Send, {Right}          ; e
r::Send, ^{BackSpace}     ; r

Return

; }} Insert mode
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

; Vim comamnd mode {{{


#If WInActive("ahk_group VimGroup") and (VimMode="Numpad")

; Numpad  {{
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
b::send {.}               ; b (NumpadDel)

1::send {=}                ; =
2::send {_}                ; _
3::send {-}                ; -
4::send {/}                ; 4 (NumpadDiv)
5::send {*}                ; 5 (NumpadMult)
6::send {-}                ; 6 (NumpadSub)
g::send {+}               ; g (NumpadAdd)
a::send {0}               ; a (Numpad0)
z::send {BackSpace}       ; z (BackSpace)
`::Run, calc.exe          ; 1 (Calculator)
LControl::
;LShift & LButton::
send {Space}           ;  (Space)
Return
;}} Numpad


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
; Normal mode {{{

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

; }}} Normal mode
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