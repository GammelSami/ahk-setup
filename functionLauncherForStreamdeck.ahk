; This is used to call functions via elgato stream deck directly by parameters
; (using "BarRader Advanced Launcher"-Plugin)

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance
#WinActivateForce

; include includer to include all functions that needs to be included
#Include %A_ScriptDir%\includer.ahk


try {

  param = %2%
  %1%((param)) ; you cannot use %-variables as function arguments, and if i write 2 ahk means "2"
  ExitApp

} catch e {
  ToolTip e
  ExitApp
}
