
/*
cursor click visualization 1.0, By Taran Van Hemert without the Accelerated Scrolling Script.
PROBLEMS WITH THE CURSOR VISUALIZER:
Background color behind the green text is not completely transparent on the edges --- there is no anti aliasing, so it looks jagged
Would be nice to use customizable pictures, instead of a dumb font (lucida console) that not everyone will have anyway.
The click visualizations do not linger at all -- I don't know how to do this if I wanted to.
Middle click visualization does not work. I don't know why but nothing I try will work to get it to show up.
Also, You'll have to modify the positioning of the GUI to suit your own computer and its UI scaling in Windows.
*/

;Use this script only if you want cursor visualization.
;SOURCE: https://github.com/TaranVH/2nd-keyboard

Menu, Tray, Icon, shell32.dll, 44 ; changes the icon to a star -- makes it easy to see which one it is.


SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#NoEnv
;#NoTrayIcon
#SingleInstance
#MaxHotkeysPerInterval 2000


#SingleInstance force
CoordMode, mouse, screen

;below is a bunch of GUI stuff that I need for cursor click visualization.
;Use WIN KEY and scroll down to turn it on or off.

size := 200
kolor := 11FF99
kolor2 := 008833
showClicks = 1




Gui, -Caption +ToolWindow +AlwaysOnTop +LastFound
;Gui, Color, %kolor2%
Gui, Color, 008833
GuiHwnd := WinExist()
DetectHiddenWindows, On
WinSet, Region, % "0-0 W" Size " H" Size, ahk_id %GuiHwnd%
WinSet, ExStyle, +0x20, ahk_id %GuiHwnd% ; set click through style
;WinSet, Transparent, 0, ahk_id %GuiHwnd% ;didn't work...
;WinSet, TransColor, %kolor2% 100
WinSet, TransColor, 008833 100
;WinSet, TransColor, %kolor% 100
Gui, Show, w%Size% h%Size% ;hide
Gui, Font, s32, lucida console ;This font has nearly perfect ()v^ characters. I also tried these: ;Estrangelo Edessa ;century gothic
Gui, Add, Text, vMyText cLime,  ; xx  auto-sizes the window.

If showClicks = 1
{
  settimer, looper, -2
}
nokill = 1
delay = 200


; Key bindings

;These allow for the visualizer to work with modifier keys, but do NOT affect any sort of clicking at all.
; ^ is CTRL
; + is SHIFT
; ! is ALT
; ~ allows the key to also pass through normally
~^WheelUp::
~+WheelUp::
~^+WheelUp::
~!WheelUp::
Wup = 1
return

~^WheelDown::
~+WheelDown::
~^+WheelDown::
~!WheelDown::
Wdown = 1
return


~WheelUp::
Gui, hide
Wup = 1
return

~WheelDown::
Gui, hide
Wdown = 1
return

;remember, in this case the # means the WIN KEY.
;So you can toggle this in order to disable or re-enable the script
;#Wheelup::   Suspend
#mbutton::   Suspend

#WheelDown:: ; this turns the click visualizer on or off.
If showClicks = 1
{
  tooltip, changing visualization
  showClicks = 0
  settimer, looper, -20
  sleep 555
  tooltip,
  Return
}
else if showClicks = 0
{
  showClicks = 1
  settimer, looper, off
}
Return


; pgup::send {wheelup 50}
; pgdn::send {wheeldown 50}


;Begin cursor click visualization stuff:

~*$LButton::
Lbuttondown = 1
Return
~*$LButton up::
Lbuttondown = -1
Return

~*$RButton::
Rbuttondown = 1
Return
~*$RButton up::
Rbuttondown = -1
Return


wheelkiller:
;msgbox, wheelkiller
if Wup = -1
{
  Wup = 0
  Gui, hide
}
if Wdown = -1
{
  Wdown = 0
  Gui, hide
}
Return


looper:


MouseGetPos, realposX, realposY
;tooltip,^ ;this is just in case my cursor vanishes in premiere, as it has done sometimes...

posX := realposX - Size/2.4, posY := realposY - Size/3.1 + 0 ; puts the gui in the middle rather than the corner. this is for 150% UI
posX := realposX - Size/3.4, posY := realposY - Size/4.1 + 0 ; puts the gui in the middle rather than the corner. this is for 100% UI.
If(Lbuttondown = 1 and Rbuttondown = 1) ;this doesn't really work. Often the ) will be out of alignment or will not show up.
{
  GuiControl,, MyText, ()
  posX := posX-10
  Gui, Show, x%posX% y%posY% NA
  settimer, looper, -20
  return
}

If Lbuttondown = 1
{
  ;tooltip, <, posX-25, posY-8, 2 ;this code was used for bug testing.
  ;SoundBeep, 400, 50
  ;soundplay, C:\AHK\3.wav,
  GuiControl,, MyText, (
    posXX := posX-10
    Gui, Show, x%posXX% y%posY% NA
  }
  If Lbuttondown = -1
  {
    ;tooltip, , , , 2
    Lbuttondown = 0
    Gui, hide
  }


  If Rbuttondown = 1
  {
    posX := posX+20
    GuiControl,, MyText, )
    Gui, Show, x%posX% y%posY% NA
  }
  If Rbuttondown = -1
  {
    Rbuttondown = 0
    Gui, hide
  }

  If Wup = 1
  {
    posYu := posY-10
    posxu := posX+8
    GuiControl,, MyText, ^
    Gui, Show, x%posXu% y%posYu% NA
    settimer, wheelkiller, -200
    Wup = -1
  }
  If Wdown = 1
  {
    posYd := posY+32
    posXd := posX+8
    Gui, Font, s20 cBlue, Verdana
    GuiControl,, mytext, v
    Gui, Show, x%posXd% y%posYd% NA


    settimer, wheelkiller, -200
    Wdown = -1
  }


  settimer, looper, -1
  Return
