; toggle "Bewegung" and "Deckkraft" in "Effekteinstellungen"
pp_toggleDefaultVFX() {
  Send, +5 ; focus Effekteinstellungen
  win_clickImage("effectLabel_Deckkraft.png", -30)
  win_clickImage("effectLabel_Bewegung.png", -30)
}
