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
} return

; (G2) Lock Horizontal Mouse Axys for better Bézier keyframe handling
F14::win_lockMouseY(unlockKey:="F14")

; (G3) easy ease in and out
F15::pp_easyEase()

; (G4) toggle "Bewegung" and "Deckkraft" in "Effekteinstellungen"
F16::
{
  Send, +5 ; focus Effekteinstellungen
  win_clickImage("effectLabel_Deckkraft.png", -30)
  win_clickImage("effectLabel_Bewegung.png", -30)
} return

; (G5) Clicks on "Bewegung" in the "Effekteinstellungen" window
F17::
{
  Send, +5
  win_clickImage("effectLabel_Bewegung.png")
} return

; (Corsair User Icon Key) pp_instantScale
F19::pp_instantScale("F19")

#If
