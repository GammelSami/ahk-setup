REM Benötigt ImageMagick
@echo off
if [%1]==[] goto :eof
:loop
magick %1 %1.psd
shift
if not [%1]==[] goto loop
