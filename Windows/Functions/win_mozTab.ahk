; eigentlich gibt es hier ein krass kompliziertes script in 500 verschiedenen versionen,
; aber das hab ich nicht zum laufen gekriegt:
; https://www.autohotkey.com/boards/viewtopic.php?f=6&t=26947&p=139114

win_mozTab(TabNum := 1) {
  IfWinNotExist, ahk_class MozillaWindowClass
    Run, C:\Program Files\Mozilla Firefox\firefox.exe
  WinActivate ahk_class MozillaWindowClass
  WinWaitActive ahk_class MozillaWindowClass
  Send ^%TabNum%
}
