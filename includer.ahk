; include librarys
#Include %A_ScriptDir%\Lib\tooltipStyling.ahk

; functions that are only useful for Premiere
#Include %A_ScriptDir%\PremierePro\Functions\pp_preset.ahk
#Include %A_ScriptDir%\PremierePro\Functions\pp_easyEase.ahk
#Include %A_ScriptDir%\PremierePro\Functions\pp_reverseClips.ahk
#Include %A_ScriptDir%\PremierePro\Functions\pp_toggleDefaultVFX.ahk
#Include %A_ScriptDir%\PremierePro\Functions\pp_instantEffectsPropertyChange.ahk
#Include %A_ScriptDir%\PremierePro\Functions\pp_deleteNextMarker.ahk

; functions that could be needed system-wide
#Include %A_ScriptDir%\Windows\Functions\win_applicationSwitcher.ahk
#Include %A_ScriptDir%\Windows\Functions\win_clickImage.ahk
#Include %A_ScriptDir%\Windows\Functions\win_eyedropper.ahk
#Include %A_ScriptDir%\Windows\Functions\win_lockMouseY.ahk
#Include %A_ScriptDir%\Windows\Functions\win_mozTab.ahk

; functions for davinci resolve
#Include %A_ScriptDir%\DavinciResolve\davinciResolveShortcuts.ahk
