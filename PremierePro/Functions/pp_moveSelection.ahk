; not polished
; do not use

; ^Up::pp_moveSelection("up")
; ^Down::pp_moveSelection("down")

pp_moveSelection(direction="up") {

  ; init variables
  filename := ""
  Switch direction
  {
    Case "up":
      filename = selectedClipTopWithPlayhead.png
    Case "down":
      filename = selectedClipBottomWithPlayhead.png
    Default:
      ToolTip, Wrong property given
      Sleep, 1000
      ToolTip,
      return
  }

  ; ImageSearch
  coordMode, pixel, relative ; coordMode for ImageSearch relative to window (default, but to be save on save side)
  WinGetActiveStats, a, winW, winH, a, a

  ErrorLevel = 0
  ImageSearch, ix, iy, 0, 0, winW, winH, %A_ScriptDir%\Assets\Screenshots\%filename%

  if (ErrorLevel) {
    tooltip, Selected clip not found. Error: %ErrorLevel%
    sleep 1000
    tooltip
    return ; abort if image not found
  }



  Switch direction
  {
    Case "up":
      PixelSearch, goalX, goalY, ix+1, iy, ix+1, 0, 0x313131, 70, Fast RGB ; find blue numbers
      goalY--
      goalY--
      goalY--
      goalY--
      goalY--
      goalY--
      goalY--
      goalY--
    Case "down":
      PixelSearch, goalX, goalY, ix+1, iy, ix+1, winH, 0x313131, 70, Fast RGB ; find blue numbers
      goalY++
      goalY++
      goalY++
      goalY++
      goalY++
      goalY++
      goalY++
      goalY++
    Default:
      ToolTip, Wrong direction given
      Sleep, 1000
      ToolTip,
      return
  }

  MouseGetPos, mx, my
  MouseMove, goalX, goalY, 0
  Click
  ;MouseMove, mx, my, 0
}
