pp_instantEffectsPropertyChange(unlockKey="Esc", property="") {

  ; block mouse input and backup mouse position
  BlockInput, On
  BlockInput, MouseMove
  CoordMode, Mouse, Screen
  CoordMode, Caret, Screen
  MouseGetPos, mx, my

  ; reset tabulator index by (re)focusing a panel
  Send, {MButton}
  sleep, 10

  ; focus effects window
  Send, +5
  sleep, 10

  ; focus property using tabulator x times
  Switch property
  {
    Case "PosX":
      loops = 1
    Case "PosY":
      loops = 2
    Case "Scale":
      loops = 3
    Case "Rotation":
      loops = 5
    Case "Opacity":
      loops = 9
    Default:
      loops = %property%
  }

  Loop, %loops%
  {
    Send, {Tab}
    sleep, 1
  }

  ; save property coords
  sleep, 30
  vx = %A_CaretX%
  vy = %A_CaretY%

  ; close text input field
  Send, {Esc}
    sleep, 10

  ; press left mouse down at property coords
  MouseMove, %vx%, %vy%, 0
    sleep, 10
  Click, %vx%, %vy%, down

  ; enable mouse input for changing property value
  BlockInput, Off
  BlockInput, MouseMoveOff
  Tooltip, Instant %property%

  ; if unlockKey is pressed (keyup event also counts)
  Keywait, %unlockKey%
  Tooltip,

  ; release left mouse
  Click, up, left
    sleep, 10

  ; restore mouse position from previous backup
  MouseMove, %mx%, %my%
}
