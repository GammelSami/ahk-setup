; Simple eyedropper / colorpicker which saves a hexcode to clipboard

; This needs ToolTipColor Script. I include it in includer.ahk
; Or you can use the three GUI commands I commented out
; #Include %A_ScriptDir%\..\..\Lib\tooltipStyling.ahk

win_eyedropper(unlockKey="Esc") {
  win_eyedropper_cursor()
  loop {
    ; GUI, 1:+AlwaysOnTop -Border -SysMenu +Owner -Caption +ToolWindow
    MouseGetPos X, Y
    PixelGetColor hexColor, %X%, %Y%, RGB
    If (hexColor < 0x7F7F7F) {
      ToolTipColor(hexColor, "White")
    } Else {
      ToolTipColor(hexColor, "Black")
    }
    StringReplace, color, hexColor, 0x, , 1 ; remove the "0x" and save in new variable %color%
    ToolTip, %color%
    ; GUI, 1:show, NoActivate X%X% Y%Y% w30 h30, dropDesk
    if not GetKeyState(unlockKey, "P") {
      ; GUI, 1:hide
      win_eyedropper_cursor_reset()
      ToolTip,
      ToolTipColor("Default") ; reset for future tooltips from other functions

      ; without the following DllCalls the clipboard-saving would crashe every 2nd run... dafuq
      ; autohotkey.com/board/topic/27849-solved-animated-gui-windows-causing-clipboard-set-error/?p=179149
      DllCall("OpenClipboard", uint, 0)
      DllCall("EmptyClipboard")
      DllCall("CloseClipboard")
      Clipboard:=color

      break
    }
    sleep 16
  }
}


win_eyedropper_cursor() {
  ; www.autohotkey.com/boards/viewtopic.php?p=268264#p268264
  ; www.autohotkey.com/boards/viewtopic.php?p=68257#p68257

  CursorFile = %A_ScriptDir%\Assets\eyedropper.cur

  Cursors = 32512,32513,32514,32515,32516,32640,32641,32642,32643,32644,32645,32646,32648,32649,32650,32651
  Loop, Parse, Cursors, `,
  {
  	DllCall("SetSystemCursor", "Uint", DllCall( "LoadCursorFromFile", Str,CursorFile ), "Uint", A_LoopField)
  }
}

win_eyedropper_cursor_reset() {
  DllCall("SystemParametersInfo", "Uint", 0x0057, "Uint", 0, "Uint", 0, "Uint", 0)
}
