; Adobe Programme erkennen Maustaste 4 & 5 nicht, darum belege ich sie mit anderen Tasten.
; Jaja, ich weiß. Die Datei heißt "premiereProShortcuts" und nicht "creativeCloudShortcuts".
#IfWinActive ahk_exe Adobe Audition.exe ; Audition
XButton2::Del
XButton1::F5
#If


#IfWinActive ahk_class AE_CApplication_17.0 ; After Effects
XButton2::Del
XButton1::F5
#If


#IfWinActive ahk_exe Adobe Premiere Pro.exe ; Premiere Pro

XButton2::Del
XButton1::Send, LLLL

; fast shuttle with arrow keys
^Left::pp_arrowFastShuttle("Left")
^Right::pp_arrowFastShuttle("Right")

; G-Keys

; focus effect-window's searchbox
F13::
{
  Send, +7 ; default Premiere shortcut: "Focus Effects Window"
  Send, +f ; default Premiere shortcut: "Focus Effects Windows Searchbox and Select the Content"
} return

; Lock Horizontal Mouse Axys for better Bézier keyframe handling
F14::win_lockMouseY(unlockKey:="F14")

; click on volume value in effects panel
F16::
{
  Send, +1 ; focus Timeline
  Send, +5 ; focus Effekteinstellungen
  Send, {Tab}
  Send, {Tab}
  Send, {Tab}
} return

; toggle "Bewegung" and "Deckkraft" in "Effekteinstellungen"
+F17::
{
  Send, +5 ; focus Effekteinstellungen
  win_clickImage("effectLabel_Deckkraft.png", -30)
  win_clickImage("effectLabel_Bewegung.png", -30)
} return

; Clicks on "Bewegung" in the "Effekteinstellungen" window
F17::
{
  Send, +5
  Sleep, 100
  win_clickImage("effectLabel_Bewegung.png")
} return

; F-Keys

F1::pp_instantEffectsPropertyChange("F1", "PosX")
F2::pp_instantEffectsPropertyChange("F2", "PosY")
F3::pp_instantEffectsPropertyChange("F3", "Scale")
F4::pp_instantEffectsPropertyChange("F4", "Rotation")
F5::pp_instantEffectsPropertyChange("F5", "Opacity")

#If
