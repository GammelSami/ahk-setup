
;
; Lock Horizontal Mouse Axys for better Bézier keyframe handling
;
; If Premiere would have this feature, such a Script wouldn't be neccesary (plz upvote):
; https://adobe-video.uservoice.com/forums/911233-premiere-pro/suggestions/39305383-animation-curve-handle-should-be-locked-vertically
;

win_lockMouseY(unlockKey="Esc") {

  ; I dont know why!! But if it locks the y axis to the current mouse pos, my mouse jumps 8px down...
  ; ...so this is the workaround:
  mouseOffsetY = -8 ; maybe change this to your needs

  MouseGetPos, , mouseY
  tooltip, Y axis locked
  ClipCursor( 0, mouseY+mouseOffsetY, A_ScreenWidth, mouseY+1+mouseOffsetY )
  Keywait, %unlockKey%
  DllCall("ClipCursor") ; disable ClipCursor
  tooltip,

}

; this is where the magic happens:
ClipCursor( x1=0 , y1=0, x2=1, y2=1 ) {
  VarSetCapacity(R,16,0),  NumPut(x1,&R+0),NumPut(y1,&R+4),NumPut(x2,&R+8),NumPut(y2,&R+12)
  Return DllCall( "ClipCursor", UInt,&R )
}

; Source of the magic (with the +1px fix): autohotkey.com/board/topic/56025-how-to-temporarily-disable-mouse-x-axis/?p=351911
; Source of the disable "workaround": https://www.autohotkey.com/boards/viewtopic.php?p=245780#p245780
; this was also helpful to me, because i was searching for a keyup-event: autohotkey.com/board/topic/92458-can-i-hold-a-key-down-without-it-spamming-at-any-rate-more-s/?p=582895

; also interesting, but overkill: www.autohotkey.com/boards/viewtopic.php?t=31712
