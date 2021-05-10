REM Benötigt ffmpeg
@echo off
if [%1]==[] goto :eof
:loop
ffmpeg -i %1 -map 0:a -c copy %1.m4a
shift
if not [%1]==[] goto loop
