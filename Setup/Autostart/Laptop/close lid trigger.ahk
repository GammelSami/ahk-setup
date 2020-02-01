; Wenn ich mein Laptop zuklappe, während es auflädt, sperrt sich Windows nicht von selbst.
; Habe dieses Script irgendwo im Internet gefunden. Es funktioniert, keine Ahnung wie.


; Build the LIDSWITCH_STATE_CHANGE GUID
VarSetCapacity(GUID_LIDSWITCH_STATE_CHANGE, 16)
for each, Number in [0xBA3E0F4D, 0x4094B817, 0x63D5D1A2, 0xF3A0E679]
	NumPut(Number, GUID_LIDSWITCH_STATE_CHANGE, 4*(A_Index-1), "UInt")

; Register the hooks
DllCall("RegisterPowerSettingNotification"
, "Ptr", A_ScriptHwnd
, "Ptr", &GUID_LIDSWITCH_STATE_CHANGE
, "UInt", 0)
OnMessage(0x218, "WM_POWERBROADCAST")

WM_POWERBROADCAST(wParam, lParam, Msg, hWnd)
{
	GUID := NumGet(lParam+0, 0, "UInt")
	if (GUID != 0xBA3E0F4D) ; Does not start with lidswitch GUID
		return

	Open := NumGet(lParam+0, 20, "UChar") ; 1 or 0
	if Open
	{
		; Opening the lid
		SoundBeep, 750
	}
	else
	{
		; Closing the lid
		SoundBeep, 500
		DllCall("LockWorkStation") ; Lock your session (Win-L)
	}
}
