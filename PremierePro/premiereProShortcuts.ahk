; Adobe Programme erkennen Maustaste 4 & 5 nicht, darum belege ich sie mit anderen Tasten.
; Jaja, ich weiß. Die Datei heißt "premiereProShortcuts" und nicht "creativeCloudShortcuts".
#IfWinActive ahk_class audition13 ; Audition
XButton2::Del
XButton1::F5
#If


#IfWinActive ahk_class AE_CApplication_17.0 ; After Effects
XButton2::Del
XButton1::F5
#If


#IfWinActive ahk_exe Adobe Premiere Pro.exe ; Premiere Pro

XButton2::Del
XButton1::F5

; (G1) focus effect-window's searchbox
F13::
{
  Send, +7 ; default Premiere shortcut: "Focus Effects Window"
  Send, +f ; default Premiere shortcut: "Focus Effects Windows Searchbox and Select the Content"
}

; (G2) Reverse selected Clips
F14::pp_reverseClips()

; (G3) Lock Horizontal Mouse Axys for better Bézier keyframe handling
F15::win_lockMouseY(unlockKey:="F15")

; (G4) easy ease in and out
F16::pp_easyEase()

; (G5) Clicks on "Bewegung" in the "Effekteinstellungen" window
F17::
{
  Send, +5
  win_clickImage("transformButton_Bewegung.png")
}

return

#If
