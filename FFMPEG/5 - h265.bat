SET /A trash_uncompressed_files=1

SET /p bitrate="Enter Kbit/s: "

REM @echo off
if [%1]==[] goto :eof
:loop

if exist "%~1\*" ( :: if directory given
  pushd %1
  for /R %%A in ("*.mp4","*.mkv","*.m4v") do CALL :compress "%%A" "%%~dnpA - COMPRESSED.mp4" :: recursive get files by extension
) else CALL :compress "%~1" "%~dpn1 - COMPRESSED.mp4"

shift
if not [%1]==[] goto loop
exit


:: define function
:compress
SETLOCAL
HandBrakeCLI -i "%~1" -o "%~2" -e nvenc_h265 --encoder-preset slow -b %bitrate% --cfr --all-audio --all-subtitles -E copy
:: trash or rename input file
if /I "%trash_uncompressed_files%" EQU "0" (
	ren "%~1" "%~n1 - uncompressed.mp4"
) else (
	if exist "%~2" ( :: if output file exists, delete input file
		powershell -Command "& {$shell = new-object -comobject 'Shell.Application'; $item = $shell.Namespace(0).ParseName(\"%~1\"); $item.InvokeVerb('delete');}"
	)
)
ENDLOCAL :: end of function
