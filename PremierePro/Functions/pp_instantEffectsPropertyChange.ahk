pp_instantEffectsPropertyChange(unlockKey="Esc", property="") {

  BlockInput, On
  BlockInput, MouseMove

  Send, +5 ; focus effect controls panel
  Sleep, 50

  ; init variables
  filename := ""
  offset := 0
  Switch property
  {
    Case "PosX":
      filename = effectLabel_Position.png
    Case "PosY":
      filename = effectLabel_Position.png
      offset = 50
    Case "Scale":
      filename = effectLabel_Skalieren.png
    Case "Rotation":
      filename = effectLabel_Drehung.png
    Case "Opacity":
      filename = effectLabel_Deckkraft.png
    Default:
      ToolTip, Wrong property given
      Sleep, 1000
      ToolTip,
      Goto, end
  }

  ; ImageSearch
  coordMode, pixel, relative ; coordMode for ImageSearch relative to window (default, but to be save on save side)
  WinGetActiveStats, a, winW, winH, a, a

  ErrorLevel = 0
  ImageSearch, ix, iy, 0, 0, winW, winH, %A_ScriptDir%\Assets\Screenshots\%filename%

  if (ErrorLevel) {
    tooltip, Property not found. Error: %ErrorLevel%
    sleep 1000
    tooltip
    goto, end ; abort if image not found
    return
  }

  PixelSearch, goalX, goalY, ix+69, iy, winW, iy+8, 0x2D8CEB, 30, Fast RGB ; find blue numbers

  MouseGetPos, mx, my
  MouseMove, goalX+offset, goalY, 0 ; (offset is for changing Y-values)
  Click, goalX+offset, goalY, Down

  ; enable mouse acceleration workaround https://youtu.be/gATSOJCHSaY
  DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, 11, UInt, 0)

  ; enable mouse input for changing property value
  BlockInput, Off
  BlockInput, MouseMoveOff

  Keywait, %unlockKey%
  Click, Up, Left
  Sleep, 10
  MouseMove, mx, my, 0

  ; disable mouse acceleration workaround
  DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, 10, UInt, 0)

  end:

  BlockInput, Off
  BlockInput, MouseMoveOff
}
