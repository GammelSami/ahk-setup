#IfWinActive ahk_exe javaw.exe

mcThirdPerson := 0

*XButton2::
if (mcThirdPerson == 1){
  Send {F5}{F5}
} else {
  Send {F5}
}
mcThirdPerson := !mcThirdPerson
return

F17::
Send {t}
Sleep 50
Send {Up}
Sleep 50
Send {Enter}
return



F16::
Send, {Ctrl Down}{W Down}
Sleep, 50
Send, {Ctrl Up}
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
