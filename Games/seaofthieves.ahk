#IfWinActive ahk_exe SoTGame.exe

c::x

; sprinten
*LShift::
  While GetKeyState("LShift", "P")
  {
    Send, {LShift}
    Sleep, 50
  }
Return

#If
