REM Benötigt ffmpeg; ignoriert Audiospuren >1
@echo off
if [%1]==[] goto :eof
:loop
ffmpeg -i %1 -c copy -copyts %1.mp4
shift
if not [%1]==[] goto loop
