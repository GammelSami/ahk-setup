; EASE IN AND EASE OUT by TaranVH
; modified for german Premiere by GammelSami

pp_easyEase() {

  bigdelay = 300 ; because Premiere's context menu has special needs; increase this if you have a slower pc
  normaldelay = 1

  ;This will click on the necessary menu items for you
  ;all you have to do is hover the cursor over a keyframe (or selected keyframes) in the Effect Controls panel, and hit the button.
  tooltip, ease in and out
  blockinput, on
  blockinput, MouseMove ; blockinput, sendandMouse
  MouseGetPos, mouseX, mouseY ; save mouse position for the rightclicks, because for some reason the mouse can still be moved while the context menu is closing

  send {Volume_Mute} ; avoid ugly windows system sounds. u can remove it if you wanna hear playback audio
  sleep %normaldelay%

  ; ease out
  MouseClick, right, %mouseX%, %mouseY%
  sleep %bigdelay%
  send z
  sleep %normaldelay%
  send {up}
  sleep %normaldelay%
  send {enter}
  sleep %bigdelay%

  ; ease in
  MouseClick, right, %mouseX%, %mouseY%
  sleep %bigdelay%
  send z
  sleep %normaldelay%
  send {up}
  sleep %normaldelay%
  send {up}
  sleep %normaldelay%
  send {enter}
  sleep %bigdelay%

  ; geometric interpolation = linear
  MouseClick, right, %mouseX%, %mouseY%
  sleep %bigdelay%
  send g
  sleep %normaldelay%
  send {right}
  sleep %normaldelay%
  send {enter}
  sleep %normaldelay%

  blockinput, off
  blockinput, MouseMoveOff

  sleep 650
  send {Volume_Mute}

  tooltip,

}
