pp_instantScale(unlockKey="Esc") {
  Send, +4
  sleep, 10
  Send, +5
  Send, {Tab}
  sleep, 10
  Send, {Tab}
  sleep, 10
  Send, {Tab}
  sleep, 10
  vx = %A_CaretX%
  vy = %A_CaretY%
  Send, {Enter}
  BlockInput, On
  sleep, 10
  MouseGetPos, mx, my
  sleep, 10
  MouseMove, %vx%, %vy%, 0
  Click, %vx%, %vy%, down
  BlockInput, Off
  Keywait, %unlockKey%
  Click, up, left
  sleep, 10
  MouseMove, %mx%, %my%
}
