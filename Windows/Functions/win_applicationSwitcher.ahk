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
  Case "Thunderbird":
    IfWinNotExist, ahk_exe thunderbird.exe
      Run, thunderbird.exe
    GroupAdd, thunderbirdwindows, ahk_exe thunderbird.exe
    if WinActive("ahk_exe thunderbird.exe")
      GroupActivate, thunderbirdwindows, r
    else
      WinActivate ahk_exe thunderbird.exe
    Return
  Case "Teamspeak":
    IfWinNotExist, ahk_exe ts3client_win64.exe
      Run, %PROGRAMFILES%\TeamSpeak 3 Client\ts3client_win64.exe
    WinActivate ahk_exe ts3client_win64.exe
    Return
  Case "GogGalaxy":
    IfWinNotExist, ahk_exe GalaxyClient.exe
      Run, C:\Program Files (x86)\GOG Galaxy\GalaxyClient.exe
    WinActivate ahk_exe GalaxyClient.exe
    Return
  Case "Discord":
    IfWinNotExist, ahk_exe Discord.exe
      Run, %USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Discord Inc\Discord.lnk
    WinActivate ahk_exe Discord.exe
    Return
  Case "WhatsApp":
    IfWinNotExist, ahk_exe WhatsApp.exe
      Run, %A_ScriptDir%\Setup\WhatsApp Desktop.lnk
    WinActivate ahk_exe WhatsApp.exe
    Return
  Case "PremierePro":
    IfWinNotExist, ahk_class Premiere Pro
      Run, Adobe Premiere Pro.exe
    WinActivate ahk_class Premiere Pro
    IfWinActive ahk_class Premiere Pro
      Send, +2 ; focus source monitor
    Return
  Case "AfterEffects":
    IfWinNotExist, ahk_class "AE_CApplication_17.0"
      Run, AfterFX.exe
    WinActivate ahk_class "AE_CApplication_17.0"
    Return
  Case "Photoshop":
    IfWinNotExist, ahk_class Photoshop
      Run, Photoshop.exe
    WinActivate ahk_class Photoshop
    Return
  Case "YouTube Music Desktop App":
    IfWinNotExist, ahk_exe YouTube Music Desktop App.exe
      Run, C:\Users\Sam\AppData\Local\Programs\youtube-music-desktop-app\YouTube Music Desktop App.exe
    WinActivate ahk_exe YouTube Music Desktop App.exe
    Return
  Case "Terminal":
    IfWinNotExist, ahk_exe WindowsTerminal.exe
      Run, wt
    IfWinNotActive ahk_exe WindowsTerminal.exe
      WinActivate ahk_exe WindowsTerminal.exe
    Return
  Case "Bitwarden":
    IfWinNotExist, ahk_exe Bitwarden.exe
      Run, C:\Program Files\Bitwarden\Bitwarden.exe
    WinWait ahk_exe Bitwarden.exe
    WinActivate ahk_exe Bitwarden.exe
    Return
  Default:
    try {
      IfWinNotExist, ahk_exe %app%.exe
        Run, %app%.exe
			WinWait ahk_exe %app%.exe
      WinActivate ahk_exe %app%.exe
      Return
    } catch e {
      tooltip, App %app% not found!
      Sleep 5000
      tooltip,
    }
  }

}
