#IfWinActive ahk_exe GTA5.exe

; clear public lobby by pausing process for 10 seconds
F4::
{
  Process_Suspend("GTA5.exe")
  Sleep, 10000
  Process_Resume("GTA5.exe")
}

#If
