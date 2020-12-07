#IfWinActive ahk_exe Resolve.exe

; ripple delete on mouse 5
XButton2::Del
; fast forward on mouse 4
XButton1::+L

; focus left panel (Media Pool)
F13::
{
  MouseGetPos, mx, my
  Click, Middle, 20, 160
  MouseMove, mx, my
} return

#If
