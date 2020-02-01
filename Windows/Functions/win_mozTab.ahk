; eigentlich gibt es hier ein krass kompliziertes script in 500 verschiedenen versionen,
; aber das hab ich nicht zum laufen gekriegt:
; https://www.autohotkey.com/boards/viewtopic.php?f=6&t=26947&p=139114

win_mozTab(TabNum := 1) {
  WinActivate ahk_class MozillaWindowClass
  sleep 10
  Send ^%TabNum%
}
