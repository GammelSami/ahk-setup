ps_zoomToPercentage(p=10) {
  BlockInput, On
  Mousegetpos, mx, my
  Mousemove, 70, 1398, 0
  Send, {Click, 2}%p%{Enter}
  Mousemove, mx, my, 0
  BlockInput, Off
}
