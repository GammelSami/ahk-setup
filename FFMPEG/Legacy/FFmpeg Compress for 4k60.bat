SET /A delete_uncompressed_files=0

REM @echo off
if [%1]==[] goto :eof
:loop

if exist "%~1\*" ( :: if directory given
  pushd %1
  for /R %%A in ("*.mp4") do CALL :ffmpeg "%%A" "%%~dnpA - NVENC@18Mbit.mp4" :: recursive get files by extension
) else CALL :ffmpeg "%~1" "%~dpn1 - NVENC@18Mbit.mp4"

shift
if not [%1]==[] goto loop
exit


:: define function
:ffmpeg
SETLOCAL
ffmpeg -i "%~1" -map 0:v -map 0:a -c:v hevc_nvenc -filter:v fps=fps=60 -preset:v slow -rc vbr -rc-lookahead 250 -b:v 18M -2pass 1 -pix_fmt yuv420p -c:a copy "%~2"
:: delete or rename input files
if /I "%delete_uncompressed_files%" EQU "0" (
  ren "%~1" "%~n1 - uncompressed.mp4"
) else (
  del "%~1"
)
ENDLOCAL :: end of function
