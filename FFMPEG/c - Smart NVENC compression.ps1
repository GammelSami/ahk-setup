$outputFileSuffix = ' - COMPRESSED'

$deleteInputFile = 0
$inputFileSuffix = ' - uncompressed'
$inputFileSuffixFail = ' - not COMPRESSED'


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


    # calculate bitrate by metadata

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

    # rename/delete inputFile
    if ($deleteInputFile -eq 1) {
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
