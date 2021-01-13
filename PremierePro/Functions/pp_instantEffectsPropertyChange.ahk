F15::pp_instantEffectsPropertyChange("F15", 1, 1) ; Motion, Scale, Amount
~F15 & Up::pp_instantEffectsPropertyChange("F15", 1, 1, 1) ; Motion, Scale, Amount
~F15 & Down::pp_instantEffectsPropertyChange("F15", 1, 1, -1) ; Motion, Scale, Amount

pp_instantEffectsPropertyChange(unlockKey="Esc", effect=-1, property=-1, amount=0) {

  if (effect == -1 or property == -1) {
    ToolTip, "no effect or property given"
    Sleep, 2000
    ToolTip,
    goto, end
  }

  if (amount != 0) { ; if amount given, use arrow keys
    if (GetKeyState("Shift", "P")) {
      amount := amount*30
    }
    Run, curl ""localhost:8081/instantPropertyChange?effect=%effect%&property=%property%&amount=%amount%"",,hide
    goto, end
  }

  MouseGetPos, centerX, centerY

  While (GetKeyState(unlockKey, "P")) {
    MouseGetPos, x1, y1
    Sleep, 35 ; lower the updates per second by INCREASING this value if you experience bigger input lag on your machine
    MouseGetPos, x2, y2
    amount := (y1-y2) + (x2-x1) ; same formula adobe uses
    if (amount != 0) {
      Run, curl ""localhost:8081/instantPropertyChange?effect=%effect%&property=%property%&amount=%amount%"",,hide
    }

    ; reset mouse position if moved too far
    if (x2-centerX > 100 or x2-centerX < -100 or y2-centerY > 100 or y2-centerY < -100) {
      MouseMove, centerX, centerY, 0
    }
  }
  end:
}



; pp_instantEffectsPropertyChange(unlockKey="Esc", property="") {
;
;   ; block mouse input and backup mouse position
;   BlockInput, On
;   BlockInput, MouseMove
;   CoordMode, Mouse, Screen
;   CoordMode, Caret, Screen
;   MouseGetPos, mx, my
;
;   ; reset tabulator index by (re)focusing a panel
;   Send, {MButton}
;   sleep, 10
;
;   ; focus effects window
;   Send, +5
;   sleep, 10
;
;   ; focus property using tabulator x times
;   Switch property
;   {
;     Case "PosX":
;       loops = 1
;     Case "PosY":
;       loops = 2
;     Case "Scale":
;       loops = 3
;     Case "Rotation":
;       loops = 5
;     Case "Opacity":
;       loops = 9
;     Default:
;       loops = %property%
;   }
;
;   Loop, %loops%
;   {
;     Send, {Tab}
;     sleep, 1
;   }
;
;   ; save property coords
;   sleep, 30
;   vx = %A_CaretX%
;   vy = %A_CaretY%
;
;   ; close text input field
;   Send, {Esc}
;     sleep, 10
;
;   ; press left mouse down at property coords
;   MouseMove, %vx%, %vy%, 0
;     sleep, 10
;   Click, %vx%, %vy%, down
;
;   ; enable mouse input for changing property value
;   BlockInput, Off
;   BlockInput, MouseMoveOff
;   Tooltip, Instant %property%
;
;   ; if unlockKey is pressed (keyup event also counts)
;   Keywait, %unlockKey%
;   Tooltip,
;
;   ; release left mouse
;   Click, up, left
;     sleep, 10
;
;   ; restore mouse position from previous backup
;   MouseMove, %mx%, %my%
; }
