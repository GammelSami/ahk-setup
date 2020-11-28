#IfWinActive ahk_exe Resolve.exe

; focus left panel (Media Pool)
F13::
{
  MouseGetPos, mx, my
  Click, Middle, 20, 160
  MouseMove, mx, my
} return
