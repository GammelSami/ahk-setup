param($footageType)


#################
### functions ###
#################

Function Compress-Video {
    param (
        $inputFile
    )
    # "calculate" path of the output file
    $inputFileItem = Get-Item "$inputFile"
    $outputFile = (Split-Path "$inputFile" -Parent) + '\' + $inputFileItem.Basename + " - COMPRESSED.mp4"

    # get metadata of input file
    $metadata = ffprobe -v error -select_streams v:0 -show_entries stream=width,height,r_frame_rate -of csv=p=0 "$inputFile"
    $metadata = "$metadata" -split ','

    $width = $metadata[0]
    $height = $metadata[1]
    $fps = ($metadata[2] -split '/')[0]

    # calculate bitrate by metadata

    $bitrateLevel = 0.2
    # calculate bitrate level from resolution
    if     ( $height -le 360 )  { $bitrateLevel += 0 }
    elseif ( $height -le 480 )  { $bitrateLevel += 1 }
    elseif ( $height -le 720 )  { $bitrateLevel += 2 }
    elseif ( $height -le 1080 ) { $bitrateLevel += 3 }
    elseif ( $height -le 1440 ) { $bitrateLevel += 4 }
    elseif ( $height -le 2160 ) { $bitrateLevel += 5 }
    # calculate bitrate level from fps
    if     ( $fps -le 10 ) { $bitrateLevel += 0 }
    elseif ( $fps -le 30 ) { $bitrateLevel += 1 }
    elseif ( $fps -le 60 ) { $bitrateLevel += 2 }
    elseif ( $fps -gt 60 ) { $bitrateLevel += 3 }

    # multiply bitrateLevel by footageType
    if ($footageType -eq 'reallife') {
        echo "footage type ist wirklich real!"
    } elseif ($footageType -eq 'gameplay') {
    } elseif ($footageType -eq 'desktop') {
    }

    # write log
    Write-Host "compressing: $inputFile" -ForegroundColor Green
    Write-Host "to: $outputFile" -ForegroundColor Green

    # compression magic
    ffmpeg -i "$inputFile" -c copy "$outputFile"

    # set the original creation date for new file
    Adapt-CreationDate "$inputFile" "$outputFile"

    # rename inputFile
    $inputFileNewName = $inputFileItem.BaseName + ' - uncompressed' + $inputFileItem.Extension
    Rename-Item -Path "$inputFile" -NewName "$inputFileNewName"
}

Function Adapt-CreationDate { 
    param(
        $inputFile,
        $outputFile
    )
    $inputFile  = Get-Item "$inputFile"
    $outputFile = Get-Item "$outputFile"
    $outputFile.CreationTime = $inputFile.CreationTime
}


###################
### script body ###
###################

Write-Host ("amount of args received: " + $args.Count) -ForegroundColor Green


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



pause