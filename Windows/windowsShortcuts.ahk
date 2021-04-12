; Open Windows Terminal (Alt + T)
!t::win_applicationSwitcher("Terminal")

;long dash – with altgr and -
<^>!-::Send, {U+2013}
;longer dash with shift, altgr and -
+<^>!-::Send, {U+2014}
;hellip with altgr and .
<^>!.::Send, {U+2026}
;double dot with shift and numpad period
NumpadDel::Send, {U+003A}
;"almost equal to" with shift, altgr and +
+<^>!+::Send, {U+2248}

;;;;;;;;;; G-Keys ;;;;;;;;;;

; (G6) Instant Application Switcher Windows Explorer
F18::win_applicationSwitcher("Explorer")

; (Break/Pause Key) Eyedropper/Colorpicker
Pause::win_eyedropper("Pause")

; Fast Open 1Password
#1::Run, 1Password.exe

; (Ctrl + Shift + V) "Paste & Go" Shortcut in Browsers and other Software
#If WinActive("ahk_exe firefox.exe") or WinActive("ahk_exe chrome.exe") or WinActive("ahk_exe javaw.exe") or WinActive("ahk_exe Discord.exe") or WinActive("ahk_class CabinetWClass")
^+v::
    Send, ^v
    Sleep, 50
    Send, {Enter}
    return
#If

; generate password / e-mail alias
!Insert::
{
  str := RandStr( 7,1,0 )
  Send, %str%
}
