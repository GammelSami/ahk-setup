SET /A trash_uncompressed_files=1

REM @echo off
if [%1]==[] goto :eof
:loop

if exist "%~1\*" ( :: if directory given
  pushd %1
  for /R %%A in ("*.mp4") do CALL :ffmpeg "%%A" "%%~dnpA - COMPRESSED.mp4" :: recursive get files by extension
) else CALL :ffmpeg "%~1" "%~dpn1 - COMPRESSED.mp4"

shift
if not [%1]==[] goto loop
exit


:: define function
:ffmpeg
SETLOCAL
HandBrakeCLI -i "%~1" -o "%~2" -e nvenc_h265 --encoder-preset slow -b 100 --cfr --all-audio -E copy -r 1
:: delete or rename input files
if /I "%trash_uncompressed_files%" EQU "0" (
  ren "%~1" "%~n1 - uncompressed.mp4"
) else (
  powershell -Command "& {$shell = new-object -comobject 'Shell.Application'; $item = $shell.Namespace(0).ParseName(\"%~1\"); $item.InvokeVerb('delete');}"
)
ENDLOCAL :: end of function
