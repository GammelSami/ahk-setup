#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance
#WinActivateForce

; include includer to include all functions that needs to be included
#Include %A_ScriptDir%\includer.ahk

; include shortcut assignments
#Include %A_ScriptDir%\Windows\windowsShortcuts.ahk
#Include %A_ScriptDir%\PremierePro\premiereProShortcuts.ahk