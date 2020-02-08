; Open Windows Terminal (Alt + T)
!t::win_applicationSwitcher("Terminal")

;;;;;;;;;; G-Keys ;;;;;;;;;;

; (G6) Instant Application Switcher Windows Explorer
F18::win_applicationSwitcher("Explorer")

; (Break/Pause Key) Eyedropper/Colorpicker
Pause::win_eyedropper("Pause")


;;;;;;;;;; Google Chrome ;;;;;;;;;;

; (Ctrl + Shift + V) Paste and Go Shortcut
; Firefox has an extension for this: https://addons.mozilla.org/de/firefox/addon/paste-and-go-key
#IfWinActive ahk_exe chrome.exe
  ^+v:: Send, ^v{Enter}
#IfWinActive
