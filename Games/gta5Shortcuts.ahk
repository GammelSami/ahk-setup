#IfWinActive ahk_exe GTA5_Enhanced.exe

; clear public lobby by pausing process for 10 seconds
+F4::
{
  Process_Suspend("GTA5_Enhanced.exe")
  Sleep, 10000
  Process_Resume("GTA5_Enhanced.exe")
}

#If
