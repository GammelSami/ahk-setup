# This PowerShell script calculates optimal archiving bitrate for each given video
# and compresses it in nvenc_h265 fix fps.

# How to use?
# Right click on selected Files/Folders -> Send to -> [This script]

# Installation:
# 1. Allow execution of PowerShell scripts: https://superuser.com/a/106363/1149239
# 2. Create a link to this script (without the -SourceFile) https://stackoverflow.com/a/33807603/9261735
#    Or use mine: https://github.com/GammelSami/ahk-setup/blob/master/Setup/Sendto/c%20-%20smart%20NVENC%20compression.lnk
# 3. Put it inside the Sendto folder: Win + R -> shell:sendto
# 4. Change the settings variables how you like.
# 5. Share: https://twitter.com/GammelSami/status/1460761863600447496

#################
### settings ###
#################

$outputFileSuffix = ' - COMPRESSED'

$trashInputFile = 1
$inputFileSuffix = ' - uncompressed'
$inputFileSuffixFail = ' - not COMPRESSED'

$skipAlreadyProcessedFiles = 1

$debug = 0


#################
### functions ###
#################

Function Compress-Video {
    param (
        $inputFile
    )
    # "calculate" path of the output file
    $inputFileItem = Get-Item "$inputFile"
    $outputFile = (Split-Path "$inputFile" -Parent) + '\' + $inputFileItem.Basename + $outputFileSuffix + '.mp4'

    # skip file if already processed (determined by name)
    if ($skipAlreadyProcessedFiles -eq 1) {
        if ($inputFileItem.Basename -match $outputFileSuffix -or
            $inputFileItem.Basename -match $inputFileSuffix -or
            $inputFileItem.Basename -match $inputFileSuffixFail
        ) {
        Write-Host "Skipping already processed file! (determined by file name): $inputFile" -ForegroundColor Cyan
        Return
        }
    }

    # get metadata of input file
    Write-Host "reading file metadata..." -ForegroundColor Green
    $metadata = ffprobe -v error -select_streams v:0 -count_frames -skip_frame nokey -show_entries stream=width,height,avg_frame_rate,duration,nb_read_frames -of csv=p=0 "$inputFile"
    $metadata = "$metadata" -split ','

    [int]$width = $metadata[0]
    [int]$height = $metadata[1]
    $framerate = ($metadata[2] -split '/')
        [int]$fps = [math]::Round([int]$framerate[0] / [int]$framerate[1])
    [double]$duration = $metadata[3]
    [int]$iframes = $metadata[4]

    # log metadata
    Write-Host "$width x $height @ $fps" ($iframes/$duration)'iFrames/s' -ForegroundColor White


    # calculate bitrate from metadata

    # old (trash): [double]$bitrate = [Math]::SQRT($width * $height) * ($fps / 60 + 0.5) * (Log2($iframes/$duration * 8)) / 10

    [double]$bitrateResolution = log10([Math]::SQRT($width * $height))
    [double]$bitrateFPS = Log2($fps)
    [double]$bitrateIframes = [double](Log2($iframes/$duration)) * 5
    [int]$bitrate = ($bitrateResolution * $bitrateFPS + $bitrateIframes) * 700
    [string]$bitrate = '' + $bitrate + 'K'

    # write log
    Write-Host "compressing: $inputFile" -ForegroundColor Green
    Write-Host "to: $outputFile" -ForegroundColor Green
    Write-Host "using calculatet bitrate of: $bitrate" -ForegroundColor Green

    # compression with ffmpeg (command by @tuf_Hannes)
    ffmpeg -i "$inputFile" -map 0:v -map 0:a -c:v hevc_nvenc -filter:v fps=fps="$fps" -preset:v slow -rc vbr -rc-lookahead 250 -b:v "$bitrate" -2pass 1 -pix_fmt yuv420p -c:a copy "$outputFile"

    # ffmpeg failed? exit
    if ($? -eq 0) {
        $inputFileNewName = $inputFileItem.BaseName + $inputFileSuffixFail + $inputFileItem.Extension
        Rename-Item -Path "$inputFile" -NewName "$inputFileNewName"
        Return
    }

    # alternative to ffmpeg: (if using, remove the 'K' from $bitrate)
    # HandBrakeCLI -i "$inputFile" -o test.mp4 -e nvenc_h265 --encoder-preset slow -b "$bitrate" --cfr --all-audio -E copy

    $outputFileItem = Get-Item "$outputFile"

    # output file bigger than input? delete!
    if ($outputFileItem.Length -ge $inputFileItem.Length) {
        Remove-Item "$outputFile"
        $inputFileNewName = $inputFileItem.BaseName + $inputFileSuffixFail + $inputFileItem.Extension
        Rename-Item -Path "$inputFile" -NewName "$inputFileNewName"
        Return
    }

    # set the original creation date for new file
    $outputFileItem.CreationTime = $inputFileItem.CreationTime

    # rename/trash inputFile
    if ($trashInputFile -eq 1) {
        $shell = new-object -comobject "Shell.Application"
        $item = $shell.Namespace(0).ParseName("$inputFile")
        $item.InvokeVerb("delete")
    } else {
        $inputFileNewName = $inputFileItem.BaseName + $inputFileSuffix + $inputFileItem.Extension
        Rename-Item -Path "$inputFile" -NewName "$inputFileNewName"
    }
}

function Log2 {param ([double]$x) [Math]::Log($x) / [Math]::Log(2); $args }
function Log10 {param ([double]$x) [Math]::Log($x) / [Math]::Log(10); $args }



###################
### script body ###
###################

Write-Host ("given args: " + $args.Count) -ForegroundColor Green


ForEach ($path in $args) {
    #Write-Host "arg: $path" -ForegroundColor Blue

    # check if path is a directory
    if (Test-Path -Path "$path" -PathType Container) {

        # recursively send full path of all video files in this directory to ffmpeg
        gci "$path" -r -include "*.mp4","*.mkv","*.m4v" |
            foreach-object { $a = $_.FullName; (Compress-Video "$a") }
    } else {
        Compress-Video "$path"
    }
}

if ($debug -eq 1) { Pause }
