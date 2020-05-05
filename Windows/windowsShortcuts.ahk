; Open Windows Terminal (Alt + T)
!t::win_applicationSwitcher("Terminal")

;;;;;;;;;; G-Keys ;;;;;;;;;;

; (G6) Instant Application Switcher Windows Explorer
F18::win_applicationSwitcher("Explorer")

; (Break/Pause Key) Eyedropper/Colorpicker
Pause::win_eyedropper("Pause")

; (Ctrl + Shift + V) "Paste & Go" Shortcut in Browsers and other Software
; if WinActive("ahk_exe firefox.exe") or WinActive("ahk_exe chrome.exe") or WinActive("ahk_exe explorer.exe") or WinActive("ahk_exe Discord.exe")


#IfWinActive ahk_exe firefox.exe || ahk_exe chrome.exe || ahk_exe explorer.exe || ahk_exe Discord.exe || ahk_exe WhatsApp.exe
  ^+v:: Send, ^v{Enter}
