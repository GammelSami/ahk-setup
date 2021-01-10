; This is used to call functions via elgato stream deck directly by parameters
; (using "BarRader Advanced Launcher"-Plugin)

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance
#WinActivateForce

; include functions
#Include %A_ScriptDir%\includeFunctions.ahk

try {

  param = %2%
  %1%(param) ; you cannot use %-variables as function arguments, and if i write 2 ahk means the integer 2
  ExitApp

} catch e {
  ToolTip, e
  ExitApp
}

; ---------- Helper Snippets ---------- ;
; would not be neccesary if the stream deck would have an AHK action
; and if i run these different actions within a multication it does not work sometimes...

helper(param) {
  Switch param
  {
  Case "pp_presetCropZoomAndEdit":
    pp_preset("CropZoom")
    Send, +5 ; focus Effekteinstellungen
    win_clickImage("effectLabel_Zuschneiden.png")
    Return
  }
}
