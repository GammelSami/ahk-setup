# ChromeDriver MUST BE INSTALLED IN PATH

import json
import os
import sys
import time
from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC

user_data_json = sys.argv[1]
workingDir = 'S:\\Video\\TikTok\\_RIP'

## read file

file = open(user_data_json, "r", encoding="utf8")
j = json.loads(file.read())
file.close()

del file

## fetch information

userName = j["Profile"]["Profile Information"]["ProfileMap"]["userName"]
favVideos = j["Activity"]["Favorite Videos"]["FavoriteVideoList"]
favSounds = j["Activity"]["Favorite Sounds"]["FavoriteSoundList"]

del j

## prepare paths & dirs

favVideosDir = workingDir + "\\"+userName+"\\favVideos"
favSoundsDir = workingDir + "\\"+userName+"\\favSounds"

for dir in (favVideosDir, favSoundsDir):
  if not os.path.exists(dir):
    os.makedirs(dir)

archivedVideos = os.listdir(favVideosDir)
archivedSounds = os.listdir(favSoundsDir)

## download videos

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

"""

## download sounds

driver = webdriver.Chrome()

for sound in favSounds:
  soundID = sound["Link"].split("/")
  soundID = soundID[len(soundID)-1]
  soundID = soundID.replace('.html','')

  sound["Date"] = sound["Date"].replace(':','.')

# skip if already downloaded
  known = False
  for f in archivedSounds:
    if f.find(str(soundID)) != -1:
      known = True
      print('known soundID: ' + soundID)
      break

  if not known:
    # get directlink of sound
    try:
      driver.get(sound["Link"])
      
      soundDirectLink = driver.find_element_by_css_selector('[class*="DivMusicCardContainer"] video')
      soundDirectLink = soundDirectLink.get_attribute('src')
      
      soundName = driver.title.split(" | ")[0]

      driver.quit()
    except:
      print('someting went wrong while fetching directlink of: ' + sound["Link"])

    # download
    command = "yt-dlp " + soundDirectLink + ' -o "' + favSoundsDir + '\\' + sound["Date"] + ' ' + soundName +' [' + soundID + '].%(ext)s"\n'

    try:
      print('trying to download ' + soundDirectLink)
      exitcode = os.system(command)
    except:
      print('DOWNLOAD COMMAND FAILED: ' + soundDirectLink)

    if exitcode != 0:
      with open(favSoundsDir + '\\' + sound["Date"] + ' [' + soundID + '].txt', 'w') as f:
        f.write('Download Failed. Sound may be taken offline.\n' + soundDirectLink)
      print('dummy txt created')
"""
input('DONE')
