; Quelle: https://github.com/TaranVH/2nd-keyboard/blob/master/Taran's_Windows_Mods/Alt_menu_acceleration_DISABLER.ahk

Menu, Tray, Icon, shell32.dll, 110 ; changes the icon to a (\) thingy

;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#InstallKeybdHook
#NoEnv
;#NoTrayIcon ;comment this in if you do not want a tray icon.
#SingleInstance
#MaxHotkeysPerInterval 2000
Process, Priority, , H
SendMode Input
#SingleInstance force

;These next two lines are EXTREMELY IMPORTANT. You have to change the "menu mask key" away from being CTRL, to something that won't result in cross-talk. Read this thread to learn the details: https://autohotkey.com/boards/viewtopic.php?f=76&t=57683
#MenuMaskKey vk07  ; vk07 is unassigned.
#UseHook

; INFO: you can hold down both ALT keys if you want to easily toggle this script on and off.


; THEY ALL SAID IT COULD NOT BE DONE
; THEY ALL HAD SHITTY SOLUTIONS THAT DIDN'T WORK

; https://superuser.com/questions/309005/disable-the-activation-of-the-menu-bar-when-alt-is-pressed-in-windows-7
; https://forums.adobe.com/thread/1863532
; https://twitter.com/TaranVH/status/993918736510763008

; BUT YOUR MAIN MAN TARAN, HE FIGURED THIS SHIT OUT
; NOW HE CAN GET RID OF ALT MENU ACCELERATION ONCE AND FOR ALL
; AND SO CAN YOU, WITH THIS AHK SCRIPT.


; THE SITUATION:
; In just about any Windows application, pressing (and releasing!) the ALT key will highlight the menu bar in a special way, where pressing a letter key immediately after, (Like F) will result in the menu being opened. Further keystrokes will bring you even deeper into the menu. This is called "menu acceleration."
; So, ALT I R will make a new row in excel, and ALT R C will make a new comment in Word... stuff like that. You only have to press one key at a time, and the key combo still works.

; THE PROBLEM:
; Because this system allows you to completely release the ALT key before pressing the next keystrokes, it means that ALT is not really a modifier key... it's an obligatory STICKY KEY. https://en.wikipedia.org/wiki/Sticky_keys
; So, in applications that treat the ALT key as a modifier, like Premiere, you sometimes end up activating the menus when you don't want to! (And there's no reason to use menu acceleration anyway, since Premiere already allows you to bind those actions to custom shortcuts.)

; THE COMPLAINT:
; I've looked, and there is no way to disable this feature using the registry... because it's an "accessibility" thing.
; Guess what, Microsoft? I don't have a physical diability, and this feature slows me down. Forcing this feature on EVERYONE just because SOME pople need it, is like ripping out all the stairs, and putting wheelchair ramps in instead. There's no reason to force everyone to use the wheelchair ramps.

; THE THOUGHT PROCESS:
; I noticed that the "File" menu only appears to become activated on the key-up event. However, functionally, it actually activates on the key DOWN event. Therefore, attempting to block this using "LAlt up::[insert code here]" will never work.
; I also noticed that if I pressed down left ALT, held it, and then pressed and released F12, that when I released left ALT... NOTHING HAPPENED. And, when I then pressed F, NOTHING CONTINUED TO HAPPEN.
; Brilliant. And it works with any keystroke, not just F12. so, to nullify the menu acceleration, we have to pair ALT with another keystroke... but which key can we sacrifice? IT can't be used for anything else...
; Some people would think to use F13 through F24. Those poeple are wrong. They are not The Macro King.
; "F24" is just the name that we give to the scan code 76, also known as SC076. But the scan codes go much higher than this.
; How high? I have a list. I made it myself, since nobody else on the internet seems to have done so:
; https://github.com/TaranVH/2nd-keyboard/blob/master/FYI/Table_of_all_scan_codes.xlsx
; There are hundreds of unused ones to choose from. However, although the following scan codes might APPEAR to be unused...:
;SC05A SC05B SC05C SC05D SC05E SC05F SC060 SC061 SC062 SC06F SC070 SC071 SC072 SC073 SC074 SC075 SC077 SC078 SC079 SC07A SC07B SC07C SC07D SC07E SC07F
;You should probably only use scan codes above SC080. This is because diffreent software will treat each code differently. Google docs, for example, changes some of those scan codes into accented characters. Again, see my spreadsheet for the full, gory details.
; Furthermore, after some testing, I determined that we must address each alt key specifically, for both its down and up events.
;You can comment in the tooltips if you want to do any debugging, but this script should run just fine right out of the box.
;ALT still works normally for everything else.
;ALT I R and other key combos stil work, but now you must be holding ALT down the whole time.

; THE SOLUTION:

~LAlt::
sendinput, {SC0E9 down} ;this is the scan code of an unassigned key. As long as you nor the system never use it for anything else, it can be used in THIS way to cancel the menu acceleration.
KeyWait, LAlt
return

~LAlt up::
sendinput, {SC0E9 up}
return


~RAlt::
;sendinput, {RAlt down}
sendinput, {SC0E9 down}
;;tooltip, Ralt is pressed
KeyWait, RAlt
;;tooltip, Ralt was released
return

~RAlt up::
;sendinput, {RAlt up}
sendinput, {SC0E9 up}
;;tooltip,
return


Lalt & Ralt::suspend ;hit both ALT keys simultaneously to toggle the functonality of this script. The tray icon will also change visually, so you will always know.


;;comment in the code below if you wish to reassign alt modifier combinations:

; !f::msgbox,,,To block modifier key use of alt you can do it like this,0.7
; !e::msgbox,,,replace msgbox with whatever code you want,0.7
; !w::msgbox,,,horray for having control of your own computer,0.7
