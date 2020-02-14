; Open Windows Terminal (Alt + T)
!t::win_applicationSwitcher("Terminal")

;;;;;;;;;; G-Keys ;;;;;;;;;;

; (G6) Instant Application Switcher Windows Explorer
F18::win_applicationSwitcher("Explorer")

; (Break/Pause Key) Eyedropper/Colorpicker
Pause::win_eyedropper("Pause")

; (Ctrl + Shift + V) Paste and Go Shortcut in Browsers
; Firefox
#IfWinActive ahk_class MozillaWindowClass
^+v:: Send, ^v{Enter}
#IfWinActive
; Chrome
#IfWinActive ahk_exe chrome.exe
  ^+v:: Send, ^v{Enter}
#IfWinActive
