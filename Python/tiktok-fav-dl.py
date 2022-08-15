# PUT THE user_data.json IN THE SAME DIRECTORY

import json
import os
import sys

## read file

workingDir = 'S:\\Video\\TikTok\\_RIP'

file = open(sys.argv[1], "r", encoding="utf8")
j = json.loads(file.read())
file.close()

del file

## fetch information

userName = j["Profile"]["Profile Information"]["ProfileMap"]["userName"]
favVideos = j["Activity"]["Favorite Videos"]["FavoriteVideoList"]

del j

## prepare paths & dirs

favVideosDir = workingDir + "\\"+userName+"\\favVideos"

if not os.path.exists(favVideosDir):
  os.makedirs(favVideosDir)

archivedVideos = os.listdir(favVideosDir)

## download

for video in favVideos:
  videoID = video["Link"].split("/")
  videoID = videoID[len(videoID)-2]

  video["Date"] = video["Date"].replace(':','.')

  # skip if already downloaded
  known = False
  for f in archivedVideos:
    if f.find(str(videoID)) != -1:
      known = True
      break
  
  if not known:
    command = "yt-dlp " + video["Link"] + ' -o "' + favVideosDir + '\\' + video["Date"] + ' %(title)s [%(id)s].%(ext)s"\n'
    
    try:
      exitcode = os.system(command)
    except:
      print('DOWNLOAD COMMAND FAILED: ' + video["Link"])

    if exitcode != 0:
      with open(favVideosDir + '\\' + video["Date"] + ' [' + videoID + '].txt', 'w') as f:
        f.write('Download Failed. Video may be taken offline.\n' + video["Link"])
      print('dummy txt created')

input('DONE')
