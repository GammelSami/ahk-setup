; inspired from https://github.com/sebinside/AutoHotkeyScripts/blob/860bc292ca209eb88665a61d51683b494c780c83/StreamDeckFunctions.ahk#L192
; troubleshooting? look at the github link

pp_clipboardLoad(clipName) {

  WinActivate, Adobe Premiere Pro

  ; Load some text to... well premiere things.
  RunWait, PremiereClipboard.exe --fill

  ; After loading some text, tab out of premiere and tab back in. This trigger some weird reset action, nobody will ever understand
  ; sleep 500
  ; Send, !{Tab}
  ; sleep 500
  ; Send, !{Tab}
  ; sleep 500

  ; Load clipboard (don't forget to change paths)
  RunWait, PremiereClipboard.exe --load "%A_ScriptDir%\Assets\Clipboards\%clipName%.clp"

  ; Ctrl + V, but the "save" taran way
  SendInput, {Shift Down}{Shift Up}{Ctrl Down}{v Down}
  sleep 5
  SendInput, {v Up}{Ctrl Up}
  sleep 10

  sleep 10
  Send, ^+a ; deselect everything
}
