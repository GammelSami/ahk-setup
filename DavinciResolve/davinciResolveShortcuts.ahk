#IfWinActive ahk_exe Resolve.exe

; ripple delete on mouse 5
XButton2::Del

; focus left panel (Media Pool)
F13::
{
  MouseGetPos, mx, my
  Click, Middle, 20, 160
  MouseMove, mx, my
} return

#If
