; Open Windows Terminal (Alt + T)
!t::win_applicationSwitcher("Terminal")

;;;;;;;;;; G-Keys ;;;;;;;;;;

; (G6) Instant Application Switcher Windows Explorer
F18::win_applicationSwitcher("Explorer")

; (Break/Pause Key) Eyedropper/Colorpicker
Pause::win_eyedropper("Pause")

; (Ctrl + Shift + V) "Paste & Go" Shortcut in Browsers and other Software
#If WinActive("ahk_exe firefox.exe") or WinActive("ahk_exe chrome.exe")  or WinActive("ahk_exe javaw.exe") or WinActive("ahk_exe Discord.exe") or WinActive("ahk_class CabinetWClass")
^+v::
    Send, ^v
    Sleep, 50
    Send, {Enter}
    return
#If
