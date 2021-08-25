#IfWinActive ahk_exe javaw.exe

F17::
Send {t}
Sleep 50
Send {Up}
Sleep 50
Send {Enter}
return



F16::
Send, {Ctrl Down}{W Down}
while GetKeyState("F16", "P")
{
    Send {space down}
    sleep 50
    Send {space Up}
    sleep 50
}
Send, {Ctrl Up}{W Up}
return

#If
