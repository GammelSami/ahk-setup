SET /A delete_original_files=1

REM @echo off
if [%1]==[] goto :eof
:loop

if exist "%~1\*" ( :: if directory given
  pushd %1
  for /R %%A in ("*.mp4") do CALL :ffmpeg "%%A" "%%~dnpA.mkv" :: recursive get files by extension
) else CALL :ffmpeg "%~1" "%~dpn1.mkv"

shift
if not [%1]==[] goto loop
exit


:: define function
:ffmpeg
SETLOCAL
ffmpeg -i "%~1" -map 0 -codec copy -dn "%~2"
ENDLOCAL :: end of function

pause
