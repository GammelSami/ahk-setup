; This function searches the active window for a image from the Screenshots bin and clicks on it.

win_clickImage(filename, offsetX:=0, offsetY:=0, button:="left") {
  coordMode, pixel, relative ; coordMode for ImageSearch relative to window (default, but to be save on save side)

  WinGetPos, , , winW, winH

  ErrorLevel = 0
  ImageSearch, ix, iy, 0, 0, winW, winH, %A_ScriptDir%\Assets\Screenshots\%filename%

  if (ErrorLevel) {
    tooltip, Error: %ErrorLevel%
    sleep 1000
    tooltip
    return
  }

  BlockInput, MouseMove

  MouseGetPos, mx, my ; save backup of original mouse position

  tx := ix + offsetX
  ty := iy + offsetY

  MouseMove, %tx%, %ty%, 0
  Click, %button%, %tx%, %ty% ; while clicking the BlockInput isn't working, so i use the target coords twice

  MouseMove, %mx%, %my%, 0 ; apply backup of original mouse position

  BlockInput, MouseMoveOff
}
