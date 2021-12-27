ps_zoomToPercentage(p=10) {
  BlockInput, On
  CoordMode, Mouse, Screen

  Mousegetpos, mx, my
  Mousemove, 60, 1390, 0
  Send, {Click, 2}
  Send, {+Home}
  Sleep, 100

  if (A_CaretY != "")
  {
    Send, %p%{Enter}
  }

  Mousemove, mx, my, 0

  CoordMode, Mouse
  BlockInput, Off
}
