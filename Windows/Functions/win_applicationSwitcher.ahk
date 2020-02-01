; Source: https://youtu.be/OqyQABySV8k

#IfWinActive

win_applicationSwitcher(app) {

  Switch app
  {
  Case "Explorer":
    IfWinNotExist, ahk_class CabinetWClass
      Run, explorer.exe
    GroupAdd, taranexplorers, ahk_class CabinetWClass
    if WinActive("ahk_exe explorer.exe")
      GroupActivate, taranexplorers, r
    else
      WinActivate ahk_class CabinetWClass
    Return
  Case "Word":
    IfWinNotExist, ahk_class OpusApp
      Run, WINWORD.EXE
    WinActivate ahk_class OpusApp
    Return
  Case "PremierePro":
    IfWinNotExist, ahk_class Premiere Pro
      Run, Adobe Premiere Pro.exe
    WinActivate ahk_class Premiere Pro
    Return
  Case "AfterEffects":
    IfWinNotExist, ahk_class "AE_CApplication_17.0"
      Run, AfterFX.exe
    WinActivate ahk_class "AE_CApplication_17.0"
    Return
  Case "1Password":
    IfWinNotExist, ahk_class "HwndWrapper[1Password.exe;UI thread;e253d9f5-d4ab-4c33-a43b-fb03aa755b63]"
      Run, 1Password.exe
    WinActivate ahk_class "HwndWrapper[1Password.exe;UI thread;e253d9f5-d4ab-4c33-a43b-fb03aa755b63]"
    WinWaitActive 1Password ; looks for the window title
    Send ^f
    Return
  Default:
    try {
      IfWinNotExist, ahk_class %app%
        Run, %app%.exe
      WinActivate ahk_class %app%
      Return
    } catch e {
      tooltip, App %app% not found!
      Sleep 3000
      tooltip,
    }
  }

}
