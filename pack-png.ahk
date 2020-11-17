#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

; what the cropped resolution should be
crop= 512 ; 4352 would result in a round number for 8k

; calculate uncropped resolution
height=%crop%
width=%crop%
height*=2.1796875
width*=3.125

; add Windows 10 margin (may be different on your system)
height+=39
width+=16

WinGet, id, , Minecraft
CoordMode, Mouse, Client
CoordMode, Pixel, Client
Blockinput, MouseMove

WinActivate, Minecraft
Click, 430, 237
Sleep, 50
Click, 430, 100

; wait for the map to load (detected by the white text in upper left corner)
color=0
While (color!=0xFFFFFF)
{
PixelGetColor, color, 5, 5
Sleep, 5
}

CoordMode, Mouse
CoordMode, Pixel

; pause for resizing wihtout changing camera rotations
Send, {Esc}
Sleep, 50
Result := DllCall("SetWindowPos", "uint", id, "uint", HWND_TOP, "Int", 0-width/2+A_ScreenWidth/2, "Int", 0-height/2+A_ScreenHeight/2, "Int", width, "Int", height, "UInt", 0x400)

; chunk loading
Loop, 7
{
  SoundPlay, %A_WinDir%\Media\Windows Startup.wav
  Sleep, 1000
}

; unpause
Send, {Esc}

; wait for the clouds to match
Loop, 32
{
  SoundPlay, %A_WinDir%\Media\Windows Startup.wav
  Sleep, 1000
}
Sleep, 400

; take screenshot (may take a while)
Send, {F1 down}
Sleep, 50
Send, {F2 down}
Sleep, 50
Send, {F2 up}
SoundPlay, %A_WinDir%\Media\Windows Navigation Start.wav
Sleep, 50
Send, {F1 up}
Sleep, 50
Send, {Esc}
Sleep, 7000
WinMaximize, Minecraft

Blockinput, MouseMoveOff
ExitApp

$Escape::
ExitApp
Return
