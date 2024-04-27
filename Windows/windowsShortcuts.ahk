; Open Windows Terminal (Alt + T)
!t::win_applicationSwitcher("Terminal")

; Open GOG
#g::win_applicationSwitcher("GogGalaxy")

; Open Music Player
#s::win_applicationSwitcher("YouTube Music")

;;;;;;;;;; Text Stuff ;;;;;;;;;;

;german quotes with shift, altgr and 2
+<^>!2::Send, {U+201E}{U+201C}{Left}
;long dash – with altgr and -
<^>!-::Send, {U+2013}
;longer dash with shift, altgr and -
+<^>!-::Send, {U+2014}
;hellip with altgr and .
<^>!.::Send, {U+2026}
;× with altgr and x
<^>!x::Send, {U+00D7}
;shift + numpad period = colon
NumpadDel::Send, {U+003A}
;ctrl + numpad period = dot
^NumpadDot::Send, {U+002E}
;"almost equal to" with shift, altgr and +
+<^>!+::Send, {U+2248}

;;;;;;;;;; G-Keys ;;;;;;;;;;

; (G4) insert date
F16::Send, %A_YYYY%-%A_MM%-%A_DD%

; (G6) Instant Application Switcher Windows Explorer
F18::win_applicationSwitcher("Explorer")

; (Break/Pause Key) Eyedropper/Colorpicker
Pause::win_eyedropper("Pause")

; Fast Open 1Password
#b::win_applicationSwitcher("Bitwarden")

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
