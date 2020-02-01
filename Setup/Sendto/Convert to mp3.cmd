REM Benötigt ffmpeg
@echo off
if [%1]==[] goto :eof
:loop
ffmpeg -i %1 -f mp2 %1.mp3
shift
if not [%1]==[] goto loop
